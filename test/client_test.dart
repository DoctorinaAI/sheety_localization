import 'dart:convert';

import 'package:sheety_localization/localize.dart';
import 'package:test/test.dart';

void main() {
  group('OpenAIClient.parseResponseBody', () {
    String envelope(Object? payload) => jsonEncode({
          'status': 'completed',
          'output': [
            {
              'content': [
                {'type': 'output_text', 'text': jsonEncode(payload)}
              ]
            }
          ],
        });

    test('extracts the localization payload', () {
      final response = OpenAIClient.parseResponseBody(
        envelope({
          'label': 'greeting',
          'localization': {
            'uk': {'text': 'Привіт'}
          },
        }),
      );
      expect(response.label, 'greeting');
      expect(response.localization['uk'], {'text': 'Привіт'});
    });

    test('rejects a truncated response instead of retrying it', () {
      final body = jsonEncode({
        'status': 'incomplete',
        'incomplete_details': {'reason': 'max_output_tokens'},
        'output': <Object?>[],
      });
      expect(
        () => OpenAIClient.parseResponseBody(body),
        throwsA(
          isA<LocalizationResponseException>().having(
            (e) => e.message,
            'message',
            contains('max_output_tokens'),
          ),
        ),
      );
    });

    test('rejects a malformed inner payload', () {
      final body = jsonEncode({
        'status': 'completed',
        'output': [
          {
            'content': [
              {'type': 'output_text', 'text': '{"label": "greeting", "loc'}
            ]
          }
        ],
      });
      expect(
        () => OpenAIClient.parseResponseBody(body),
        throwsA(isA<LocalizationResponseException>()),
      );
    });

    test('rejects a payload with the wrong shape', () {
      expect(
        () => OpenAIClient.parseResponseBody(envelope({'label': 'greeting'})),
        throwsA(isA<LocalizationResponseException>()),
      );
    });

    test('surfaces API-level errors', () {
      expect(
        () => OpenAIClient.parseResponseBody(
          jsonEncode({
            'error': {'message': 'rate limited'}
          }),
        ),
        throwsA(isA<OpenAIApiException>()),
      );
    });
  });

  group('OpenAIClient.maxOutputTokensFor', () {
    Map<String, Object?> schemaFor(List<String> languages) =>
        buildLocalizationPrompt(
          label: 'greeting',
          en: 'Hello',
          languages: languages,
        ).schema;

    test('grows with the number of requested languages', () {
      final one = OpenAIClient.maxOutputTokensFor(schemaFor(const ['uk']));
      final six = OpenAIClient.maxOutputTokensFor(
        schemaFor(const ['uk', 'ru', 'de', 'fr', 'es', 'it']),
      );
      expect(six, greaterThan(one));
      expect(one, greaterThanOrEqualTo(1024));
      expect(six, lessThanOrEqualTo(16384));
    });

    test('falls back to a safe budget for an unexpected schema', () {
      expect(
        OpenAIClient.maxOutputTokensFor(const <String, Object?>{}),
        greaterThanOrEqualTo(1024),
      );
    });
  });

  group('OpenAIApiException', () {
    test('retries transport, 429 and 5xx failures only', () {
      expect(const OpenAIApiException('timeout').isRetryable, isTrue);
      expect(
        const OpenAIApiException('rate', statusCode: 429).isRetryable,
        isTrue,
      );
      expect(
        const OpenAIApiException('boom', statusCode: 503).isRetryable,
        isTrue,
      );
      expect(
        const OpenAIApiException('bad key', statusCode: 401).isRetryable,
        isFalse,
      );
      expect(
        const OpenAIApiException('bad request', statusCode: 400).isRetryable,
        isFalse,
      );
    });
  });
}
