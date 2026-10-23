import 'dart:convert';
import 'dart:io' as io;

import 'package:googleapis/sheets/v4.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:path/path.dart' as p;
import 'package:sheety_localization/src/generate/source.dart';
import 'package:test/test.dart';

const _fixture = 'test/fixtures/infra/multi_snapshot.json';

void main() {
  late io.Directory temp;
  setUp(() => temp = io.Directory.systemTemp.createTempSync('sheety_src_'));
  tearDown(() => temp.deleteSync(recursive: true));

  group('SnapshotSource', () {
    test('reads every sheet in order', () async {
      final sheets = await const SnapshotSource(_fixture).fetchAll();
      expect([for (final s in sheets) s.title],
          ['help', 'app', 'sign-up', 'backend-mail']);
      expect(sheets[1].values.first, contains('pt_BR'));
    });

    test('filters by title', () async {
      final sheets = await const SnapshotSource(_fixture)
          .fetchAll(where: (t) => t.startsWith('app'));
      expect([for (final s in sheets) s.title], ['app']);
    });

    test('reports a missing file', () {
      expect(
        const SnapshotSource('nope.json').fetchAll(),
        throwsA(isA<SheetSourceException>()
            .having((e) => e.message, 'message', contains('not found'))),
      );
    });

    test('reports a file that is not UTF-8 or cannot be read', () async {
      final latin1 = io.File(p.join(temp.path, 'latin1.json'))
        ..writeAsBytesSync([0x7B, 0x22, 0xE9, 0xFF, 0x22, 0x7D]);
      await expectLater(
        SnapshotSource(latin1.path).fetchAll(),
        throwsA(isA<SheetSourceException>().having((e) => e.message, 'message',
            contains('Cannot read the snapshot ${latin1.path}'))),
      );
      if (io.Platform.isWindows) return;
      final locked = io.File(p.join(temp.path, 'locked.json'))
        ..writeAsStringSync('{"sheets": []}');
      io.Process.runSync('chmod', ['000', locked.path]);
      addTearDown(() => io.Process.runSync('chmod', ['644', locked.path]));
      // Running as root reads it anyway.
      if (io.Process.runSync('cat', [locked.path]).exitCode == 0) return;
      await expectLater(
        SnapshotSource(locked.path).fetchAll(),
        throwsA(isA<SheetSourceException>().having(
            (e) => e.message, 'message', contains('Cannot read the snapshot'))),
      );
    });

    test('reports invalid JSON and a wrong shape', () async {
      final bad = io.File(p.join(temp.path, 'bad.json'))
        ..writeAsStringSync('{');
      await expectLater(
        SnapshotSource(bad.path).fetchAll(),
        throwsA(isA<SheetSourceException>()
            .having((e) => e.message, 'message', contains('not valid JSON'))),
      );
      for (final (json, what) in [
        ('[]', 'root is not an object'),
        ('{"sheets": 1}', '"sheets" is not a list'),
        ('{"sheets": [{"title": 1, "values": []}]}', 'sheets[0]'),
        ('{"sheets": [{"title": "a", "values": [1]}]}', 'not a list'),
      ]) {
        bad.writeAsStringSync(json);
        await expectLater(
          SnapshotSource(bad.path).fetchAll(),
          throwsA(isA<SheetSourceException>()
              .having((e) => e.message, 'message', contains(what))),
          reason: json,
        );
      }
    });

    test('writeSnapshot round-trips and matches the dump format', () async {
      final sheets = await const SnapshotSource(_fixture).fetchAll();
      final out = p.join(temp.path, 'nested', 'dump.json');
      await writeSnapshot(out, sheets);
      final text = io.File(out).readAsStringSync();
      expect(text, startsWith('{\n "sheets": [\n  {\n   "title": "help"'));
      expect(text, endsWith('}\n'));
      final again = await SnapshotSource(out).fetchAll();
      expect(encodeSnapshot(again), text);
    });
  });

  group('sheetRange', () {
    test('quotes titles and doubles apostrophes', () {
      expect(sheetRange('app'), "'app'");
      expect(sheetRange('App Strings'), "'App Strings'");
      expect(sheetRange("Bob's"), "'Bob''s'");
      expect(sheetRange('A1'), "'A1'");
    });
  });

  group('GoogleSheetSource', () {
    GoogleSheetSource source(
      Future<http.Response> Function(http.Request) handler, {
      int rangesPerRequest = 40,
    }) =>
        GoogleSheetSource(
          api: SheetsApi(MockClient(handler)),
          spreadsheetId: 'ID',
          rangesPerRequest: rangesPerRequest,
        );

    http.Response json(Object body) => http.Response(
          jsonEncode(body),
          200,
          headers: {'content-type': 'application/json; charset=utf-8'},
        );

    Map<String, Object?> spreadsheet(List<String> titles) => {
          'sheets': [
            for (final (i, t) in titles.indexed)
              {
                'properties': {'sheetId': i, 'title': t},
              },
          ],
        };

    test('reads all selected sheets with quoted ranges, in chunks', () async {
      final batches = <List<String>>[];
      final s = source(rangesPerRequest: 2, (request) async {
        final url = request.url;
        if (url.path.endsWith(':batchGet')) {
          final ranges = url.queryParametersAll['ranges']!;
          batches.add(ranges);
          return json({
            'valueRanges': [
              for (final r in ranges)
                {
                  'range': r,
                  if (r != "'empty'")
                    'values': [
                      ['label', 'description', 'meta', 'en'],
                      ['k', '', '', r],
                    ],
                },
            ],
          });
        }
        expect(url.path, endsWith('/spreadsheets/ID'));
        return json(spreadsheet(['App Strings', "Bob's", 'skip', 'empty']));
      });
      final sheets = await s.fetchAll(where: (t) => t != 'skip');
      expect(batches, [
        ["'App Strings'", "'Bob''s'"],
        ["'empty'"],
      ]);
      expect(
          [for (final x in sheets) x.title], ['App Strings', "Bob's", 'empty']);
      expect(sheets.first.values[1][3], "'App Strings'");
      expect(sheets.last.values, isEmpty);
    });

    test('translates API errors with a hint', () async {
      final s = source((request) async => http.Response(
            jsonEncode({
              'error': {
                'code': 403,
                'message': 'The caller does not have '
                    'permission'
              },
            }),
            403,
            headers: {'content-type': 'application/json'},
          ));
      await expectLater(
        s.fetchAll(),
        throwsA(isA<SheetSourceException>()
            .having((e) => e.statusCode, 'statusCode', 403)
            .having((e) => e.message, 'message', contains('service account'))),
      );
    });

    test('a spreadsheet without sheets is an error', () async {
      final s = source((request) async => json({'sheets': <Object>[]}));
      await expectLater(s.fetchAll(), throwsA(isA<SheetSourceException>()));
    });
  });

  group('createSheetsClient', () {
    test('missing and malformed credentials are typed errors', () async {
      await expectLater(
        createSheetsClient(p.join(temp.path, 'none.json')),
        throwsA(isA<SheetSourceException>()
            .having((e) => e.message, 'message', contains('not found'))),
      );
      final bad = io.File(p.join(temp.path, 'bad.json'))
        ..writeAsStringSync('{"type": "nope"}');
      await expectLater(
        createSheetsClient(bad.path),
        throwsA(isA<SheetSourceException>().having(
            (e) => e.message, 'message', contains('not a service account'))),
      );
    });

    // A key file the error messages must never quote any of.
    const sentinel = 'PRIVATESENTINEL';
    const key = '-----BEGIN PRIVATE KEY-----\\n'
        'MIIEvAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA$sentinel\\n'
        '-----END PRIVATE KEY-----\\n';
    for (final (name, contents) in [
      // A trailing comma right after the key: a FormatException whose
      // toString() quotes the source around it.
      (
        'malformed JSON',
        '{"type": "service_account", "client_email": "a@b.c", '
            '"client_id": "1", "private_key": "$key",}'
      ),
      // Valid JSON, but the key cannot be parsed.
      (
        'an invalid key',
        '{"type": "service_account", "private_key": "$key", '
            '"client_email": "a@b.c", "client_id": "1"}'
      ),
      // Valid JSON of another kind.
      ('another kind of key', '{"type": "user", "private_key": "$key"}'),
    ]) {
      test('$name: the error does not quote the private key', () async {
        final file = io.File(p.join(temp.path, 'key.json'))
          ..writeAsStringSync(contents);
        for (final call in [
          () => createSheetsClient(file.path),
          () => readServiceAccountCredentials(file.path),
        ]) {
          final error =
              await call().then<Object?>((_) => null, onError: (Object e) => e);
          expect(error, isA<SheetSourceException>());
          expect('$error', isNot(contains(sentinel)));
          expect('$error', contains(file.path));
        }
      });
    }

    test('a JSON error reports its reason and offset', () async {
      final file = io.File(p.join(temp.path, 'key.json'))
        ..writeAsStringSync('{"private_key": "x",}');
      await expectLater(
        readServiceAccountCredentials(file.path),
        throwsA(isA<SheetSourceException>().having((e) => e.message, 'message',
            allOf(contains('not valid JSON'), contains('offset')))),
      );
    });
  });

  group('redactCredentials', () {
    test('removes the key and each of its lines', () {
      const key = '-----BEGIN PRIVATE KEY-----\n'
          'AAAAPRIVATESENTINEL1AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\n'
          'BBBBPRIVATESENTINEL2BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB\n'
          '-----END PRIVATE KEY-----\n';
      final redacted =
          redactCredentials('boom: $key; line: ${key.split('\n')[2]}', key);
      expect(redacted, isNot(contains('PRIVATESENTINEL')));
      expect(redacted, contains('<redacted>'));
      expect(redactCredentials('nothing secret', key), 'nothing secret');
    });
  });
}
