import 'dart:async';
import 'dart:convert';
import 'dart:io' as io;

import 'package:sheety_localization/localize.dart';
import 'package:test/test.dart';

/// Local stand-in for the OpenAI Responses API.
class FakeOpenAI {
  FakeOpenAI(this._server, this.handler) {
    unawaited(_serve());
  }

  static Future<FakeOpenAI> start(
    FutureOr<void> Function(io.HttpRequest request, int attempt) handler,
  ) async =>
      FakeOpenAI(
        await io.HttpServer.bind(io.InternetAddress.loopbackIPv4, 0),
        handler,
      );

  final io.HttpServer _server;
  final FutureOr<void> Function(io.HttpRequest request, int attempt) handler;

  int attempts = 0;
  final List<Map<String, Object?>> bodies = <Map<String, Object?>>[];

  Uri get endpoint =>
      Uri.parse('http://${_server.address.host}:${_server.port}/v1/responses');

  Future<void> _serve() async {
    await for (final request in _server) {
      // Each request is served concurrently: awaiting the handler here would
      // serialize the server, and a serialized server cannot observe a client
      // that ignores its own concurrency limit.
      unawaited(_handle(request));
    }
  }

  Future<void> _handle(io.HttpRequest request) async {
    final attempt = ++attempts;
    bodies.add(
      jsonDecode(await utf8.decodeStream(request)) as Map<String, Object?>,
    );
    await handler(request, attempt);
    await request.response.close();
  }

  Future<void> close() => _server.close(force: true);
}

String okBody(Map<String, String> texts) => jsonEncode({
      'status': 'completed',
      'output': [
        // A reasoning model puts its thinking in front of the answer — and it
        // may carry that thinking in a `content` list of its very own, which
        // must not be mistaken for the payload.
        {
          'type': 'reasoning',
          'summary': <Object?>[],
          'content': [
            {'type': 'reasoning_text', 'text': 'Thinking about the target...'}
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
                  for (final MapEntry(:key, :value) in texts.entries)
                    key: {'text': value},
                },
              }),
            }
          ]
        }
      ],
    });

void main() {
  final errOut = $err;
  setUp(() => $err = (_) {});
  tearDown(() => $err = errOut);

  ({String prompt, Map<String, Object?> schema}) request(
          List<String> languages) =>
      buildLocalizationPrompt(
        label: 'greeting',
        en: 'Hello',
        languages: languages,
      );

  test('performs a request and parses the payload', () async {
    final server = await FakeOpenAI.start((request, _) async {
      request.response
        ..statusCode = 200
        ..headers.contentType = io.ContentType.json
        ..write(okBody({'uk': 'Привіт'}));
    });
    addTearDown(server.close);

    final client = OpenAIClient(apiKey: 'sk-test', endpoint: server.endpoint);
    final (:prompt, :schema) = request(['uk']);
    final response = await client(prompt: prompt, schema: schema);

    expect(response.localization['uk'], {'text': 'Привіт'});

    final body = server.bodies.single;
    expect(body['model'], 'gpt-5-mini');
    expect(body['max_output_tokens'], isA<int>());
    // The prompt that goes over the wire must name the language.
    expect(jsonEncode(body), contains('Ukrainian'));
  });

  test('omits the sampling parameters a gpt-5 model rejects', () async {
    final server = await FakeOpenAI.start((request, _) async {
      request.response
        ..statusCode = 200
        ..write(okBody({'uk': 'Привіт'}));
    });
    addTearDown(server.close);

    final (:prompt, :schema) = request(['uk']);
    await OpenAIClient(
      apiKey: 'sk-test',
      endpoint: server.endpoint,
      model: 'gpt-5-mini',
    )(prompt: prompt, schema: schema);
    await OpenAIClient(
      apiKey: 'sk-test',
      endpoint: server.endpoint,
      model: 'gpt-4o-mini',
    )(prompt: prompt, schema: schema);

    // gpt-5 answers `400 Unsupported parameter` to `temperature`.
    final reasoning = server.bodies.first;
    expect(reasoning, isNot(contains('temperature')));
    expect(reasoning, isNot(contains('top_p')));
    expect(reasoning['reasoning'], {'effort': 'low'});

    // Classic models keep the deterministic sampling.
    final classic = server.bodies.last;
    expect(classic['temperature'], 0);
    expect(classic['top_p'], 1);
    expect(classic, isNot(contains('reasoning')));
  });

  test('retries a 500 and succeeds', () async {
    final server = await FakeOpenAI.start((request, attempt) async {
      if (attempt == 1) {
        request.response.statusCode = 500;
        return;
      }
      request.response
        ..statusCode = 200
        ..write(okBody({'uk': 'Привіт'}));
    });
    addTearDown(server.close);

    final client = OpenAIClient(apiKey: 'sk-test', endpoint: server.endpoint);
    final (:prompt, :schema) = request(['uk']);
    final response = await client(prompt: prompt, schema: schema);

    expect(response.label, 'greeting');
    expect(server.attempts, 2);
  });

  test('does not retry a 401', () async {
    final server = await FakeOpenAI.start((request, _) async {
      request.response
        ..statusCode = 401
        ..write('{"error": "bad key"}');
    });
    addTearDown(server.close);

    final client = OpenAIClient(apiKey: 'sk-test', endpoint: server.endpoint);
    final (:prompt, :schema) = request(['uk']);

    await expectLater(
      client(prompt: prompt, schema: schema),
      throwsA(isA<OpenAIApiException>()
          .having((e) => e.statusCode, 'statusCode', 401)),
    );
    expect(server.attempts, 1);
  });

  test('does not retry unparseable output — the caller splits instead',
      () async {
    final server = await FakeOpenAI.start((request, _) async {
      request.response
        ..statusCode = 200
        ..write(
          jsonEncode({
            'status': 'completed',
            'output': [
              {
                'type': 'message',
                'content': [
                  {'type': 'output_text', 'text': '{"label": "greet'}
                ]
              }
            ],
          }),
        );
    });
    addTearDown(server.close);

    final client = OpenAIClient(apiKey: 'sk-test', endpoint: server.endpoint);
    final (:prompt, :schema) = request(['uk']);

    await expectLater(
      client(prompt: prompt, schema: schema),
      throwsA(isA<LocalizationResponseException>()),
    );
    expect(server.attempts, 1, reason: 'a bad payload must not be re-sent');
  });

  test('times out a request the model never finishes', () async {
    final stuck = Completer<void>();
    final server = await FakeOpenAI.start((request, _) => stuck.future);
    addTearDown(() {
      stuck.complete();
      return server.close();
    });

    final client = OpenAIClient(
      apiKey: 'sk-test',
      endpoint: server.endpoint,
      retries: 1,
      timeout: const Duration(milliseconds: 200),
    );
    final (:prompt, :schema) = request(['uk']);

    await expectLater(
      client(prompt: prompt, schema: schema),
      throwsA(isA<OpenAIApiException>()
          .having((e) => e.message, 'message', contains('timed out'))),
    );
  });

  test('runs exactly `workers` requests at once, no more and no fewer',
      () async {
    var inFlight = 0, peak = 0;
    final server = await FakeOpenAI.start((request, _) async {
      inFlight++;
      peak = peak > inFlight ? peak : inFlight;
      await Future<void>.delayed(const Duration(milliseconds: 50));
      inFlight--;
      request.response
        ..statusCode = 200
        ..write(okBody({'uk': 'Привіт'}));
    });
    addTearDown(server.close);

    final client = OpenAIClient(
      apiKey: 'sk-test',
      endpoint: server.endpoint,
      workers: 2,
    );
    final (:prompt, :schema) = request(['uk']);
    await Future.wait<void>([
      for (var i = 0; i < 6; i++)
        client(prompt: prompt, schema: schema).then((_) {}),
    ]);

    expect(server.attempts, 6);
    // Upper bound: the semaphore holds the line at `workers`.
    expect(peak, lessThanOrEqualTo(2));
    // Lower bound: requests really do overlap. Without it, a client that ran
    // everything sequentially — or one whose semaphore leaked slots until it
    // deadlocked at one worker — would still satisfy the bound above.
    expect(peak, 2);
  });

  test('releases its slot after a failed request', () async {
    // A leaked slot starves the pool: `workers` failures and the run hangs
    // forever with no output. Fail the first `workers` requests, then succeed —
    // the later calls can only get through if the slots came back.
    final server = await FakeOpenAI.start((request, attempt) async {
      if (attempt <= 2) {
        request.response.statusCode =
            401; // non-retryable, throws out of call()
        return;
      }
      request.response
        ..statusCode = 200
        ..write(okBody({'uk': 'Привіт'}));
    });
    addTearDown(server.close);

    final client = OpenAIClient(
      apiKey: 'sk-test',
      endpoint: server.endpoint,
      workers: 2,
    );
    final (:prompt, :schema) = request(['uk']);

    for (var i = 0; i < 2; i++)
      await expectLater(
        client(prompt: prompt, schema: schema),
        throwsA(isA<OpenAIApiException>()),
      );

    final response = await client(prompt: prompt, schema: schema)
        .timeout(const Duration(seconds: 5));
    expect(response.label, 'greeting');
  });

  test('sends the system prompt as `instructions`', () async {
    final server = await FakeOpenAI.start((request, _) async {
      request.response
        ..statusCode = 200
        ..write(okBody({'uk': 'Привіт'}));
    });
    addTearDown(server.close);

    final (:prompt, :schema) = request(['uk']);
    await OpenAIClient(
      apiKey: 'sk-test',
      endpoint: server.endpoint,
      systemPrompt: 'You are a medical localization engine.',
    )(prompt: prompt, schema: schema);

    expect(
      server.bodies.single['instructions'],
      'You are a medical localization engine.',
    );
  });

  test('does not retry an error delivered inside a 200 body', () async {
    final server = await FakeOpenAI.start((request, _) async {
      request.response
        ..statusCode = 200
        ..write(jsonEncode({
          'error': {'message': 'content filter', 'type': 'invalid_request'}
        }));
    });
    addTearDown(server.close);

    final client = OpenAIClient(apiKey: 'sk-test', endpoint: server.endpoint);
    final (:prompt, :schema) = request(['uk']);

    await expectLater(
      client(prompt: prompt, schema: schema),
      throwsA(isA<OpenAIApiException>()),
    );
    // The API already judged this exact prompt; re-sending it only repeats it.
    expect(server.attempts, 1);
  });
}
