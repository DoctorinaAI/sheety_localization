import 'dart:convert';

import 'package:sheety_localization/localize.dart';
import 'package:test/test.dart';

void main() {
  group('OpenAIClient.parseResponseBody', () {
    String envelope(Object? payload) => jsonEncode({
          'status': 'completed',
          'output': [
            {
              'type': 'message',
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

    test('skips a reasoning item that carries its thinking as content', () {
      // A reasoning model may emit its chain of thought as an output item with
      // a `content` list of its own, ahead of the real message. Parsing that
      // as the payload would fail every single request.
      final body = jsonEncode({
        'status': 'completed',
        'output': [
          {
            'type': 'reasoning',
            'summary': <Object?>[],
            'content': [
              {
                'type': 'reasoning_text',
                'text': 'Let me think about Ukrainian...',
              }
            ],
          },
          {
            'type': 'message',
            'content': [
              {
                'type': 'output_text',
                'text': jsonEncode({
                  'label': 'greeting',
                  'localization': {
                    'uk': {'text': 'Привіт'}
                  },
                }),
              }
            ],
          },
        ],
      });

      final response = OpenAIClient.parseResponseBody(body);
      expect(response.localization['uk'], {'text': 'Привіт'});
    });

    test('reports a refusal as a refusal', () {
      final body = jsonEncode({
        'status': 'completed',
        'output': [
          {
            'type': 'message',
            'content': [
              {'type': 'refusal', 'refusal': 'I cannot help with that'}
            ],
          }
        ],
      });
      expect(
        () => OpenAIClient.parseResponseBody(body),
        throwsA(
          isA<LocalizationResponseException>().having(
            (e) => e.message,
            'message',
            contains('refused'),
          ),
        ),
      );
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
      expect(six, lessThanOrEqualTo(32768));
    });

    test('reserves headroom for the reasoning tokens of a gpt-5 model', () {
      final schema = schemaFor(const ['uk']);
      expect(
        OpenAIClient.maxOutputTokensFor(schema, model: 'gpt-5-mini'),
        greaterThan(
          OpenAIClient.maxOutputTokensFor(schema, model: 'gpt-4o-mini'),
        ),
      );
    });

    test('falls back to a safe budget for an unexpected schema', () {
      expect(
        OpenAIClient.maxOutputTokensFor(const <String, Object?>{}),
        greaterThanOrEqualTo(1024),
      );
    });
  });

  group('OpenAIClient.isReasoningModel', () {
    test('recognises the gpt-5 and o-series families', () {
      expect(OpenAIClient.isReasoningModel('gpt-5-mini'), isTrue);
      expect(OpenAIClient.isReasoningModel('GPT-5'), isTrue);
      expect(OpenAIClient.isReasoningModel('o3-mini'), isTrue);
      expect(OpenAIClient.isReasoningModel('gpt-4o-mini'), isFalse);
      expect(OpenAIClient.isReasoningModel('gpt-4.1'), isFalse);
    });

    test('excludes the chat variants, which reject `reasoning`', () {
      // gpt-5-chat-latest is NOT a reasoning model: it accepts temperature and
      // answers `400 Invalid reasoning_effort for non-reasoning model`.
      expect(OpenAIClient.isReasoningModel('gpt-5-chat-latest'), isFalse);
      expect(OpenAIClient.isReasoningModel('gpt-5-chat'), isFalse);
    });

    test('excludes the o1 models that predate the reasoning parameter', () {
      expect(OpenAIClient.isReasoningModel('o1-mini'), isFalse);
      expect(OpenAIClient.isReasoningModel('o1-preview'), isFalse);
      expect(OpenAIClient.isReasoningModel('o1'), isTrue);
    });
  });

  group('OpenAIApiException retryability', () {
    test('an error inside a delivered body is not retried', () {
      expect(
        const OpenAIApiException('content filter', retryable: false)
            .isRetryable,
        isFalse,
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
