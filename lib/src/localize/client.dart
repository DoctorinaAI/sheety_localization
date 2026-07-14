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
  ///
  /// [retryable] overrides the decision derived from [statusCode]; it is used
  /// for failures reported inside a delivered body, which carry no status.
  const OpenAIApiException(this.message, {this.statusCode, bool? retryable})
      : _retryable = retryable;

  /// Human-readable reason.
  final String message;

  /// HTTP status code, when the failure happened after a response was received.
  final int? statusCode;

  final bool? _retryable;

  /// Whether retrying the very same request can plausibly succeed.
  bool get isRetryable {
    final override = _retryable;
    if (override != null) return override;
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

  /// Whether [model] is a reasoning model (the `gpt-5` and `o*` families).
  ///
  /// Those models reject the sampling parameters, and their reasoning tokens
  /// are charged against the same `max_output_tokens` budget as the answer.
  ///
  /// The chat variants (`gpt-5-chat-latest`) are the mirror image: they are
  /// *not* reasoning models, they accept `temperature` and reject
  /// `reasoning.effort`, so they must not be swept up by the `gpt-5` prefix.
  /// The first o-series models predate the `reasoning` parameter entirely.
  static bool isReasoningModel(String model) {
    final name = model.toLowerCase();
    if (name.contains('chat')) return false;
    if (name.startsWith('o1-mini') || name.startsWith('o1-preview'))
      return false;
    return name.startsWith('gpt-5') ||
        name.startsWith('o1') ||
        name.startsWith('o3') ||
        name.startsWith('o4');
  }

  /// Number of languages the [schema] asks for.
  static int languagesOf(Map<String, Object?> schema) {
    if (schema
        case {
          'properties': {'localization': {'required': List<Object?> required}}
        }) return required.length.clamp(1, 32);
    return 1;
  }

  /// Token budget for the request: the payload grows with the number of
  /// requested languages, and a truncated answer is unparseable JSON.
  ///
  /// On a reasoning model the budget also has to cover the reasoning tokens,
  /// which are invisible but billed against the very same ceiling — without
  /// the extra headroom the answer itself gets cut off mid-JSON.
  ///
  /// The reserve is deliberately generous: `max_output_tokens` is a ceiling,
  /// not a charge, so an unused reserve costs nothing, while an exhausted one
  /// truncates the answer into unparseable JSON. It dwarfs the per-language
  /// term on purpose — the reasoning burn is driven by the prompt, so the
  /// single-language fallback must not end up with a *smaller* budget than the
  /// batch that just failed.
  static const int _reasoningReserve = 16384;

  /// Ceiling for `max_output_tokens` of a request carrying [schema].
  static int maxOutputTokensFor(
    Map<String, Object?> schema, {
    String model = 'gpt-5-mini',
  }) {
    final languages = languagesOf(schema);
    final reserve = isReasoningModel(model) ? _reasoningReserve : 0;
    return (1024 + reserve + 768 * languages).clamp(1024, 32768);
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

      // Deterministic outputs for pipeline stability.
      // Reasoning models (gpt-5, o*) reject the sampling parameters outright
      // with `400 Unsupported parameter`, so they get an effort hint instead.
      if (isReasoningModel(model))
        'reasoning': {'effort': 'low'}
      else ...{
        'temperature': 0,
        'top_p': 1,
      },

      // Token budget scaled by the number of requested languages
      'max_output_tokens': maxOutputTokensFor(schema, model: model),
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

    // An error inside a delivered body is a decision of the API about this very
    // prompt (content filter, failed run) — re-sending it verbatim would only
    // reproduce it, so it is not treated as a transient failure.
    if (json case {'error': Map<String, Object?> error})
      throw OpenAIApiException(error.toString(), retryable: false);

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
      for (final item in output.whereType<Map<String, Object?>>()) {
        // Reasoning items also carry `content` — with the model's thinking in
        // it, not the answer. Only a message item holds the payload, and only
        // its `output_text` part. Everything else is skipped, not parsed.
        if (item['type'] != 'message') continue;
        if (item case {'content': List<Object?> content}) {
          for (final part in content.whereType<Map<String, Object?>>()) {
            // The model declined to answer: report it as such, so the operator
            // is not sent chasing a phantom transport problem.
            if (part case {'type': 'refusal', 'refusal': String refusal})
              throw LocalizationResponseException(
                'Model refused to answer: $refusal',
              );
            if (part case {'type': 'output_text', 'text': String text}) {
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
    try {
      // Everything that can throw lives under the semaphore's `finally`, so a
      // slot can never leak — a leaked slot would eventually starve every
      // worker and hang the run with no output at all.
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
            // Unusable payload: never retried here — the caller splits the
            // batch into single languages, a *different*, shorter prompt.
            rethrow;
          } on Object catch (e) {
            final retryable = e is! OpenAIApiException || e.isRetryable;
            if (!retryable || attempt >= retries) rethrow;
            $err('OpenAI API call failed (attempt $attempt/$retries): $e');
            await Future<void>.delayed(
              Duration(milliseconds: 500 * (1 << (attempt - 1))),
            );
          }
        }
      } finally {
        // Closing an already-aborted client must not mask the real error.
        try {
          client.close(force: true);
        } on Object catch (_) {}
      }
    } finally {
      _release();
    }
  }
}
