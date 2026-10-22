import 'package:sheety_localization/sheety_localization.dart';
import 'package:test/test.dart';

void main() {
  final logOut = $log, errOut = $err;
  setUp(() {
    $log = (_) {};
    $err = (_) {};
  });
  tearDown(() {
    $log = logOut;
    $err = errOut;
  });

  group('extractEmptyCells', () {
    const header = <Object?>['label', 'description', 'meta', 'en', 'uk', 'ru'];

    test('collects only the empty locale cells', () {
      final rows = extractEmptyCells(
        title: 'app',
        values: <List<Object?>>[
          header,
          ['greeting', 'Main screen', '{name}', 'Hello', null, 'Привет'],
          ['bye', null, null, 'Bye', 'Бувай', 'Пока'], // fully localized
          ['thanks', null, null, 'Thanks', '', ''],
        ],
      );

      expect(rows.map((r) => r.label), ['greeting', 'thanks']);

      final greeting = rows.first;
      expect(greeting.row, 1);
      expect(greeting.source, 'Hello');
      expect(greeting.sourceCode, 'en');
      expect(greeting.description, 'Main screen');
      expect(greeting.meta, '{name}');
      expect(greeting.cells.map((c) => c.code), ['uk']);
      expect(greeting.cells.single.column, 4);

      final thanks = rows.last;
      expect(thanks.cells.map((c) => c.code), ['uk', 'ru']);
      expect(thanks.description, isNull);
    });

    test('sanitizes labels and locale codes', () {
      final rows = extractEmptyCells(
        title: 'app',
        values: <List<Object?>>[
          ['label', 'description', 'meta', 'en', 'pt-BR'],
          ['some label!', null, null, 'Hello', null],
        ],
      );
      expect(rows.single.label, 'some_label');
      expect(rows.single.cells.single.code, 'pt_BR');
      expect(resolveLanguageName(rows.single.cells.single.code),
          'Brazilian Portuguese');
    });

    test('skips a row whose source text is empty or blank', () {
      // `generate` leaves such a row out; translating the label instead would
      // fill the sheet with translations of a key nobody wrote a text for.
      final rows = extractEmptyCells(
        title: 'app',
        values: <List<Object?>>[
          header,
          ['greeting', null, null, null, null, null],
          ['bye', null, null, '  ', null, null],
          ['thanks', null, null, 'Thanks', null, null],
        ],
      );
      expect(rows.map((r) => r.label), ['thanks']);
    });

    test('treats whitespace-only cells as empty', () {
      final rows = extractEmptyCells(
        title: 'app',
        values: <List<Object?>>[
          header,
          [' ', null, null, 'Hello', null, null], // blank label
          ['  ', ' ', ' ', ' ', ' ', ' '], // blank row
          ['greeting', ' ', '\t', 'Hello', ' ', 'Привет'],
        ],
      );
      final greeting = rows.single;
      expect(greeting.label, 'greeting');
      // A target cell holding just a space is not a translation.
      expect(greeting.cells.map((c) => c.code), ['uk']);
      expect(greeting.description, isNull);
      expect(greeting.meta, isNull);
    });

    test('reads locale columns exactly as generate does', () {
      // "pt BR" is pt_BR, "Notes" is not a locale and "pt_br" duplicates
      // pt_BR: generate skips the last two, so localize must not fill them.
      final values = <List<Object?>>[
        ['label', 'description', 'meta', 'en', 'pt BR', 'Notes', 'pt_br'],
        ['greeting', null, null, 'Hello', null, null, null],
      ];
      final rows = extractEmptyCells(title: 'app', values: values);
      expect(
        rows.single.cells.map((c) => (c.code, c.column)),
        [('pt_BR', 4)],
      );

      final read = readCatalog([(title: 'app', values: values)]);
      final scope = read.catalog.scopes.single;
      expect(
        [
          for (final l in scope.locales)
            if (l.column != null) l.tag.code
        ],
        ['en', ...rows.single.cells.map((c) => c.code)],
      );
    });

    test('accepts a source column D1 written with a space', () {
      final rows = extractEmptyCells(
        title: 'app',
        values: <List<Object?>>[
          ['label', 'description', 'meta', 'pt BR', 'en'],
          ['greeting', null, null, 'Olá', null],
        ],
      );
      expect(rows.single.sourceCode, 'pt_BR');
    });

    test('accepts a non-English source language and carries its code', () {
      // The source column is `ru`, not `en`: the sheet must still be
      // localized, translating the Russian source into the other columns.
      final rows = extractEmptyCells(
        title: 'auth',
        values: <List<Object?>>[
          ['label', 'description', 'meta', 'ru', 'en', 'uk'],
          ['greeting', null, null, 'Привет', null, null],
        ],
      );
      expect(rows.single.sourceCode, 'ru');
      expect(rows.single.source, 'Привет');
      expect(rows.single.cells.map((c) => c.code), ['en', 'uk']);
    });

    test('normalizes the source language code from the header', () {
      final rows = extractEmptyCells(
        title: 'auth',
        values: <List<Object?>>[
          ['label', 'description', 'meta', 'pt-BR', 'en'],
          ['greeting', null, null, 'Olá', null],
        ],
      );
      expect(rows.single.sourceCode, 'pt_BR');
    });

    test('skips malformed rows', () {
      final rows = extractEmptyCells(
        title: 'app',
        values: <List<Object?>>[
          header,
          <Object?>[], // empty
          [null, null, null, null], // no label
          ['short'], // too few columns
          ['greeting', null, null, 'Hello', null, null],
        ],
      );
      expect(rows.map((r) => r.label), ['greeting']);
      expect(rows.single.row, 4);
    });

    test('ignores a column whose locale duplicates an earlier one', () {
      // "pt-BR" and "pt_BR" sanitize to the same code: localizing both would
      // ask the model for the language twice and write the answer into the
      // first column only, leaving the second empty forever.
      final rows = extractEmptyCells(
        title: 'app',
        values: <List<Object?>>[
          ['label', 'description', 'meta', 'en', 'pt-BR', 'pt_BR', 'ru '],
          ['greeting', null, null, 'Hello', null, null, null],
        ],
      );
      expect(
        rows.single.cells.map((c) => (c.code, c.column)),
        [('pt_BR', 4), ('ru', 6)],
      );
    });

    test('ignores columns without a locale in the header', () {
      final rows = extractEmptyCells(
        title: 'app',
        values: <List<Object?>>[
          ['label', 'description', 'meta', 'en', '', 'ru'],
          ['greeting', null, null, 'Hello', null, null],
        ],
      );
      expect(rows.single.cells.map((c) => c.code), ['ru']);
    });

    test('returns nothing for an empty sheet', () {
      expect(extractEmptyCells(title: 'app', values: const []), isEmpty);
      expect(extractEmptyCells(title: '', values: const []), isEmpty);
    });

    test('refuses to localize a sheet that is not a localization table', () {
      // A reference table living in the same spreadsheet: its columns are
      // data, not locales. Translating it would overwrite the data.
      final rows = extractEmptyCells(
        title: 'locales',
        values: <List<Object?>>[
          [
            'Language',
            'Total Speakers',
            'Native Speakers',
            'Language Family',
            'Primary Countries/Regions',
            'ISO 639-3',
          ],
          ['Polish', null, null, null, null, null],
        ],
      );
      expect(rows, isEmpty);
    });
  });

  group('readLocaleHeader', () {
    test('sanitizes, normalizes and deduplicates locale columns', () {
      final layout = readLocaleHeader(const [
        'label',
        'description',
        'meta',
        'en',
        'pt BR',
        'Notes',
        'pt_br',
        ' ',
        42,
        'zh-hant',
      ]);
      expect(
        [for (final c in layout.columns) (c.letter, c.tag.code)],
        [('D', 'en'), ('E', 'pt_BR'), ('J', 'zh_Hant')],
      );
      expect(
        [for (final s in layout.skipped) (s.letter, s.problem)],
        [
          ('F', HeaderCellProblem.invalid),
          ('G', HeaderCellProblem.duplicate),
          ('H', HeaderCellProblem.blank),
          ('I', HeaderCellProblem.notText),
        ],
      );
      expect(layout.skipped[1].duplicateOf!.letter, 'E');
    });
  });

  group('isBlankCell', () {
    test('null and whitespace-only strings are blank', () {
      expect(isBlankCell(null), isTrue);
      expect(isBlankCell(''), isTrue);
      expect(isBlankCell(' \t\n'), isTrue);
      expect(isBlankCell(' x '), isFalse);
      expect(isBlankCell(0), isFalse);
    });
  });

  group('isLocalizationHeader', () {
    test('accepts the documented layout', () {
      expect(
        isLocalizationHeader(
          const ['label', 'description', 'meta', 'en', 'uk'],
        ),
        isTrue,
      );
      expect(
        isLocalizationHeader(
          const ['key', 'desc', 'placeholders', 'en_US', 'ru'],
        ),
        isTrue,
      );
    });

    test('accepts any recognized source language, not only English', () {
      expect(
        isLocalizationHeader(
          const ['label', 'description', 'meta', 'ru', 'en'],
        ),
        isTrue,
      );
      expect(
        isLocalizationHeader(
          const ['label', 'description', 'meta', 'pt-BR', 'en'],
        ),
        isTrue,
      );
    });

    test('reads D1 like every other locale header cell', () {
      expect(
        isLocalizationHeader(
          const ['label', 'description', 'meta', 'pt BR', 'en'],
        ),
        isTrue,
      );
      expect(
        isLocalizationHeader(
          const ['label', 'description', 'meta', ' en ', 'de'],
        ),
        isTrue,
      );
    });

    test('rejects a sheet whose fourth column is not a language', () {
      // A reference/data table: `Family` is not a locale, so the sheet must be
      // left alone rather than overwritten with translations.
      expect(
        isLocalizationHeader(
          const ['Language', 'Total', 'Native', 'Family', 'Regions'],
        ),
        isFalse,
      );
    });

    test('rejects a header without locale columns', () {
      expect(
        isLocalizationHeader(const ['label', 'description', 'meta', 'en']),
        isFalse,
      );
      expect(isLocalizationHeader(const []), isFalse);
    });
  });

  group('columnFromIndex', () {
    test('maps indices to spreadsheet columns', () {
      expect(columnFromIndex(0), 'A');
      expect(columnFromIndex(25), 'Z');
      expect(columnFromIndex(26), 'AA');
      expect(columnFromIndex(51), 'AZ');
      expect(columnFromIndex(701), 'ZZ');
      expect(columnFromIndex(702), 'AAA');
    });

    test('rejects a negative index', () {
      expect(() => columnFromIndex(-1), throwsArgumentError);
    });
  });

  group('sanitizer', () {
    test('keeps only identifier characters', () {
      final sanitize = sanitizer();
      expect(sanitize('Hello World'), 'Hello_World');
      expect(sanitize('__a--b__'), 'a_b');
      expect(sanitize('pt-BR'), 'pt_BR');
      expect(sanitize('!!!'), '');
    });
  });
}
