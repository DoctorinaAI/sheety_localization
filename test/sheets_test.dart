import 'dart:async';

import 'package:sheety_localization/localize.dart';
import 'package:test/test.dart';

/// Scripted [SheetsGateway] that records what was written.
class FakeSheets implements SheetsGateway {
  FakeSheets({this.onWrite});

  /// Throw from here to simulate a failing write; [attempt] starts at 1.
  final FutureOr<void> Function(int attempt)? onWrite;

  /// Batches handed to [write], in call order.
  final List<List<SheetUpdate>> writes = <List<SheetUpdate>>[];

  @override
  Stream<SheetData> fetch({List<RegExp> ignore = const []}) =>
      const Stream<SheetData>.empty();

  @override
  Future<void> write(List<SheetUpdate> updates) async {
    writes.add(updates);
    await onWrite?.call(writes.length);
  }
}

LocalizeRow rowWith(Map<String, String> cells, {int row = 4}) => LocalizeRow(
      row: row,
      label: 'greeting',
      description: null,
      meta: null,
      english: 'Hello',
      cells: <LocalizeCell>[
        for (final (index, MapEntry(:key, :value))
            in cells.entries.indexed.toList())
          LocalizeCell(column: 4 + index, code: key, text: value),
      ],
    );

/// Backoff of zero, so the retry tests do not spend real time.
Duration noBackoff(int attempt) => Duration.zero;

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

  group('cellRange', () {
    test('quotes the sheet title', () {
      expect(
        cellRange(sheetTitle: 'app', column: 4, row: 4),
        "'app'!E5",
      );
    });

    test('survives a title with a space', () {
      // A bare `App Strings!E5` is not a valid A1 range: the API rejects the
      // whole batch with 400 and the row is never written.
      expect(
        cellRange(sheetTitle: 'App Strings', column: 4, row: 4),
        "'App Strings'!E5",
      );
    });

    test('doubles an apostrophe inside the title', () {
      expect(
        cellRange(sheetTitle: "Don't", column: 0, row: 0),
        "'Don''t'!A1",
      );
    });

    test('maps far columns', () {
      expect(cellRange(sheetTitle: 'app', column: 26, row: 99), "'app'!AA100");
    });
  });

  group('updateRow', () {
    test('writes every localized cell of a row in ONE batch', () async {
      final sheets = FakeSheets();
      final row = rowWith({'uk': 'Привіт', 'ru': 'Привет'});

      final written = await updateRow(
        sheets: sheets,
        sheetTitle: 'app',
        row: row,
      );

      expect(written, isTrue);
      expect(sheets.writes, hasLength(1));
      expect(
        sheets.writes.single.map((u) => (u.range, u.value)),
        [("'app'!E5", 'Привіт'), ("'app'!F5", 'Привет')],
      );
    });

    test('skips the cells that were never localized', () async {
      final sheets = FakeSheets();
      final row = rowWith({'uk': 'Привіт', 'xx': ''});

      await updateRow(sheets: sheets, sheetTitle: 'app', row: row);

      expect(sheets.writes.single.map((u) => u.range), ["'app'!E5"]);
    });

    test('writes nothing when no cell was localized', () async {
      final sheets = FakeSheets();
      final row = rowWith({'uk': '', 'ru': ''});

      final written = await updateRow(
        sheets: sheets,
        sheetTitle: 'app',
        row: row,
      );

      expect(written, isFalse);
      expect(sheets.writes, isEmpty);
    });

    test('retries a 429 and succeeds', () async {
      final sheets = FakeSheets(
        onWrite: (attempt) {
          if (attempt == 1)
            throw const SheetsException('quota', statusCode: 429);
        },
      );

      final written = await updateRow(
        sheets: sheets,
        sheetTitle: 'app',
        row: rowWith({'uk': 'Привіт'}),
        backoff: noBackoff,
      );

      expect(written, isTrue);
      expect(sheets.writes, hasLength(2));
    });

    test('retries a transport failure with no status', () async {
      final sheets = FakeSheets(
        onWrite: (attempt) {
          if (attempt == 1) throw const SheetsException('connection reset');
        },
      );

      final written = await updateRow(
        sheets: sheets,
        sheetTitle: 'app',
        row: rowWith({'uk': 'Привіт'}),
        backoff: noBackoff,
      );

      expect(written, isTrue);
      expect(sheets.writes, hasLength(2));
    });

    test('gives up immediately on a permanent failure', () async {
      // A bad range or a missing write scope fails the same way every time;
      // retrying it only stalls every row queued behind this one.
      final sheets = FakeSheets(
        onWrite: (_) => throw const SheetsException(
          'The caller does not have permission',
          statusCode: 403,
        ),
      );

      final written = await updateRow(
        sheets: sheets,
        sheetTitle: 'app',
        row: rowWith({'uk': 'Привіт'}),
        backoff: noBackoff,
      );

      expect(written, isFalse);
      expect(sheets.writes, hasLength(1), reason: '403 must not be retried');
    });

    test('skips the row after exhausting its retries', () async {
      final sheets = FakeSheets(
        onWrite: (_) => throw const SheetsException('boom', statusCode: 503),
      );

      final written = await updateRow(
        sheets: sheets,
        sheetTitle: 'app',
        row: rowWith({'uk': 'Привіт'}),
        backoff: noBackoff,
      );

      // The run must go on: one unwritable row cannot abort hundreds of good
      // ones behind it.
      expect(written, isFalse);
      expect(sheets.writes, hasLength(3));
    });

    test('waits on the rate limiter before writing', () async {
      final sheets = FakeSheets();
      var waited = 0;
      final limiter = RateLimiter(
        maxRequestsPerMinute: 60,
        now: () => 0,
        delay: (_) async => waited++,
      );

      await updateRow(
        sheets: sheets,
        sheetTitle: 'app',
        row: rowWith({'uk': 'Привіт'}),
        limiter: limiter,
      );

      expect(sheets.writes, hasLength(1));
      expect(waited, 0, reason: 'the first write fits within the quota');
    });
  });

  group('SheetsException.isRetryable', () {
    test('retries quota, 5xx and transport failures only', () {
      expect(const SheetsException('reset').isRetryable, isTrue);
      expect(
        const SheetsException('quota', statusCode: 429).isRetryable,
        isTrue,
      );
      expect(
        const SheetsException('backend', statusCode: 503).isRetryable,
        isTrue,
      );
      expect(
        const SheetsException('bad range', statusCode: 400).isRetryable,
        isFalse,
      );
      expect(
        const SheetsException('forbidden', statusCode: 403).isRetryable,
        isFalse,
      );
      expect(
        const SheetsException('gone', statusCode: 404).isRetryable,
        isFalse,
      );
    });
  });

  group('RateLimiter', () {
    test('lets requests through while under the limit', () async {
      var slept = Duration.zero;
      var clock = 0;
      final limiter = RateLimiter(
        maxRequestsPerMinute: 3,
        now: () => clock,
        delay: (duration) async => slept += duration,
      );

      for (var i = 0; i < 3; i++) {
        clock += 10;
        await limiter.waitIfNeeded();
      }

      expect(slept, Duration.zero);
    });

    test('waits out the window once the limit is reached', () async {
      var slept = Duration.zero;
      var clock = 0;
      final limiter = RateLimiter(
        maxRequestsPerMinute: 2,
        now: () => clock,
        delay: (duration) async => slept += duration,
      );

      await limiter.waitIfNeeded(); // at t=0
      clock = 1000;
      await limiter.waitIfNeeded(); // at t=1s
      clock = 2000;
      await limiter.waitIfNeeded(); // full: must wait out the oldest request

      // The oldest request was at t=0, the window ends at t=60s, we are at
      // t=2s: 58s to wait, plus the 100ms buffer.
      expect(slept, const Duration(milliseconds: 58100));
    });

    test('forgets requests that fell out of the window', () async {
      var slept = Duration.zero;
      var clock = 0;
      final limiter = RateLimiter(
        maxRequestsPerMinute: 2,
        now: () => clock,
        delay: (duration) async => slept += duration,
      );

      await limiter.waitIfNeeded();
      await limiter.waitIfNeeded();
      clock = 61000; // a minute later, both requests have aged out
      await limiter.waitIfNeeded();

      expect(slept, Duration.zero);
    });

    test('makes every concurrent caller past the first wait', () async {
      var sleeps = 0;
      final limiter = RateLimiter(
        maxRequestsPerMinute: 1,
        now: () => 0,
        delay: (_) async => sleeps++,
      );

      await Future.wait<void>([
        limiter.waitIfNeeded(),
        limiter.waitIfNeeded(),
        limiter.waitIfNeeded(),
      ]);

      expect(sleeps, 2, reason: 'every caller after the first must wait');
    });
  });
}
