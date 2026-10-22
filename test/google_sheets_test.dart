import 'dart:convert';

import 'package:googleapis/sheets/v4.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:sheety_localization/src/common/sheet_range.dart';
import 'package:test/test.dart';

import 'sheety.dart' hide sheetRange;

void main() {
  final logOut = $log, errOut = $err;
  setUp(() {
    $log = (_) {};
    $err = (_) {};
  });
  tearDown(() {
    $log = logOut;
    $err = errOut;
  });

  group('sheetRange', () {
    test('quotes titles that look like cell references', () {
      expect(sheetRange('v2'), "'v2'");
      expect(sheetRange('web1'), "'web1'");
      expect(sheetRange('App Strings'), "'App Strings'");
      expect(sheetRange("Bob's"), "'Bob''s'");
    });
  });

  group('GoogleSheetsGateway.fetch', () {
    test('reads every sheet through a quoted range', () async {
      // `v2`, `web1` and `ios16` are A1 cell references: unquoted, the API
      // returns that single cell of the first sheet instead of the sheet.
      final ranges = <String>[];
      final client = MockClient((request) async {
        final segments = request.url.pathSegments;
        final body = segments.contains('values')
            ? () {
                ranges.add(segments.last);
                return {
                  'values': [
                    ['label', 'description', 'meta', 'en', 'de'],
                    ['a', '', '', 'A', 'B'],
                  ],
                };
              }()
            : {
                'sheets': [
                  for (final (i, title) in ['v2', 'web1', 'ios16'].indexed)
                    {
                      'properties': {'sheetId': i, 'title': title},
                    },
                ],
              };
        return http.Response(
          jsonEncode(body),
          200,
          headers: {'content-type': 'application/json; charset=utf-8'},
        );
      });
      final gateway = GoogleSheetsGateway(api: SheetsApi(client), id: 'ID');

      final sheets = await gateway.fetch().toList();

      expect(sheets.map((s) => s.title), ['v2', 'web1', 'ios16']);
      expect(ranges, ["'v2'", "'web1'", "'ios16'"]);
    });
  });
}
