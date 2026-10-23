/// Localization pipeline: sheet values in, localized rows out.
library;

import 'dart:async';
import 'dart:collection';

import '../common/sheet_layout.dart';
import 'client.dart';
import 'models.dart';
import 'prompt.dart';
import 'utils.dart';
import 'validation.dart';

/// Extract cells to be localized from the raw [values] of a sheet.
///
/// [title] is the sheet title, used for diagnostics only.
/// Column layout: `label | description | meta | <source> | <locale> ...`.
/// The fourth column is the source language (English by default, but any
/// recognized language code is accepted); rows are translated from it into the
/// locale columns that follow.
/// A sheet whose header does not match that layout is skipped entirely.
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
  if (!isLocalizationHeader(header)) {
    $err(
      'Sheet "$bucket" is not a localization sheet '
      '(expected "label | description | meta | <source> | <locale> ..." '
      'header with a recognized source language in the fourth column, '
      'got ${header.take(4).toList()}), skipping sheet...',
    );
    return const [];
  }

  // Locale columns are read exactly as `generate` reads them: sanitized,
  // parsed as a locale code and deduplicated by the normalized code. A column
  // `generate` skips ("Notes", a second "pt_br") must not be filled with
  // translations either.
  final layout = readLocaleHeader(header);
  for (final skipped in layout.skipped) {
    final column = '[${skipped.letter}]';
    $err(switch (skipped.problem) {
      HeaderCellProblem.blank => 'Sheet "$bucket" has empty column $column '
          'in header, ignoring the whole column...',
      HeaderCellProblem.notText => 'Sheet "$bucket" has non-string column '
          '$column in header, ignoring the whole column...',
      HeaderCellProblem.invalid => 'Sheet "$bucket" has "${skipped.cell}" in '
          'column $column of the header, which is not a locale code, '
          'ignoring the whole column...',
      // Localizing both would ask the model for a language twice and write
      // the answer into the first column only, leaving the second one empty
      // forever.
      HeaderCellProblem.duplicate => 'Sheet "$bucket" has a duplicate locale '
          '"${skipped.duplicateOf!.tag.code}" in column $column, '
          'ignoring the whole column...',
    });
  }

  // The fourth column is the source language every other column is translated
  // from. `isLocalizationHeader` has already vouched for it being a valid,
  // recognized locale, so it is the first column read.
  final sourceCode = layout.columns.first.tag.code;
  final locales = List.filled(header.length, '', growable: false);
  for (final column in layout.columns.skip(1)) {
    locales[column.index] = column.tag.code;
  }

  // Process locales from the sheet, skipping empty ones
  final localize = <LocalizeRow>[];
  {
    final queue = Queue<LocalizeCell>();
    for (var i = 1; i < values.length; i++) {
      final row = values[i];
      if (row.length < 4 || row.every(isBlankCell)) {
        $err('Sheet "$bucket" has empty row ${i + 1}, skipping row...');
        continue;
      }

      // Extract label, description, meta and source text from the row
      final [$label, $description, $meta, $source, ..._] = row;
      // `generate` skips a label without letters or digits ("---", " ").
      final label = $label is String ? sanitize($label) : '';
      if (label.isEmpty) {
        $err(
          'Sheet "$bucket" has empty label in row #${i + 1}, '
          'skipping row...',
        );
        continue;
      }

      // Without a source text there is nothing to translate, and `generate`
      // leaves such a row out: never translate the label instead.
      final source = _text($source);
      if (source == null) {
        $err(
          'Sheet "$bucket" has empty source text in row #${i + 1}, '
          'skipping row...',
        );
        continue;
      }

      // Extract locales from the row
      for (var j = 4; j < locales.length; j++) {
        final cell = row.length > j ? row[j] : null;
        final locale = locales[j];
        if (locale.isEmpty) continue; // Skip empty locales
        if (isBlankCell(cell)) {
          queue.add(LocalizeCell(column: j, code: locale, text: ''));
        }
        // Otherwise already localized (or a non-string cell): skip.
      }

      // Skip rows with no locales to localize
      if (queue.isEmpty) continue;
      localize.add(
        LocalizeRow(
          row: i,
          label: label,
          sourceCode: sourceCode,
          description: _text($description),
          meta: _text($meta),
          source: source,
          cells: queue.toList(growable: false),
        ),
      );
      queue.clear();
    }
  }

  return localize;
}

/// The text of a non-blank cell (a number or a boolean as text), else `null`.
String? _text(Object? cell) => switch (cell) {
      _ when isBlankCell(cell) => null,
      final String text => text,
      final Object other => '$other',
      null => null,
    };

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
        source: row.source,
        sourceCode: row.sourceCode,
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
          validateTranslation(source: row.source, translation: text);
      if (problem != null) {
        $err('Rejected "$code" for "${row.label}": $problem');
        failed.add(code);
        continue;
      }
      row.cellFor(code)?.text = text!.trim();
    }
    return failed;
  }

  final batchSize = cellsPerBatch < 1 ? 1 : cellsPerBatch;

  Future<void> localizeOne(LocalizeRow row) async {
    final codes = row.cells.map((e) => e.code).toList(growable: false);
    final retryAlone = <String>[];

    for (var i = 0; i < codes.length; i += batchSize) {
      final batch = codes.skip(i).take(batchSize).toList(growable: false);
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
