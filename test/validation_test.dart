import 'package:sheety_localization/localize.dart';
import 'package:test/test.dart';

void main() {
  group('extractPlaceholders', () {
    test('collects ICU placeholders and markup tags', () {
      expect(
        extractPlaceholders('Hi {name}, you have {count} <b>new</b> messages'),
        <String>['</b>', '<b>', '{count}', '{name}'],
      );
    });

    test('is order independent', () {
      expect(
        extractPlaceholders('{a} {b}'),
        extractPlaceholders('{b} {a}'),
      );
    });
  });

  group('validateTranslation', () {
    test('accepts a sane translation', () {
      expect(
        validateTranslation(source: 'Hello', translation: 'Привіт'),
        isNull,
      );
    });

    test('accepts reordered placeholders', () {
      expect(
        validateTranslation(
          source: 'Hello {name}, {count} messages',
          translation: '{count} повідомлень для {name}',
        ),
        isNull,
      );
    });

    test('rejects a missing or empty translation', () {
      expect(validateTranslation(source: 'Hello', translation: null),
          contains('missing'));
      expect(validateTranslation(source: 'Hello', translation: '   '),
          contains('empty'));
    });

    test('rejects a dropped placeholder', () {
      expect(
        validateTranslation(
          source: 'Hello, {name}!',
          translation: 'Привіт!',
        ),
        contains('placeholder mismatch'),
      );
    });

    test('rejects an invented placeholder', () {
      expect(
        validateTranslation(
          source: 'Hello',
          translation: 'Привіт, {user}',
        ),
        contains('placeholder mismatch'),
      );
    });

    test('rejects runaway output ("билиберда")', () {
      expect(
        validateTranslation(
          source: 'Hello',
          translation: 'бла ' * 200,
        ),
        contains('suspiciously long'),
      );
    });

    test('rejects a leaked markdown fence', () {
      expect(
        validateTranslation(
          source: 'Hello',
          translation: '```json\n{"text": "Привіт"}\n```',
        ),
        contains('markdown fence'),
      );
    });

    test('rejects corrupted encoding', () {
      expect(
        validateTranslation(source: 'Hello', translation: 'Прив\u{FFFD}т'),
        contains('replacement characters'),
      );
    });

    test('gives short sources a length budget', () {
      expect(
        validateTranslation(source: 'OK', translation: 'Гаразд, зрозуміло'),
        isNull,
      );
    });
  });
}
