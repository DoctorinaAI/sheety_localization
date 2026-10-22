import 'package:test/test.dart';

import '../sheety.dart';
import 'helpers.dart';

const _header = ['label', 'description', 'meta', 'en', 'de'];

ReadResult read(
  List<List<Object?>> rows, {
  List<Object?> header = _header,
  ReaderOptions options = const ReaderOptions(),
  String title = 'app',
}) =>
    readCatalog(sheet(title, [header, ...rows]), options: options);

Iterable<Diagnostic> only(ReadResult r, DiagnosticCode code) =>
    r.diagnostics.where((d) => d.code == code);

void main() {
  group('fixture', () {
    final result =
        readCatalog(loadSnapshot('test/fixtures/basic_snapshot.json'));
    final catalog = result.catalog;

    test('scopes in sheet order, help skipped', () {
      expect(catalog.scopes.map((s) => s.name), ['app', 'sign_up']);
      expect(catalog.scope('sign_up')!.sheetTitle, 'sign-up');
      expect(codes(result.diagnostics.where((d) => d.scope == 'help')),
          ['not-localization-sheet']);
      expect(result.diagnostics.where((d) => d.isError), isEmpty);
    });

    test('locales: header order, synthetic parents appended', () {
      final app = catalog.scope('app')!;
      expect(app.localeTags.map((l) => l.code),
          ['en', 'ru', 'pt_BR', 'ar', 'ar_EG', 'de', 'pt']);
      expect(app.locale(LocaleTag.parse('pt'))!.syntheticFrom?.code, 'pt_BR');
      expect(app.locale(LocaleTag.parse('de'))!.column, 'I');
      expect(app.syntheticLocales.keys.map((l) => l.code), ['pt']);
      expect(catalog.locales.map((l) => l.code),
          ['en', 'ru', 'pt_BR', 'ar', 'ar_EG', 'de', 'pt']);
    });

    test('messages, descriptions and placeholders', () {
      final app = catalog.scope('app')!;
      expect(app.messages.map((m) => m.key), [
        'title',
        'greeting',
        'items',
        'pronoun',
        'terms',
        'special',
        'lastSeen',
      ]);
      final greeting = app.message('greeting')!;
      expect(greeting.description, 'Greets the user');
      expect(greeting.placeholders.single.toJson(), {
        'name': 'name',
        'type': 'String',
        'example': 'Bob',
        'description': 'User name',
        'declared': true,
      });
      // The meta description overrides the description column.
      final items = app.message('items')!;
      expect(items.description, 'Number of items in the cart');
      expect(items.placeholders.single.type, PlaceholderType.int);
      expect(items.placeholders.single.isPluralCount, isTrue);
      final pronoun = app.message('pronoun')!.placeholders.single;
      expect(pronoun.type, PlaceholderType.string);
      expect(pronoun.declared, isFalse);
      expect(pronoun.isSelectChoice, isTrue);
      final lastSeen = app.message('lastSeen')!.placeholders.single;
      expect(lastSeen.type, PlaceholderType.object);
      expect(
          app.message('special')!.base.raw, "It's \$5 \\ 100% #1\nsecond line");
      expect(app.message('title')!.row, 2);
    });

    test('synthetic pt copies pt_BR', () {
      final title = catalog.scope('app')!.message('title')!;
      final pt = title.translations[LocaleTag.parse('pt')]!;
      expect(pt.raw, 'Exemplo');
      expect(pt.source.code, 'pt_BR');
      expect(pt.isFallback, isFalse);
      expect(pt.column, 'F');
    });

    test('a real parent column keeps its own texts (default)', () {
      final app = catalog.scope('app')!;
      final ar = app.message('title')!.translations[LocaleTag.parse('ar')]!;
      expect(ar.raw, 'مثال');
      expect(ar.source.code, 'ar');
      expect(
          app.message('items')!.translations[LocaleTag.parse('ar_EG')], isNull);
      final appCodes = codes(result.diagnostics.where((d) => d.scope == 'app'));
      expect(appCodes, contains('synthetic-locale'));
      expect(appCodes, isNot(contains('parent-overridden')));
    });

    test('legacy override: ar takes ar_EG where it has text', () {
      final legacy = readCatalog(
        loadSnapshot('test/fixtures/basic_snapshot.json'),
        options: const ReaderOptions(legacyRegionalOverride: true),
      );
      final app = legacy.catalog.scope('app')!;
      final ar = app.message('title')!.translations[LocaleTag.parse('ar')]!;
      expect(ar.raw, 'مثال مصري');
      expect(ar.source.code, 'ar_EG');
      expect(
        app.message('greeting')!.translations[LocaleTag.parse('ar')]!.raw,
        'مرحبا {name}',
      );
      expect(
        codes(legacy.diagnostics.where((d) => d.scope == 'app')),
        containsAll(['synthetic-locale', 'parent-overridden']),
      );
    });

    test('fallback chain', () {
      final special = catalog.scope('app')!.message('special')!;
      final pt = special.translationFor(LocaleTag.parse('pt'));
      expect(pt.isFallback, isTrue);
      expect(pt.fallbackFrom?.code, 'en');
      final arEg = special.translationFor(LocaleTag.parse('ar_EG'));
      expect(arEg.isFallback, isTrue);
      expect(arEg.raw, special.base.raw);
    });
  });

  group('regional columns', () {
    test('ar keeps its own texts', () {
      final r = read(
        [
          ['a', '', '', 'A', 'ع', 'مصري'],
        ],
        header: ['label', 'description', 'meta', 'en', 'ar', 'ar_EG'],
      );
      final a = r.catalog.scopes.single.messages.single;
      expect(a.translations[LocaleTag.parse('ar')]!.raw, 'ع');
      expect(only(r, DiagnosticCode.parentOverridden), isEmpty);
    });

    test('legacy: a parent column after the regional one wins when set', () {
      final r = read(
        [
          ['a', '', '', 'A', 'PK', 'PA'],
          ['b', '', '', 'B', 'PK', ''],
        ],
        header: ['label', 'description', 'meta', 'en', 'pa_PK', 'pa'],
        options: const ReaderOptions(legacyRegionalOverride: true),
      );
      final scope = r.catalog.scopes.single;
      expect(
          scope.message('a')!.translations[LocaleTag.parse('pa')]!.raw, 'PA');
      expect(
          scope.message('b')!.translations[LocaleTag.parse('pa')]!.raw, 'PK');
      expect(only(r, DiagnosticCode.parentOverridden).single.message,
          contains('in 0 row(s) and fills 1 empty cell(s)'));
    });
  });

  group('rows', () {
    test('short rows: missing cells are empty translations', () {
      final rows = [
        ['a', '', '', 'A'],
        ['b', ''],
      ];
      final kept = read(rows);
      final a = kept.catalog.scopes.single.messages.single;
      expect(a.translations.keys.map((l) => l.code), ['en']);
      expect(a.translationFor(LocaleTag.parse('de')).isFallback, isTrue);
      expect(codes(kept.diagnostics), ['empty-base']);
      expect(kept.diagnostics.single.row, 3);

      // 0.6.0 skipped the whole row.
      final legacy =
          read(rows, options: const ReaderOptions(includeEmpty: false));
      expect(legacy.catalog.scopes.single.messages, isEmpty);
      expect(only(legacy, DiagnosticCode.shortRow).map((d) => d.row), [2, 3]);
    });

    test('longer rows are truncated to the header', () {
      final r = read([
        ['a', '', '', 'A', 'B', 'extra'],
      ]);
      expect(
          r.catalog.scopes.single.messages.single.translations, hasLength(2));
    });

    test('empty rows and labels', () {
      final r = read([
        <Object?>[],
        ['', '', '', '', ''],
        ['', 'desc', '', 'A', 'B'],
        [42, '', '', 'A', 'B'],
        ['---', '', '', 'A', 'B'],
      ]);
      expect(codes(r.diagnostics), [
        'empty-row',
        'empty-row',
        'empty-label',
        'empty-label',
        'invalid-identifier',
      ]);
      expect([for (final d in r.diagnostics) d.row], [2, 3, 4, 5, 6]);
    });

    test('labels are sanitized; duplicates are errors and merge', () {
      final r = read([
        ['my-key', 'first', '', 'A', 'B'],
        ['my key', 'second', '', 'A2', ''],
      ]);
      final m = r.catalog.scopes.single.messages.single;
      expect(m.key, 'my_key');
      expect(m.row, 2);
      expect(m.base.raw, 'A2');
      expect(m.description, 'second');
      expect(m.translations[LocaleTag.parse('de')]!.raw, 'B');
      final d = only(r, DiagnosticCode.duplicateLabel).single;
      expect(d.row, 3);
      expect(d.isError, isTrue);
      // An error: the message must not describe it as accepted behaviour.
      expect(d.message, contains('must be unique'));
      expect(d.message, isNot(contains('the later row overwrites')));
    });

    test('lone surrogates are reported per cell, values are kept', () {
      final r = read([
        ['a', 'bad \uD800 desc', '', 'A \uDC00', 'B'],
        ['b', '', '', 'fine \uD83D\uDE00', ''],
      ]);
      final d = only(r, DiagnosticCode.invalidUnicode);
      expect([for (final x in d) '${x.column}${x.row}'], ['B2', 'D2']);
      expect(d.first.severity, Severity.warning);
      final message = r.catalog.scopes.single.messages.first;
      expect(message.base.raw, 'A \uDC00');
      expect(message.description, 'bad \uD800 desc');
    });

    test('empty base is a warning and the message is left out', () {
      final r = read([
        ['a', '', '', '', 'B'],
        ['b', '', '', ' ', 'B'],
        ['c', '', '', 'C', 'C'],
      ]);
      expect(r.catalog.scopes.single.messages.map((m) => m.key), ['c']);
      final d = only(r, DiagnosticCode.emptyBase).toList();
      expect([
        for (final x in d) (x.row, x.column, x.locale, x.key)
      ], [
        (2, 'D', 'en', 'a'),
        (3, 'D', 'en', 'b'),
      ]);
      // The message says the row is left out, so the run must not fail.
      expect(d.first.severity, Severity.warning);
      expect(r.diagnostics.where((x) => x.isError), isEmpty);
    });

    test('whitespace-only cells are empty', () {
      final r = read([
        [' ', '', '', '', ''],
        [' ', 'desc', '', 'A', 'B'],
        ['a', ' ', '', 'A', '  '],
      ]);
      expect(codes(r.diagnostics), ['empty-row', 'empty-label']);
      final a = r.catalog.scopes.single.messages.single;
      expect(a.description, isNull);
      // A blank target cell falls back instead of shipping a blank string.
      expect(a.translations.keys.map((l) => l.code), ['en']);
      expect(a.translationFor(LocaleTag.parse('de')).isFallback, isTrue);
    });

    test('non-string cells are converted', () {
      final r = read([
        ['a', 3, '', 42, true],
      ]);
      final m = r.catalog.scopes.single.messages.single;
      expect(m.base.raw, '42');
      expect(m.translations[LocaleTag.parse('de')]!.raw, 'true');
      expect(m.description, '3');
      expect(only(r, DiagnosticCode.nonStringCell), hasLength(2));
    });

    test('ICU errors are located and drop the translation', () {
      final r = read([
        ['a', '', '', 'Hi {name}', 'Hallo {name'],
        ['b', '', '', '{n, plural, one{x}}', 'y'],
      ]);
      final scope = r.catalog.scopes.single;
      expect(scope.message('a')!.translations.keys.map((l) => l.code), ['en']);
      expect(scope.message('b'), isNull);
      final syntax = only(r, DiagnosticCode.icuSyntax).single;
      expect((syntax.row, syntax.column, syntax.locale, syntax.offset),
          (2, 'E', 'de', 11));
      expect(syntax.message, contains('^'));
      expect(only(r, DiagnosticCode.pluralMissingOther).single.column, 'D');
    });
  });

  group('header', () {
    test('locale codes are sanitized and normalized', () {
      final r = read(
        [
          ['a', '', '', 'A', 'B', 'C'],
        ],
        header: ['label', 'description', 'meta', 'en', 'pt-BR', 'zh_hant'],
      );
      expect(r.catalog.scopes.single.localeTags.map((l) => l.code),
          ['en', 'pt_BR', 'zh_Hant', 'pt', 'zh']);
    });

    test('invalid, unknown, duplicate and empty locale columns', () {
      final r = read(
        [
          ['a', '', '', 'A', 'B', 'C', 'D', 'E', 'F'],
        ],
        header: [
          'label',
          'description',
          'meta',
          'en',
          'German',
          'xx',
          'de',
          'de',
          '',
        ],
      );
      expect(codes(r.diagnostics), [
        'invalid-locale',
        'unknown-locale',
        'duplicate-locale',
        'invalid-locale',
      ]);
      expect([for (final d in r.diagnostics) d.column], ['E', 'F', 'H', 'I']);
      expect(r.catalog.scopes.single.localeTags.map((l) => l.code),
          ['en', 'xx', 'de']);
      expect(
        r.catalog.scopes.single.messages.single
            .translations[LocaleTag.parse('de')]!.raw,
        'D',
      );
    });

    test('a base header cell is sanitized like the others', () {
      final r = read(
        [
          ['a', '', '', 'A', 'B', 'C', 'D'],
        ],
        header: ['label', 'description', 'meta', 'pt BR', 'en', 'Notes', 'EN'],
      );
      final scope = r.catalog.scopes.single;
      expect(scope.baseLocale.code, 'pt_BR');
      expect(scope.localeTags.map((l) => l.code), ['pt_BR', 'en', 'pt']);
      expect(codes(r.diagnostics.where((d) => d.row == 1)),
          ['invalid-locale', 'duplicate-locale']);
    });

    test('an empty trailing header cell without data is ignored', () {
      final r = read(
        [
          ['a', '', '', 'A', 'B'],
        ],
        header: ['label', 'description', 'meta', 'en', 'de', ''],
      );
      expect(r.diagnostics, isEmpty);
    });

    test('a base-only sheet is a localization sheet', () {
      final r = read(
        [
          ['a', '', '', 'A'],
        ],
        header: ['label', 'description', 'meta', 'ru'],
      );
      expect(r.catalog.scopes.single.baseLocale.code, 'ru');
    });

    test('non-localization sheets', () {
      final help = readCatalog(sheet('help', [
        ['Just some text'],
      ]));
      expect(codes(help.diagnostics), ['not-localization-sheet']);
      final table = readCatalog(sheet('locales', [
        ['Language', 'Total', 'Native', 'Family', 'Regions'],
        ['English', '1', '2', 'Germanic', 'UK'],
      ]));
      expect(codes(table.diagnostics), ['not-localization-sheet']);
      expect(table.catalog.scopes, isEmpty);
    });

    test('a broken base header is an error', () {
      final r = read([], header: ['label', 'description', 'meta', 'English']);
      final d = r.diagnostics.single;
      expect((d.code, d.severity, d.column),
          (DiagnosticCode.invalidLocale, Severity.error, 'D'));
    });

    test('sheet titles: sanitized, empty, duplicate', () {
      final r = readCatalog([
        (
          title: 'sign-up',
          values: [
            _header,
            ['a', '', '', 'A', 'B'],
          ],
        ),
        (
          title: 'sign up',
          values: [
            _header,
            ['a', '', '', 'A', 'B'],
          ],
        ),
        (
          title: '!!!',
          values: [
            _header,
            ['a', '', '', 'A', 'B'],
          ],
        ),
      ]);
      expect(r.catalog.scopes.map((s) => s.name), ['sign_up']);
      expect(codes(r.diagnostics), ['duplicate-scope', 'invalid-identifier']);
    });

    test('a sheet without rows is skipped', () {
      final r = read([]);
      expect(r.catalog.scopes, isEmpty);
      expect(codes(r.diagnostics), ['not-localization-sheet']);
    });
  });

  group('meta', () {
    ReadResult withMeta(Object? meta, [String text = 'Hi {name}']) => read([
          ['a', 'column description', meta, text, text],
        ]);

    test('invalid JSON', () {
      for (final meta in ['{"a": ', 'not json', '[1]', '{"placeholders": 1}']) {
        final r = withMeta(meta);
        expect(codes(r.diagnostics), ['invalid-meta-json'], reason: meta);
        expect(r.diagnostics.single.column, 'C');
        // The message itself is still read.
        expect(r.catalog.scopes.single.messages, hasLength(1));
      }
    });

    test('unsupported features', () {
      for (final meta in [
        '{"placeholders": {"name": {"type": "DateTime"}}}',
        '{"placeholders": {"name": {"type": "Foo"}}}',
        '{"placeholders": {"name": {"type": "String", "format": "x"}}}',
        '{"placeholders": {"name": {"optionalParameters": {}}}}',
        '{"description": 1}',
      ]) {
        expect(codes(withMeta(meta).diagnostics), ['unsupported-meta'],
            reason: meta);
      }
    });

    test('placeholder order: declared first, then undeclared by name', () {
      final r = read([
        [
          'a',
          '',
          '{"placeholders": {"z": {"type": "int"}, "y": {}}}',
          '{c} {z} {b} {y} {a}',
          '{c} {z} {b} {y} {a}',
        ],
      ]);
      final m = r.catalog.scopes.single.messages.single;
      expect(m.placeholders.map((p) => '$p'),
          ['int z', 'Object y', 'Object a', 'Object b', 'Object c']);
    });

    test('placeholders are inferred from every locale', () {
      final r = read([
        ['a', '', '', 'Hi', 'Hallo {name}'],
      ]);
      expect(r.catalog.scopes.single.messages.single.placeholders.single.name,
          'name');
    });

    test('placeholder types of plural and select arguments', () {
      ReadResult typed(String type, String text) => read([
            [
              'a',
              '',
              '{"placeholders": {"n": {"type": "$type"}}}',
              text,
              text,
            ],
          ]);
      const plural = '{n, plural, one{x} other{y}}';
      const select = '{n, select, a{x} other{y}}';
      expect(typed('int', plural).diagnostics, isEmpty);
      expect(typed('num', plural).diagnostics, isEmpty);
      expect(codes(typed('double', plural).diagnostics), ['placeholder-type']);
      expect(codes(typed('String', plural).diagnostics), ['placeholder-type']);
      expect(typed('String', select).diagnostics, isEmpty);
      expect(codes(typed('int', select).diagnostics), ['placeholder-type']);
      final both = read([
        ['a', '', '', '{n, plural, other{x}}', '{n, select, other{x}}'],
      ]);
      expect(codes(both.diagnostics), ['placeholder-type']);
      expect(both.catalog.scopes.single.messages, isEmpty);
    });
  });

  group('message syntax', () {
    final rows = [
      ['label', 'description', 'meta', 'en', 'de'],
      [
        'offer',
        '',
        '{"placeholders": {"price": {"type": "String", "example": "5"}}}',
        'Premium is {{price}} per month {not a placeholder}',
        'Premium kostet {{ price }} pro Monat',
      ],
      ['plain', '', '', 'Hi {x}', 'Hallo'],
    ];

    test('mustache sheets parse {{name}} into arguments', () {
      final r = readCatalog(
        sheet('backend-billing', rows),
        options: ReaderOptions(mustacheSheets: [RegExp('^backend')]),
      );
      final scope = r.catalog.scopes.single;
      expect(scope.syntax, MessageSyntax.mustache);
      final offer = scope.message('offer')!;
      expect(offer.placeholders.single.toString(), 'String price');
      expect(
          offer.base.raw, 'Premium is {{price}} per month {not a placeholder}');
      expect(offer.base.ast.placeholderNames, ['price']);
      expect(scope.message('plain')!.placeholders, isEmpty);
      expect(r.diagnostics, isEmpty);
      expect(scope.toJson()['syntax'], 'mustache');
      // Cross-locale checks work the same way.
      final v = validateCatalog(r.catalog);
      expect(codes(v), isEmpty);
    });

    test('syntax callback wins over the patterns', () {
      final r = readCatalog(
        sheet('backend', rows),
        options: ReaderOptions(
          mustacheSheets: [RegExp('^backend')],
          syntax: (_) => MessageSyntax.icu,
        ),
      );
      expect(r.catalog.scopes.single.syntax, MessageSyntax.icu);
      expect(r.catalog.scopes.single.toJson().containsKey('syntax'), isFalse);
    });

    test('an ICU sheet with {{name}} gets a mustache hint', () {
      final r = readCatalog(sheet('backend', rows));
      final error = only(r, DiagnosticCode.icuSyntax).first;
      expect(error.message, contains('looks like mustache syntax'));
      expect(error.column, 'D');
    });

    test('mustache errors are located', () {
      final r = readCatalog(
        sheet('m', [
          ['label', 'description', 'meta', 'en', 'de'],
          ['a', '', '', 'Hi {{user.name}}', 'Hallo {{name'],
        ]),
        options: ReaderOptions(syntax: (_) => MessageSyntax.mustache),
      );
      expect(
        [for (final d in r.diagnostics) (d.code.id, d.column, d.offset)],
        [('icu-syntax', 'D', 5), ('icu-syntax', 'E', 6)],
      );
    });
  });
}
