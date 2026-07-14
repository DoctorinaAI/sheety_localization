import 'package:sheety_localization/localize.dart';
import 'package:test/test.dart';

void main() {
  group('extractPlaceholders', () {
    test('collects simple placeholders and markup tags', () {
      final found =
          extractPlaceholders('Hi {name}, you have {count} <b>new</b> ones');
      expect(found.arguments, {'name', 'count'});
      expect(found.directives, isEmpty);
      expect(found.tags, <String>['</b>', '<b>']);
    });

    test('reads a plural as ONE argument, not as its branches', () {
      final found = extractPlaceholders(
        'You have {count, plural, one {# message} other {# messages}}',
      );
      expect(found.arguments, {'count'});
      expect(found.directives, {'count'});
    });

    test('descends into the branches of a plural', () {
      // The shape this project actually ships in its sheets.
      final found = extractPlaceholders(
        '{value, plural, one{{value} year} other{{value} years}}',
      );
      expect(found.arguments, {'value'});
      expect(found.directives, {'value'});
    });

    test('reads a formatted argument', () {
      final found = extractPlaceholders('Total: {amount, number, currency}');
      expect(found.arguments, {'amount'});
      expect(found.directives, isEmpty);
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

    test('rejects dropped markup', () {
      expect(
        validateTranslation(
          source: 'Hello, <b>friend</b>!',
          translation: 'Привіт, друже!',
        ),
        contains('markup mismatch'),
      );
    });

    test('accepts a correctly translated plural', () {
      expect(
        validateTranslation(
          source: 'You have {count, plural, one {# message} '
              'other {# messages}}',
          translation: 'Sie haben {count, plural, one {# Nachricht} '
              'other {# Nachrichten}}',
        ),
        isNull,
      );
    });

    test('accepts a plural whose language needs more categories', () {
      // Russian has four plural categories where English has two: the number
      // of times the placeholder occurs legitimately differs.
      expect(
        validateTranslation(
          source: '{value, plural, one{{value} year} other{{value} years}}',
          translation: '{value, plural, one{{value} рік} few{{value} роки} '
              'many{{value} років} other{{value} року}}',
        ),
        isNull,
      );
    });

    test('accepts a plural whose language needs fewer categories', () {
      expect(
        validateTranslation(
          source: '{value, plural, one{{value} year} other{{value} years}}',
          translation: '{value, plural, other{{value}年}}',
        ),
        isNull,
      );
    });

    test('rejects a translation that flattened the plural directive', () {
      // The argument names survive, but the pluralization is gone — the ARB
      // would either fail to parse or render both branches at once.
      expect(
        validateTranslation(
          source: 'You have {count, plural, one {1 message} '
              'other {# messages}}',
          translation: 'У вас {count} сообщений',
        ),
        contains('lost ICU directive'),
      );
    });

    test('rejects unbalanced braces', () {
      expect(
        validateTranslation(
          source: 'Hello, {name}!',
          translation: 'Привіт, {name!',
        ),
        contains('unbalanced braces'),
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
