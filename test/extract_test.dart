import 'package:sheety_localization/localize.dart';
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
      expect(greeting.english, 'Hello');
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

    test('falls back to the label when the English cell is empty', () {
      final rows = extractEmptyCells(
        title: 'app',
        values: <List<Object?>>[
          header,
          ['greeting', null, null, null, null, null],
        ],
      );
      expect(rows.single.english, 'greeting');
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

    test('rejects a sheet whose fourth column is not English', () {
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
