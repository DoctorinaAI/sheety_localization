import 'dart:async';

import 'package:sheety_localization/localize.dart';
import 'package:test/test.dart';

/// Scripted [LocalizationClient] that records which languages were requested.
class FakeClient implements LocalizationClient {
  FakeClient(this.handler);

  /// Answers a request for [languages]; throw to simulate a failed batch.
  final FutureOr<Map<String, String>> Function(List<String> languages) handler;

  /// Languages of every request, in call order.
  final List<List<String>> calls = <List<String>>[];

  @override
  Future<LocalizationResponse> call({
    required String prompt,
    required Map<String, Object?> schema,
  }) async {
    final localization = (schema['properties']!
        as Map<String, Object?>)['localization']! as Map<String, Object?>;
    final languages = (localization['required']! as List<Object?>)
        .cast<String>()
        .toList(growable: false);
    calls.add(languages);
    final texts = await handler(languages);
    return (
      label: 'greeting',
      localization: <String, Object?>{
        for (final MapEntry(:key, :value) in texts.entries)
          key: <String, Object?>{'text': value},
      },
    );
  }
}

LocalizeRow rowWith(List<String> codes) => LocalizeRow(
      row: 1,
      label: 'greeting',
      description: null,
      meta: null,
      english: 'Hello',
      cells: <LocalizeCell>[
        for (var i = 0; i < codes.length; i++)
          LocalizeCell(column: 4 + i, code: codes[i], text: ''),
      ],
    );

Map<String, String> translateAll(List<String> languages) =>
    <String, String>{for (final code in languages) code: 'text-$code'};

void main() {
  // Keep the test output clean: the pipeline logs every rejection to stderr.
  final logOut = $log, errOut = $err;
  setUp(() {
    $log = (_) {};
    $err = (_) {};
  });
  tearDown(() {
    $log = logOut;
    $err = errOut;
  });

  group('localizeRows', () {
    test('emits the row and fills every cell on success', () async {
      final client = FakeClient(translateAll);
      final row = rowWith(['uk', 'ru', 'de']);

      final emitted = await localizeRows(
        rows: [row],
        client: client,
        cellsPerBatch: 3,
      ).toList();

      expect(emitted, [same(row)]);
      expect(client.calls, [
        ['uk', 'ru', 'de']
      ]);
      expect(row.cells.map((c) => c.text), ['text-uk', 'text-ru', 'text-de']);
    });

    test('splits a failed batch into single-language retries', () async {
      final client = FakeClient((languages) {
        if (languages.length > 1)
          throw const LocalizationResponseException(
            'Model returned invalid JSON payload',
          );
        return translateAll(languages);
      });
      final row = rowWith(['uk', 'ru', 'de']);

      final emitted = await localizeRows(
        rows: [row],
        client: client,
        cellsPerBatch: 3,
      ).toList();

      expect(emitted, [same(row)]);
      expect(client.calls, [
        ['uk', 'ru', 'de'], // failed batch
        ['uk'], // fallback, one language at a time
        ['ru'],
        ['de'],
      ]);
      expect(row.cells.every((c) => !c.isEmpty), isTrue);
    });

    test('a hopeless language does not poison its neighbours', () async {
      final client = FakeClient((languages) {
        // "xx" is the rare language the model chokes on: it breaks the whole
        // batch, and keeps breaking when asked on its own.
        if (languages.contains('xx')) throw TimeoutException('stuck');
        return translateAll(languages);
      });
      final row = rowWith(['uk', 'xx', 'de']);

      final emitted = await localizeRows(
        rows: [row],
        client: client,
        cellsPerBatch: 3,
      ).toList();

      expect(emitted, [same(row)], reason: 'partial rows must still be saved');
      expect(client.calls, [
        ['uk', 'xx', 'de'],
        ['uk'],
        ['xx'],
        ['de'],
      ]);
      expect(row.cellFor('uk')!.text, 'text-uk');
      expect(row.cellFor('de')!.text, 'text-de');
      expect(row.cellFor('xx')!.isEmpty, isTrue);
    });

    test('retries only the language whose translation is invalid', () async {
      final row = rowWith(['uk', 'ru', 'de']);
      row.english = 'Hello, {name}!';
      var attempt = 0;
      final client = FakeClient((languages) {
        attempt++;
        if (attempt == 1)
          return <String, String>{
            'uk': 'Привіт, {name}!',
            'ru': 'Привет!', // dropped the placeholder
            'de': 'Hallo, {name}!',
          };
        return <String, String>{
          for (final code in languages) code: 'Привет, {name}!',
        };
      });

      final emitted = await localizeRows(
        rows: [row],
        client: client,
        cellsPerBatch: 3,
      ).toList();

      expect(emitted, [same(row)]);
      expect(client.calls, [
        ['uk', 'ru', 'de'],
        ['ru'], // only the rejected language is retried
      ]);
      expect(row.cellFor('uk')!.text, 'Привіт, {name}!');
      expect(row.cellFor('ru')!.text, 'Привет, {name}!');
      expect(row.cellFor('de')!.text, 'Hallo, {name}!');
    });

    test('does not retry a request that was already single-language', () async {
      final client = FakeClient((languages) {
        if (languages.single == 'xx') throw StateError('boom');
        return translateAll(languages);
      });
      final row = rowWith(['uk', 'xx']);

      await localizeRows(rows: [row], client: client, cellsPerBatch: 1)
          .toList();

      expect(client.calls, [
        ['uk'],
        ['xx'], // failed once, not retried with the same prompt
      ]);
      expect(row.cellFor('xx')!.isEmpty, isTrue);
    });

    test('does not emit a row where nothing could be localized', () async {
      final client = FakeClient((languages) => throw StateError('boom'));
      final row = rowWith(['uk', 'ru']);

      final emitted = await localizeRows(
        rows: [row],
        client: client,
        cellsPerBatch: 2,
      ).toList();

      expect(emitted, isEmpty);
    });

    test('keeps the batch size when there are more languages than fit',
        () async {
      final client = FakeClient(translateAll);
      final row = rowWith(['uk', 'ru', 'de', 'fr', 'es']);

      await localizeRows(rows: [row], client: client, cellsPerBatch: 2)
          .toList();

      expect(client.calls, [
        ['uk', 'ru'],
        ['de', 'fr'],
        ['es'],
      ]);
    });

    test('tolerates a label the model rewrote', () async {
      final client = FakeClient(translateAll);
      final row = rowWith(['uk'])..label = 'other_label';

      final emitted = await localizeRows(
        rows: [row],
        client: client,
        cellsPerBatch: 3,
      ).toList();

      expect(emitted, [same(row)]);
      expect(row.cellFor('uk')!.text, 'text-uk');
    });

    test('processes rows independently', () async {
      final client = FakeClient((languages) {
        if (languages.contains('xx')) throw StateError('boom');
        return translateAll(languages);
      });
      final good = rowWith(['uk'])..label = 'good';
      final bad = rowWith(['xx'])..label = 'bad';

      final emitted = await localizeRows(
        rows: [good, bad],
        client: client,
        cellsPerBatch: 3,
      ).toList();

      expect(emitted.map((r) => r.label), ['good']);
    });

    test('is empty for no rows', () async {
      final client = FakeClient(translateAll);
      expect(
        await localizeRows(rows: const [], client: client).toList(),
        isEmpty,
      );
      expect(client.calls, isEmpty);
    });
  });
}
