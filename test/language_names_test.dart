import 'package:sheety_localization/localize.dart';
import 'package:test/test.dart';

void main() => group('language_names', () {
      test('resolves plain ISO 639-1 codes', () {
        expect(resolveLanguageName('uk'), 'Ukrainian');
        expect(resolveLanguageName('ru'), 'Russian');
        expect(resolveLanguageName('cs'), 'Czech');
        expect(resolveLanguageName('ce'), 'Chechen');
      });

      test('normalizes case and separator', () {
        expect(resolveLanguageName('UK'), 'Ukrainian');
        expect(resolveLanguageName('pt-BR'), 'Brazilian Portuguese');
        expect(resolveLanguageName('pt_br'), 'Brazilian Portuguese');
        expect(resolveLanguageName('ZH_Hans'), 'Chinese Simplified');
      });

      test('falls back to the language prefix of an unknown region', () {
        expect(resolveLanguageName('ru_KZ'), 'Russian');
        expect(resolveLanguageName('uk_UA'), 'Ukrainian');
      });

      test('returns null for unknown codes', () {
        expect(resolveLanguageName('xx'), isNull);
        expect(resolveLanguageName('klingon'), isNull);
      });

      test('exposes endonyms for common languages', () {
        expect(resolveLanguageEndonym('uk'), 'українська');
        expect(resolveLanguageEndonym('uk_UA'), 'українська');
        expect(resolveLanguageEndonym('xx'), isNull);
      });

      test('warns about codes models confuse, uk above all', () {
        final note = resolveLanguageNote('uk');
        expect(note, isNotNull);
        expect(note, contains('Ukrainian'));
        expect(note, contains('NOT English'));
        expect(resolveLanguageNote('ru'), isNull);
      });

      test('describes a language for the prompt', () {
        expect(describeLanguage('uk'), 'uk — Ukrainian (українська)');
        expect(describeLanguage('aa'), 'aa — Afar'); // known, no endonym
        expect(describeLanguage('xx'), 'xx'); // unknown, passed through
      });

      test('every endonym and note has a matching language name', () {
        for (final code in kLanguageEndonyms.keys)
          expect(kLanguageNames, contains(code), reason: 'endonym $code');
        for (final code in kAmbiguousLanguageNotes.keys)
          expect(kLanguageNames, contains(code), reason: 'note $code');
      });
    });
