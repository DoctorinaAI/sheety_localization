/// Reads spreadsheet values into a [Catalog], reporting every problem as a
/// [Diagnostic] instead of silently dropping data.
///
/// The interpretation reproduces the previous generator (0.6.0, which wrote
/// ARB files for `flutter gen-l10n`):
///
/// * sheet titles, labels and locale header cells are sanitized
///   (`[^a-zA-Z0-9_]` -> `_`, runs merged, trimmed);
/// * the fourth column is the base language, every later column a locale;
/// * a meta cell is a JSON object in the ARB `@key` format; its
///   `description` overrides the description column;
/// * an empty cell means "not translated" (gen-l10n then falls back);
/// * missing trailing cells of a row shorter than the header (Google Sheets
///   omits trailing empty cells) are empty translations; 0.6.0 skipped such
///   rows entirely, which [ReaderOptions.includeEmpty] `false` reproduces;
/// * for a regional column (`pt_BR`) whose language has no column, a
///   synthetic parent locale (`pt`) is filled from it. A real parent column
///   (`ar`) always keeps its own texts, unless
///   [ReaderOptions.legacyRegionalOverride] reproduces 0.6.0, where the first
///   regional column of a language also overwrote it (`ar_EG` into `ar`).
///
/// Texts are ICU messages, or mustache (`{{name}}`) for the sheets
/// [ReaderOptions.syntaxFor] says so.
library;

import 'dart:convert';

import '../common/sheet_layout.dart';
import '../localize/language_names.dart';
import '../localize/sheets.dart' show SheetData;
import 'diagnostics.dart';
import 'emitter.dart' show hasLoneSurrogate;
import 'icu/ast.dart';
import 'icu/mustache.dart';
import 'icu/parser.dart';
import 'model.dart';

/// How [readCatalog] interprets the sheets.
final class ReaderOptions {
  /// Creates options. The defaults are the 1.0 behaviour; 0.6.0 is
  /// `ReaderOptions(includeEmpty: false, legacyRegionalOverride: true)`.
  const ReaderOptions({
    this.includeEmpty = true,
    this.legacyRegionalOverride = false,
    this.mustacheSheets = const [],
    this.syntax,
  });

  /// Treat the missing trailing cells of a row shorter than the header as
  /// empty translations (default). `false` skips such rows entirely with a
  /// `short-row` warning, like 0.6.0 without `--include-empty`.
  final bool includeEmpty;

  /// Let the first regional column of a language (`ar_EG`) overwrite the
  /// language's own column (`ar`) wherever the regional cell is not empty
  /// and comes later in the header, exactly like 0.6.0 (reported as
  /// `parent-overridden`). Off (default): a real parent column always keeps
  /// its own texts; only a missing parent is synthesized.
  final bool legacyRegionalOverride;

  /// Sheets whose title matches any of these use [MessageSyntax.mustache].
  final List<RegExp> mustacheSheets;

  /// Chooses the syntax of a sheet by its title; overrides
  /// [mustacheSheets] when given.
  final MessageSyntax Function(String sheetTitle)? syntax;

  /// The syntax of the sheet titled [sheetTitle].
  MessageSyntax syntaxFor(String sheetTitle) {
    final choose = syntax;
    if (choose != null) return choose(sheetTitle);
    return mustacheSheets.any((p) => p.hasMatch(sheetTitle))
        ? MessageSyntax.mustache
        : MessageSyntax.icu;
  }
}

/// The outcome of [readCatalog].
typedef ReadResult = ({Catalog catalog, List<Diagnostic> diagnostics});

/// Reads [sheets] (in spreadsheet order) into a [Catalog].
///
/// Non-localization sheets (no `<locale>` in the fourth header column, like
/// a help page or a reference table) are skipped with an info diagnostic.
/// Messages or translations with errors are left out of the catalog; the
/// diagnostics say what and where.
ReadResult readCatalog(
  Iterable<SheetData> sheets, {
  ReaderOptions options = const ReaderOptions(),
}) {
  final sink = DiagnosticSink();
  final scopes = <Scope>[];
  final titles = <String, String>{};
  for (final sheet in sheets) {
    final scope = _SheetReader(sheet, sink, options).read();
    if (scope == null) continue;
    final previous = titles[scope.name];
    if (previous != null) {
      sink.report(
        DiagnosticCode.duplicateScope,
        'Sheets "$previous" and "${sheet.title}" both map to the scope '
        '"${scope.name}"; the second one is skipped',
        scope: scope.name,
        sheetTitle: sheet.title,
      );
      continue;
    }
    titles[scope.name] = sheet.title;
    scopes.add(scope);
  }
  return (catalog: Catalog(scopes), diagnostics: sink.diagnostics);
}

final class _Column {
  const _Column(this.index, this.tag);
  final int index;
  final LocaleTag tag;
  String get letter => columnFromIndex(index);
}

/// A cell's text and parse result, computed once per cell.
final class _Cell {
  const _Cell(this.raw, this.ast);
  final String raw;
  final IcuMessage? ast;
}

final class _Draft {
  _Draft(this.key, this.row);
  final String key;
  int row;
  String? description;
  Map<String, Map<String, Object?>> declared = {};
  final Map<LocaleTag, Translation> translations = {};
}

final class _SheetReader {
  _SheetReader(this.sheet, this.sink, this.options);

  final SheetData sheet;
  final DiagnosticSink sink;
  final ReaderOptions options;
  final String Function(String) _sanitize = sanitizer();

  late final String _scope;
  late final MessageSyntax _syntax = options.syntaxFor(sheet.title);

  void _report(
    DiagnosticCode code,
    String message, {
    Severity? severity,
    int? row,
    String? column,
    String? locale,
    String? key,
    int? offset,
  }) =>
      sink.report(
        code,
        message,
        severity: severity,
        scope: _scope,
        sheetTitle: sheet.title,
        row: row,
        column: column,
        locale: locale,
        key: key,
        offset: offset,
      );

  Scope? read() {
    _scope = _sanitize(sheet.title);
    final values = sheet.values;
    if (_scope.isEmpty) {
      sink.report(
        DiagnosticCode.invalidIdentifier,
        'Sheet title "${sheet.title}" has no letters or digits, '
        'so it cannot name a scope; the sheet is skipped',
        sheetTitle: sheet.title,
      );
      return null;
    }
    final header = values.isEmpty ? const <Object?>[] : values.first;
    if (!isLocalizationHeader(header, minimumLocales: 1)) {
      final looksLikeOne = header.isNotEmpty &&
          header.first is String &&
          (header.first! as String).trim().toLowerCase() == 'label';
      if (looksLikeOne) {
        _report(
          DiagnosticCode.invalidLocale,
          'The base-language header cell D1 '
          '(${header.length > 3 ? '"${header[3]}"' : 'missing'}) is not a '
          'known language code; the sheet is skipped',
          severity: Severity.error,
          row: 1,
          column: 'D',
        );
      } else {
        _report(
          DiagnosticCode.notLocalizationSheet,
          'Not a localization sheet (expected "label | description | meta '
          '| <base locale> | <locale> ..." in row 1); skipped',
        );
      }
      return null;
    }
    if (values.length < 2) {
      _report(
        DiagnosticCode.notLocalizationSheet,
        'The sheet has a header but no rows; skipped',
      );
      return null;
    }

    final columns = _readHeader(header);
    if (columns == null) return null;
    final base = columns.first.tag;

    // Output locales and the columns feeding each of them, in column order.
    final feeds = <LocaleTag, List<_Column>>{
      for (final c in columns) c.tag: [c],
    };
    final locales = [
      for (final c in columns) ScopeLocale(c.tag, column: c.letter),
    ];
    final overridden = <LocaleTag, _Column>{};
    final handled = <String>{};
    for (final column in columns) {
      final parent = column.tag.parent;
      if (parent == null || !handled.add(parent.language)) continue;
      final own = feeds[parent];
      if (own == null) {
        feeds[parent] = [column];
        locales.add(ScopeLocale(parent, syntheticFrom: column.tag));
        _report(
          DiagnosticCode.syntheticLocale,
          'No "${parent.code}" column: locale "${parent.code}" is generated '
          'from column ${column.letter} "${column.tag.code}"',
          locale: parent.code,
          column: column.letter,
        );
      } else if (options.legacyRegionalOverride &&
          parent.language.length == 2) {
        // 0.6.0 pushed the first regional column of a language into the
        // language's own locale too; the later column in the header wins.
        own
          ..add(column)
          ..sort((a, b) => a.index.compareTo(b.index));
        overridden[parent] = column;
      }
    }

    if (hasLoneSurrogate(sheet.title)) {
      _report(
        DiagnosticCode.invalidUnicode,
        'The sheet title contains a lone UTF-16 surrogate (not valid '
        'Unicode); comments of the generated code show U+FFFD instead',
      );
    }
    for (var i = 1; i < values.length; i++) {
      final row = values[i];
      for (var j = 0; j < row.length && j < header.length; j++) {
        if (row[j] case final String text when hasLoneSurrogate(text)) {
          _report(
            DiagnosticCode.invalidUnicode,
            'The cell contains a lone UTF-16 surrogate (not valid Unicode); '
            'string values keep it as an escape, comments and docstrings '
            'show U+FFFD instead. Retype the text',
            row: i + 1,
            column: columnFromIndex(j),
          );
        }
      }
    }

    final drafts = <String, _Draft>{};
    final cells = <(int, int), _Cell?>{};
    final replaced = <LocaleTag, int>{};
    final filled = <LocaleTag, int>{};

    for (var i = 1; i < values.length; i++) {
      final rowNumber = i + 1;
      var row = values[i];
      if (row.every(isBlankCell)) {
        _report(
          DiagnosticCode.emptyRow,
          'Empty row; skipped',
          row: rowNumber,
        );
        continue;
      }
      if (row.length < header.length) {
        if (!options.includeEmpty) {
          _report(
            DiagnosticCode.shortRow,
            'The row has ${row.length} cells but the header has '
            '${header.length} (Google Sheets omits trailing empty cells, so '
            'the last locale, ${columnFromIndex(header.length - 1)}, is '
            'empty); the whole row is skipped, as the previous generator '
            'did. Fill the cell or enable include-empty',
            row: rowNumber,
          );
          continue;
        }
        row = [
          ...row,
          ...List<Object?>.filled(header.length - row.length, null)
        ];
      }
      final label = row.first;
      if (label is! String || label.trim().isEmpty) {
        _report(
          DiagnosticCode.emptyLabel,
          'The row has no label (column A); skipped',
          row: rowNumber,
          column: 'A',
        );
        continue;
      }
      final key = _sanitize(label);
      if (key.isEmpty) {
        _report(
          DiagnosticCode.invalidIdentifier,
          'Label "$label" has no letters or digits; the row is skipped',
          row: rowNumber,
          column: 'A',
        );
        continue;
      }

      var draft = drafts[key];
      if (draft != null) {
        _report(
          DiagnosticCode.duplicateLabel,
          'Label "$label" duplicates row ${draft.row} '
          '(both are "$key" after sanitizing); every label must be unique '
          '(the previous generator silently let the later row overwrite '
          'the texts it has)',
          row: rowNumber,
          column: 'A',
          key: key,
        );
      } else {
        draft = drafts[key] = _Draft(key, rowNumber);
      }

      // Base text: required.
      final baseCell = _cell(cells, row, rowNumber, columns.first, key);
      if (baseCell == null) {
        final exists = _text(row, columns.first.index) != null;
        if (!exists) {
          _report(
            DiagnosticCode.emptyBase,
            'The base-language (${base.code}) text is empty; the message is '
            'left out (gen-l10n dropped it from every locale)',
            row: rowNumber,
            column: columns.first.letter,
            locale: base.code,
            key: key,
          );
        }
        // Still report the problems of the other cells of the row.
        for (final column in columns.skip(1)) {
          _cell(cells, row, rowNumber, column, key);
        }
        if (draft.translations.isEmpty) drafts.remove(key);
        continue;
      }

      // Description and meta of the row (the later duplicate wins).
      final description = switch (row[1]) {
        final String text when !isBlankCell(text) => text,
        final num number => '$number',
        _ => null,
      };
      final meta = _meta(row[2], rowNumber, key);
      draft
        ..description = switch (meta?['description']) {
          final String text => text,
          _ => description,
        }
        ..declared = _declared(meta, rowNumber, key);

      for (final MapEntry(key: locale, value: sources) in feeds.entries) {
        _Column? from;
        _Cell? cell;
        for (final column in sources) {
          final c = _cell(cells, row, rowNumber, column, key);
          if (c != null) {
            from = column;
            cell = c;
          } else if (_text(row, column.index) != null) {
            // The cell has text that does not parse: reported already. The
            // locale stays untranslated rather than taking another column.
            from = null;
            cell = null;
          }
        }
        final regional = overridden[locale];
        if (regional != null && from == regional) {
          final own =
              _text(row, sources.firstWhere((c) => c.tag == locale).index);
          if (own == null) {
            filled[locale] = (filled[locale] ?? 0) + 1;
          } else if (own != cell!.raw) {
            replaced[locale] = (replaced[locale] ?? 0) + 1;
          }
        }
        if (from == null || cell == null) continue;
        draft.translations[locale] = Translation(
          locale: locale,
          source: from.tag,
          raw: cell.raw,
          ast: cell.ast!,
          row: rowNumber,
          column: from.letter,
        );
      }
    }

    for (final MapEntry(key: parent, value: regional) in overridden.entries) {
      final r = replaced[parent] ?? 0;
      final f = filled[parent] ?? 0;
      if (r == 0 && f == 0) continue;
      final column = locales.firstWhere((l) => l.tag == parent).column;
      _report(
        DiagnosticCode.parentOverridden,
        'Locale "${parent.code}" takes the text of column '
        '${regional.letter} "${regional.tag.code}" instead of its own '
        'column $column in $r row(s) and fills $f empty cell(s) from it — '
        'the previous generator did this; disable legacy-regional-override '
        'to keep "${parent.code}" as written',
        locale: parent.code,
        column: column,
      );
    }

    final messages = <Message>[];
    for (final draft in drafts.values) {
      final message = _message(draft, base, locales);
      if (message != null) messages.add(message);
    }
    return Scope(
      name: _scope,
      sheetTitle: sheet.title,
      baseLocale: base,
      locales: locales,
      messages: messages,
      syntax: _syntax,
    );
  }

  /// Valid locale columns, base first; `null` when the base is unusable.
  ///
  /// The columns are read by [readLocaleHeader], shared with `localize`, so
  /// both executables agree on which columns are locales.
  List<_Column>? _readHeader(List<Object?> header) {
    final layout = readLocaleHeader(header);
    final valid = {for (final c in layout.columns) c.index: c};
    final skippedAt = {for (final s in layout.skipped) s.index: s};
    final columns = <_Column>[];
    // Reported in column order.
    for (var i = 3; i < header.length; i++) {
      final letter = columnFromIndex(i);
      final column = valid[i];
      if (column != null) {
        final tag = column.tag;
        if (resolveLanguageName(tag.code) == null) {
          _report(
            DiagnosticCode.unknownLocale,
            'Language "${tag.language}" of "${header[i]}" is not a known '
            'ISO 639 code; the column is used anyway',
            row: 1,
            column: letter,
            locale: tag.code,
          );
        }
        columns.add(_Column(i, tag));
        continue;
      }
      final skipped = skippedAt[i]!;
      final severity = i == 3 ? Severity.error : null;
      switch (skipped.problem) {
        case HeaderCellProblem.blank || HeaderCellProblem.notText:
          final hasData = sheet.values
              .skip(1)
              .any((row) => row.length > i && !isBlankCell(row[i]));
          if (i != 3 && !hasData) continue;
          _report(
            DiagnosticCode.invalidLocale,
            'Column $letter has data but no locale code in row 1; the column '
            'is skipped',
            severity: severity,
            row: 1,
            column: letter,
          );
        case HeaderCellProblem.invalid:
          _report(
            DiagnosticCode.invalidLocale,
            '"${skipped.cell}" is not a locale code (expected "en", "pt_BR", '
            '"zh_Hant" or "zh_Hant_TW"); the column is skipped',
            severity: severity,
            row: 1,
            column: letter,
          );
        case HeaderCellProblem.duplicate:
          final duplicate = skipped.duplicateOf!;
          _report(
            DiagnosticCode.duplicateLocale,
            'Locale "${duplicate.tag.code}" already is column '
            '${duplicate.letter}; the column is skipped',
            row: 1,
            column: letter,
            locale: duplicate.tag.code,
          );
      }
      if (i == 3) return null;
    }
    return columns;
  }

  /// The text of a cell, or `null` when it is empty or whitespace only.
  String? _text(List<Object?> row, int index) {
    if (index >= row.length) return null;
    return switch (row[index]) {
      final Object? cell when isBlankCell(cell) => null,
      final String text => text,
      final Object other => '$other',
      null => null,
    };
  }

  /// The parsed cell, or `null` when it is empty or does not parse (then an
  /// error is reported, once per cell).
  _Cell? _cell(
    Map<(int, int), _Cell?> cache,
    List<Object?> row,
    int rowNumber,
    _Column column,
    String key,
  ) {
    final id = (rowNumber, column.index);
    if (cache.containsKey(id)) return cache[id];
    final raw = _text(row, column.index);
    if (raw == null) return cache[id] = null;
    final value = row[column.index];
    if (value is! String) {
      _report(
        DiagnosticCode.nonStringCell,
        'The cell holds a ${value.runtimeType}; its text "$raw" is used',
        row: rowNumber,
        column: column.letter,
        locale: column.tag.code,
        key: key,
      );
    }
    try {
      return cache[id] = _Cell(raw, parseMessage(raw, _syntax));
    } on IcuSyntaxException catch (e) {
      final hint = _syntax == MessageSyntax.icu && looksLikeMustache(raw)
          ? '\nThis looks like mustache syntax ({{name}}); mark the sheet '
              'as mustache in the config'
          : '';
      _report(
        e.kind == IcuErrorKind.missingOther
            ? DiagnosticCode.pluralMissingOther
            : DiagnosticCode.icuSyntax,
        '${e.message} at offset ${e.offset}:\n${_indent(e.excerpt)}$hint',
        row: rowNumber,
        column: column.letter,
        locale: column.tag.code,
        key: key,
        offset: e.offset,
      );
      return cache[id] = null;
    }
  }

  Map<String, Object?>? _meta(Object? cell, int rowNumber, String key) {
    void invalid(String why) => _report(
          DiagnosticCode.invalidMetaJson,
          'The meta cell $why; it is ignored',
          row: rowNumber,
          column: 'C',
          key: key,
        );
    switch (cell) {
      case null:
        return null;
      case final String text when text.trim().isEmpty:
        return null;
      case final String text:
        final trimmed = text.trim();
        if (!trimmed.startsWith('{') || !trimmed.endsWith('}')) {
          invalid('is not a JSON object');
          return null;
        }
        try {
          final json = jsonDecode(trimmed);
          if (json is Map<String, Object?>) return json;
          invalid('is not a JSON object');
        } on FormatException catch (e) {
          invalid('is not valid JSON (${e.message})');
        }
        return null;
      case final Map<String, Object?> map:
        return map;
      default:
        invalid('is a ${cell.runtimeType}, not a JSON object');
        return null;
    }
  }

  /// Declared placeholders of the meta JSON, in declaration order, with
  /// unsupported attributes reported.
  Map<String, Map<String, Object?>> _declared(
    Map<String, Object?>? meta,
    int rowNumber,
    String key,
  ) {
    if (meta == null) return const {};
    void unsupported(String why) => _report(
          DiagnosticCode.unsupportedMeta,
          why,
          row: rowNumber,
          column: 'C',
          key: key,
        );
    final description = meta['description'];
    if (description != null && description is! String) {
      unsupported('"description" must be a string');
    }
    final placeholders = meta['placeholders'];
    if (placeholders == null) return const {};
    if (placeholders is! Map<String, Object?>) {
      _report(
        DiagnosticCode.invalidMetaJson,
        '"placeholders" must be a JSON object; it is ignored',
        row: rowNumber,
        column: 'C',
        key: key,
      );
      return const {};
    }
    final result = <String, Map<String, Object?>>{};
    for (final MapEntry(key: name, value: attributes) in placeholders.entries) {
      if (attributes is! Map<String, Object?>) {
        _report(
          DiagnosticCode.invalidMetaJson,
          'Placeholder "$name" must be a JSON object; it is ignored',
          row: rowNumber,
          column: 'C',
          key: key,
        );
        continue;
      }
      final type = attributes['type'];
      if (type != null) {
        if (type is! String) {
          unsupported('Placeholder "$name": "type" must be a string');
        } else if (type == 'DateTime') {
          unsupported('Placeholder "$name": type "DateTime" is not supported; '
              'pass a preformatted String instead');
        } else if (PlaceholderType.fromArb(type) == null) {
          unsupported('Placeholder "$name": type "$type" is not supported '
              '(use String, int, num, double or Object)');
        }
      }
      for (final attribute in const [
        'format',
        'optionalParameters',
        'isCustomDateFormat',
      ]) {
        if (attributes.containsKey(attribute)) {
          unsupported('Placeholder "$name": "$attribute" is not supported; '
              'pass a preformatted String instead');
        }
      }
      result[name] = attributes;
    }
    return result;
  }

  Message? _message(
    _Draft draft,
    LocaleTag base,
    List<ScopeLocale> locales,
  ) {
    if (!draft.translations.containsKey(base)) return null;
    // gen-l10n infers placeholders from every locale's message.
    final used = <String>{};
    final plural = <String>{};
    final select = <String>{};
    for (final translation in draft.translations.values) {
      for (final use in translation.ast.placeholderUses) {
        used.add(use.name);
        switch (use.usage) {
          case IcuPlaceholderUsage.plural:
            plural.add(use.name);
          case IcuPlaceholderUsage.select:
            select.add(use.name);
          case IcuPlaceholderUsage.argument:
            break;
        }
      }
    }
    final undeclared =
        used.where((n) => !draft.declared.containsKey(n)).toList()..sort();
    final placeholders = <Placeholder>[];
    var hasErrors = false;
    void typeError(String message) {
      hasErrors = true;
      _report(
        DiagnosticCode.placeholderType,
        message,
        row: draft.row,
        column: 'C',
        key: draft.key,
      );
    }

    for (final name in [...draft.declared.keys, ...undeclared]) {
      final attributes = draft.declared[name];
      final declaredType = switch (attributes?['type']) {
        final String type => PlaceholderType.fromArb(type),
        _ => null,
      };
      final isPlural = plural.contains(name);
      final isSelect = select.contains(name);
      PlaceholderType type;
      if (isPlural && isSelect) {
        typeError('Placeholder "$name" is used both as a plural count and as '
            'a select choice');
        type = PlaceholderType.object;
      } else if (isPlural) {
        type = declaredType ?? PlaceholderType.num;
        if (type != PlaceholderType.num && type != PlaceholderType.int) {
          typeError('Placeholder "$name" is a plural count, so its type must '
              'be num or int (gen-l10n rejects ${type.arbName})');
        }
      } else if (isSelect) {
        type = declaredType ?? PlaceholderType.string;
        if (type != PlaceholderType.string) {
          typeError('Placeholder "$name" is a select choice, so its type must '
              'be String (gen-l10n rejects ${type.arbName})');
        }
      } else {
        type = declaredType ?? PlaceholderType.object;
      }
      placeholders.add(Placeholder(
        name: name,
        type: type,
        example: _string(attributes?['example']),
        description: _string(attributes?['description']),
        declared: attributes != null,
        isPluralCount: isPlural,
        isSelectChoice: isSelect,
      ));
    }
    if (hasErrors) return null;
    return Message(
      key: draft.key,
      baseLocale: base,
      description: draft.description,
      placeholders: placeholders,
      translations: {
        for (final locale in locales)
          if (draft.translations[locale.tag] case final Translation t)
            locale.tag: t,
      },
      row: draft.row,
    );
  }

  static String? _string(Object? value) => switch (value) {
        null => null,
        final String text => text,
        final Object other => '$other',
      };

  static String _indent(String text) =>
      text.split('\n').map((l) => '      $l').join('\n');
}
