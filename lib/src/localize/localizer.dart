/// Localization pipeline: sheet values in, localized rows out.
library;

import 'dart:async';
import 'dart:collection';

import 'client.dart';
import 'models.dart';
import 'prompt.dart';
import 'utils.dart';
import 'validation.dart';

/// Extract cells to be localized from the raw [values] of a sheet.
///
/// [title] is the sheet title, used for diagnostics only.
/// Column layout: `label | description | meta | en | <locale> ...`.
List<LocalizeRow> extractEmptyCells({
  required String title,
  required List<List<Object?>> values,
}) {
  final sanitize = sanitizer();

  final bucket = sanitize(title);
  if (bucket.isEmpty) {
    $err('Sheet title is empty, skipping sheet...');
    return const [];
  }
  if (values.isEmpty) return const [];

  final header = values.first;

  // Fill locales
  final locales = List.filled(header.length, '', growable: false);
  for (var i = 3; i < header.length; i++) {
    final cell = header[i];
    switch (cell) {
      case String text when text.isNotEmpty:
        locales[i] = sanitize(text);
      case String _:
        $err(
          'Sheet "$bucket" has empty column '
          '[${columnFromIndex(i)}] in header, '
          'ignore the whole column...',
        );
        continue;
      default:
        $err(
          'Sheet "$bucket" has non-string column '
          '[${columnFromIndex(i)}] in header, '
          'ignore whole column...',
        );
        continue;
    }
  }

  // Process locales from the sheet, skipping empty ones
  final localize = <LocalizeRow>[];
  {
    final queue = Queue<LocalizeCell>();
    for (var i = 1; i < values.length; i++) {
      final row = values[i];
      if (row.isEmpty || row.every((cell) => cell == null) || row.length < 4) {
        $err('Sheet "$bucket" has empty row ${i + 1}, skipping row...');
        continue;
      }

      // Extract label, description, and meta from the row
      final [$label, $description, $meta, $english, ..._] = row;
      if ($label == null || $label is! String || $label.isEmpty) {
        $err(
          'Sheet "$bucket" has empty label in row #${i + 1}, '
          'skipping row...',
        );
        continue;
      }
      final label = sanitize($label);

      // Extract locales from the row
      for (var j = 4; j < locales.length; j++) {
        final cell = row.length > j ? row[j] : null;
        final locale = locales[j];
        if (locale.isEmpty) continue; // Skip empty locales
        switch (cell) {
          case null:
            queue.add(LocalizeCell(column: j, code: locale, text: ''));
          case String text when text.isNotEmpty:
            continue; // Already localized, skip
          case String():
            queue.add(LocalizeCell(column: j, code: locale, text: ''));
          case num():
          default:
            continue; // Skip non-string cells
        }
      }

      // Skip rows with no locales to localize
      if (queue.isEmpty) continue;
      localize.add(
        LocalizeRow(
          row: i,
          label: label,
          description: switch ($description) {
            String text when text.isNotEmpty => text,
            num number => number.toString(),
            _ => null,
          },
          meta: switch ($meta) {
            String text when text.isNotEmpty => text,
            num number => number.toString(),
            _ => null,
          },
          english: switch ($english) {
            String text when text.isNotEmpty => text,
            num number => number.toString(),
            _ => label,
          },
          cells: queue.toList(growable: false),
        ),
      );
      queue.clear();
    }
  }

  return localize;
}

/// Localize rows using the OpenAI API.
///
/// [rows] - The rows to localize.
/// [client] - The client performing the requests.
/// [cellsPerBatch] - How many languages go into a single request.
///
/// Every row is dispatched concurrently; the client's semaphore caps the
/// number of simultaneous requests. A row is emitted as soon as it is done —
/// including partially localized rows, so that the languages that *did* work
/// are still written to the sheet.
///
/// Failure handling: when a batch of languages fails (timeout, unparseable
/// JSON, a language the model choked on, a translation that lost its
/// placeholders), the batch is **not** retried as a whole. Instead every failed
/// language is retried on its own, so a single problematic rare language
/// cannot take its neighbours down with it.
Stream<LocalizeRow> localizeRows({
  required List<LocalizeRow> rows,
  required LocalizationClient client,
  int cellsPerBatch = 3,
}) {
  /// Translate [languages] of [row] in one request.
  /// Returns the languages that could not be localized.
  Future<List<String>> translate(
      LocalizeRow row, List<String> languages) async {
    final LocalizationResponse data;
    try {
      final (:prompt, :schema) = buildLocalizationPrompt(
        label: row.label,
        en: row.english,
        description: row.description,
        meta: row.meta,
        languages: languages,
      );
      data = await client(prompt: prompt, schema: schema);
    } on Object catch (e) {
      $err('Failed to localize "${row.label}" '
          '[${languages.join(', ')}]: $e');
      return languages;
    }

    if (data.label != row.label)
      $err('Mismatched label in response for "${row.label}": '
          'got "${data.label}", ignoring the mismatch');

    // Apply language by language: one bad translation only invalidates itself.
    final failed = <String>[];
    for (final code in languages) {
      final text = switch (data.localization[code]) {
        {'text': String text} => text,
        _ => null,
      };
      final problem =
          validateTranslation(source: row.english, translation: text);
      if (problem != null) {
        $err('Rejected "$code" for "${row.label}": $problem');
        failed.add(code);
        continue;
      }
      row.cellFor(code)?.text = text!.trim();
    }
    return failed;
  }

  Future<void> localizeOne(LocalizeRow row) async {
    final codes = row.cells.map((e) => e.code).toList(growable: false);
    final retryAlone = <String>[];

    for (var i = 0; i < codes.length; i += cellsPerBatch) {
      final batch = codes.skip(i).take(cellsPerBatch).toList(growable: false);
      if (batch.isEmpty) break;
      final failed = await translate(row, batch);
      if (failed.isEmpty) continue;
      if (batch.length == 1) {
        // Already a single-language request: splitting further is impossible.
        $err('Giving up on "${failed.single}" for "${row.label}"');
        continue;
      }
      retryAlone.addAll(failed);
    }

    if (retryAlone.isEmpty) return;
    $log('Retrying ${retryAlone.length} language(s) one by one '
        'for "${row.label}": ${retryAlone.join(', ')}');
    for (final code in retryAlone) {
      final failed = await translate(row, <String>[code]);
      if (failed.isNotEmpty)
        $err('Giving up on "$code" for "${row.label}" after fallback retry');
    }
  }

  // Dispatch every row concurrently and emit each one as soon as it finishes.
  if (rows.isEmpty) return const Stream<LocalizeRow>.empty();
  final controller = StreamController<LocalizeRow>();
  var pending = rows.length;
  for (final row in rows) {
    Future<void>(() async {
      try {
        await localizeOne(row);
        if (row.hasLocalizedCells) controller.add(row);
      } on Object catch (e) {
        $err('Error localizing row "${row.label}": $e');
      } finally {
        pending--;
        if (pending == 0) controller.close().ignore();
      }
    });
  }
  return controller.stream;
}
