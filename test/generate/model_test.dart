import 'dart:convert';

import 'package:test/test.dart';

import '../sheety.dart';

Translation t(String locale, String raw, {String? source, int? row}) =>
    Translation(
      locale: LocaleTag.parse(locale),
      source: LocaleTag.parse(source ?? locale),
      raw: raw,
      ast: parseIcu(raw),
      row: row,
    );

void main() {
  group('LocaleTag', () {
    test('parses and normalizes', () {
      expect(LocaleTag.parse('en').code, 'en');
      expect(LocaleTag.parse('pt-br').code, 'pt_BR');
      expect(LocaleTag.parse('PT_BR').bcp47, 'pt-BR');
      expect(LocaleTag.parse('zh_hant').code, 'zh_Hant');
      expect(LocaleTag.parse('zh-Hant-TW').code, 'zh_Hant_TW');
      expect(LocaleTag.parse('es_419').country, '419');
      expect(LocaleTag.parse('fil_PH').language, 'fil');
    });

    test('rejects malformed codes', () {
      for (final bad in [
        '',
        'e',
        'english',
        'en_US_POSIX',
        'en__US',
        'zh_TW_Hant',
        'en_1',
        'pt_BR_BR',
      ]) {
        expect(LocaleTag.tryParse(bad), isNull, reason: bad);
      }
      expect(() => LocaleTag.parse('x'), throwsFormatException);
    });

    test('parent is the bare language (gen-l10n)', () {
      expect(LocaleTag.parse('pt_BR').parent, LocaleTag.parse('pt'));
      expect(LocaleTag.parse('zh_Hant_TW').parent, LocaleTag.parse('zh'));
      expect(LocaleTag.parse('pt').parent, isNull);
    });

    test('camelCase like LocaleInfo.camelCase', () {
      expect(LocaleTag.parse('pt_BR').camelCase, 'PtBr');
      expect(LocaleTag.parse('zh_Hant_TW').camelCase, 'ZhHantTw');
      expect(LocaleTag.parse('en').camelCase, 'En');
      expect(LocaleTag.parse('es_419').camelCase, 'Es419');
    });

    test('equality and ordering by code', () {
      expect(LocaleTag.parse('pt-BR'), LocaleTag.parse('pt_BR'));
      final sorted = [
        LocaleTag.parse('pt_BR'),
        LocaleTag.parse('ar'),
        LocaleTag.parse('pt'),
      ]..sort();
      expect(sorted.map((l) => l.code), ['ar', 'pt', 'pt_BR']);
    });
  });

  group('PlaceholderType', () {
    test('ARB names', () {
      expect(PlaceholderType.fromArb('String'), PlaceholderType.string);
      expect(PlaceholderType.fromArb('Object'), PlaceholderType.object);
      expect(PlaceholderType.fromArb('DateTime'), isNull);
      expect(PlaceholderType.fromArb('string'), isNull);
      expect(PlaceholderType.int.isNumeric, isTrue);
      expect(PlaceholderType.string.isNumeric, isFalse);
    });
  });

  group('Message.translationFor', () {
    final en = LocaleTag.parse('en');
    final message = Message(
      key: 'hello',
      baseLocale: en,
      placeholders: const [],
      translations: {
        en: t('en', 'Hello', row: 2),
        LocaleTag.parse('pt'): t('pt', 'Olá'),
        LocaleTag.parse('de_CH'): t('de_CH', 'Grüezi'),
      },
    );

    test('own text', () {
      final own = message.translationFor(LocaleTag.parse('pt'));
      expect(own.raw, 'Olá');
      expect(own.isFallback, isFalse);
      expect(own.fallbackFrom, isNull);
    });

    test('falls back to the parent, then to the base', () {
      final br = message.translationFor(LocaleTag.parse('pt_BR'));
      expect(br.raw, 'Olá');
      expect(br.isFallback, isTrue);
      expect(br.locale.code, 'pt_BR');
      expect(br.fallbackFrom?.code, 'pt');

      final de = message.translationFor(LocaleTag.parse('de'));
      expect(de.raw, 'Hello');
      expect(de.fallbackFrom, en);
      expect(de.row, 2);
    });

    test('requires the base translation', () {
      expect(
        () => Message(
          key: 'x',
          baseLocale: en,
          placeholders: const [],
          translations: {LocaleTag.parse('de'): t('de', 'x')},
        ),
        throwsArgumentError,
      );
    });
  });

  group('Catalog', () {
    Scope scope(String name, List<String> locales) => Scope(
          name: name,
          sheetTitle: name,
          baseLocale: LocaleTag.parse(locales.first),
          locales: [for (final l in locales) ScopeLocale(LocaleTag.parse(l))],
          messages: [
            Message(
              key: 'a',
              baseLocale: LocaleTag.parse(locales.first),
              placeholders: const [],
              translations: {
                LocaleTag.parse(locales.first): t(locales.first, 'A'),
              },
            ),
          ],
        );

    test('locales in order of first appearance', () {
      final catalog = Catalog([
        scope('one', ['en', 'ru']),
        scope('two', ['en', 'de', 'ru']),
      ]);
      expect(catalog.locales.map((l) => l.code), ['en', 'ru', 'de']);
      expect(catalog.baseLocale?.code, 'en');
      expect(catalog.where((s) => s.name == 'two').scopes.single.name, 'two');
      expect(catalog.scope('one')?.fallbackCount(LocaleTag.parse('ru')), 1);
    });

    test('canonical JSON is stable and complete', () {
      final catalog = Catalog([
        scope('one', ['en', 'ru']),
      ]);
      final json = catalog.toCanonicalJson();
      expect(
          json,
          Catalog([
            scope('one', ['en', 'ru'])
          ]).toCanonicalJson());
      expect(jsonDecode(json), {
        'scopes': [
          {
            'name': 'one',
            'sheetTitle': 'one',
            'baseLocale': 'en',
            'locales': [
              {'code': 'en'},
              {'code': 'ru'},
            ],
            'messages': [
              {
                'key': 'a',
                'placeholders': <Object?>[],
                'translations': {
                  'en': {'raw': 'A'},
                },
              },
            ],
          },
        ],
      });
    });
  });
}
