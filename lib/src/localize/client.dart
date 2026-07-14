/// OpenAI transport for the localization pipeline.
library;

import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:io' as io;

import 'utils.dart';

/// Structured payload returned by the model for a single localization request.
typedef LocalizationResponse = ({
  String label,
  Map<String, Object?> localization,
});

/// Anything able to turn a prompt + JSON schema into a localization payload.
///
/// Exists so the pipeline can be exercised in tests without network access.
abstract interface class LocalizationClient {
  /// Perform a single localization request.
  Future<LocalizationResponse> call({
    required String prompt,
    required Map<String, Object?> schema,
  });
}

/// Error raised when the model answers with something we cannot use: truncated
/// output, invalid JSON, a payload that does not match the schema.
///
/// Such an error is *not* retried with the same prompt — the caller splits the
/// batch into single languages instead, which both shortens the output and
/// isolates the language the model is choking on.
class LocalizationResponseException implements Exception {
  /// Creates an exception describing an unusable model response.
  const LocalizationResponseException(this.message);

  /// Human-readable reason.
  final String message;

  @override
  String toString() => 'LocalizationResponseException: $message';
}

/// Error raised when the OpenAI API itself fails (network, 429, 5xx, 4xx).
class OpenAIApiException implements Exception {
  /// Creates an API-level failure with an optional HTTP [statusCode].
  const OpenAIApiException(this.message, {this.statusCode});

  /// Human-readable reason.
  final String message;

  /// HTTP status code, when the failure happened after a response was received.
  final int? statusCode;

  /// Whether retrying the very same request can plausibly succeed.
  bool get isRetryable {
    final code = statusCode;
    if (code == null) return true; // network / timeout
    if (code == 408 || code == 409 || code == 429) return true;
    return code >= 500;
  }

  @override
  String toString() => 'OpenAIApiException'
      '${statusCode == null ? '' : ' ($statusCode)'}: $message';
}

/// OpenAI Responses API client with a concurrency semaphore, a per-request
/// timeout and retries limited to transient failures.
class OpenAIClient implements LocalizationClient {
  /// Creates a client bound to an OpenAI [apiKey].
  OpenAIClient({
    required this.apiKey,
    this.model = 'gpt-5-mini',
    this.workers = 6,
    this.retries = 3,
    this.systemPrompt,
    this.timeout = const Duration(seconds: 120),
    Uri? endpoint,
  })  : endpoint = endpoint ?? Uri.https('api.openai.com', '/v1/responses'),
        _available = workers < 1 ? 1 : workers;

  /// OpenAI API key.
  final String apiKey;

  /// OpenAI model name, e.g. `gpt-5-mini`.
  final String model;

  /// Maximum number of concurrent in-flight requests.
  final int workers;

  /// Attempts per request for *transient* failures only.
  final int retries;

  /// Optional system prompt (`instructions` of the Responses API).
  final String? systemPrompt;

  /// Hard wall-clock limit of a single request.
  ///
  /// Without it a request that the model never finishes (the "stuck on a rare
  /// language" case) hangs a worker forever and stalls the whole run.
  final Duration timeout;

  /// Responses API endpoint. Overridable for tests.
  final Uri endpoint;

  /// Counting semaphore limiting the number of concurrent in-flight
  /// OpenAI requests to [workers].
  int _available;
  final Queue<Completer<void>> _waiters = Queue<Completer<void>>();

  /// Acquire a slot before performing a request, waiting if [workers] requests
  /// are already in flight.
  Future<void> _acquire() {
    if (_available > 0) {
      _available--;
      return Future<void>.value();
    }
    final completer = Completer<void>();
    _waiters.add(completer);
    return completer.future;
  }

  /// Release a slot, waking the next waiter if any.
  void _release() {
    if (_waiters.isNotEmpty) {
      _waiters.removeFirst().complete();
    } else {
      _available++;
    }
  }

  /// Token budget for the request: the payload grows with the number of
  /// requested languages, and a truncated answer is unparseable JSON.
  static int maxOutputTokensFor(Map<String, Object?> schema) {
    var languages = 1;
    if (schema
        case {
          'properties': {'localization': {'required': List<Object?> required}}
        }) languages = required.length.clamp(1, 32);
    return (1024 + 768 * languages).clamp(1024, 16384);
  }

  Future<LocalizationResponse> _request({
    required io.HttpClient client,
    required String prompt,
    required Map<String, Object?> schema,
  }) async {
    final request = await client.postUrl(endpoint)
      ..headers.set('Content-Type', 'application/json')
      ..headers.set('Authorization', 'Bearer $apiKey');
    final body = jsonEncode({
      'model': model, // e.g. "gpt-5-mini"

      // System prompt goes into `instructions` for Responses API
      if (systemPrompt != null) 'instructions': systemPrompt,

      // User prompt goes into `input` with explicit content typing
      'input': [
        {
          'role': 'user',
          'content': [
            {
              'type': 'input_text',
              'text': prompt,
            }
          ]
        }
      ],

      // Specify structured output at the TOP-LEVEL under "text.format"
      'text': {
        'format': {
          'name': 'i18n_payload',
          'strict': true,
          'type': 'json_schema',
          'schema': schema
        }
      },

      // Deterministic outputs for pipeline stability
      'temperature': 0,
      'top_p': 1,

      // Token budget scaled by the number of requested languages
      'max_output_tokens': maxOutputTokensFor(schema),
    });
    request.add(utf8.encode(body));
    final response = await request.close();
    final responseBody = await response.transform(utf8.decoder).join();
    if (response.statusCode != 200)
      throw OpenAIApiException(
        responseBody,
        statusCode: response.statusCode,
      );
    return parseResponseBody(responseBody);
  }

  /// Parses the raw body of an OpenAI Responses API answer.
  ///
  /// Throws [LocalizationResponseException] for anything unusable, so the
  /// caller can fall back to single-language requests instead of hammering the
  /// API with an identical prompt.
  static LocalizationResponse parseResponseBody(String responseBody) {
    Object? json;
    try {
      json = jsonDecode(responseBody);
    } on FormatException catch (e) {
      throw LocalizationResponseException('Malformed JSON from OpenAI: $e');
    }

    if (json case {'error': Map<String, Object?> error})
      throw OpenAIApiException(error.toString());

    // The model hit the token ceiling / was cut off: the payload is truncated
    // garbage, retrying the same prompt would truncate again.
    if (json case {'status': 'incomplete'}) {
      final reason = switch (json) {
        {'incomplete_details': {'reason': String reason}} => reason,
        _ => 'unknown',
      };
      throw LocalizationResponseException(
        'Incomplete response from OpenAI (reason: $reason)',
      );
    }

    if (json case {'output': List<Object?> output} when output.isNotEmpty) {
      for (final item in output) {
        if (item case {'content': List<Object?> content}) {
          for (final part in content.whereType<Map<String, Object?>>()) {
            if (part case {'text': String text}) {
              Object? payload;
              try {
                payload = jsonDecode(text);
              } on FormatException catch (e) {
                throw LocalizationResponseException(
                  'Model returned invalid JSON payload: $e',
                );
              }
              if (payload
                  case {
                    'label': String label,
                    'localization': Map<String, Object?> localization,
                  }) return (label: label, localization: localization);
              throw const LocalizationResponseException(
                'Invalid JSON structure in OpenAI response',
              );
            }
          }
        }
      }
    }
    throw const LocalizationResponseException(
      'Invalid response format from OpenAI API',
    );
  }

  @override
  Future<LocalizationResponse> call({
    required String prompt,
    required Map<String, Object?> schema,
  }) async {
    // Throttle to at most [workers] concurrent in-flight requests.
    await _acquire();
    final client = io.HttpClient()..connectionTimeout = timeout;
    try {
      for (var attempt = 1;; attempt++) {
        try {
          return await _request(
            client: client,
            prompt: prompt,
            schema: schema,
          ).timeout(
            timeout,
            onTimeout: () => throw OpenAIApiException(
              'Request timed out after ${timeout.inSeconds}s',
            ),
          );
        } on LocalizationResponseException {
          // Unusable payload: never retried here — the caller splits the batch
          // into single languages, which is a *different*, shorter prompt.
          rethrow;
        } on Object catch (e) {
          final retryable = e is! OpenAIApiException || e.isRetryable;
          if (!retryable || attempt >= retries) rethrow;
          $err('OpenAI API call failed (attempt $attempt/$retries): $e');
          await Future<void>.delayed(
            Duration(milliseconds: 250 * (1 << (attempt - 1))),
          );
        }
      }
    } finally {
      client.close(force: true);
      _release();
    }
  }
}
