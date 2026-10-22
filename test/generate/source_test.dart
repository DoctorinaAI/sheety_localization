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
  });
}
