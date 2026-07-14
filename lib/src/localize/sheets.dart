/// Spreadsheet I/O of the localization pipeline, behind an interface.
///
/// The pipeline talks to this interface only, so the write path — range
/// building, failure classification, retries, rate limiting — is ordinary
/// testable code instead of something reachable only through a live Google
/// Sheets account.
library;

import 'dart:async';
import 'dart:collection';

import 'models.dart';
import 'utils.dart';

/// A single cell to write, addressed by its A1 [range].
class SheetUpdate {
  /// Creates a write of [value] into [range].
  const SheetUpdate({required this.range, required this.value});

  /// A1 range of the cell, e.g. `'App Strings'!E5`.
  final String range;

  /// Value to write.
  final String value;

  @override
  String toString() => '$range=$value';
}

/// A sheet as read from the spreadsheet.
typedef SheetData = ({String title, List<List<Object?>> values});

/// Failure reported by the spreadsheet backend.
class SheetsException implements Exception {
  /// Creates a failure with an optional HTTP [statusCode].
  const SheetsException(this.message, {this.statusCode});

  /// Human-readable reason.
  final String message;

  /// HTTP status code, when the backend provided one.
  final int? statusCode;

  /// Whether retrying the very same write can plausibly succeed.
  ///
  /// A malformed range, a missing scope or a deleted sheet fails identically
  /// on every attempt — retrying those only stalls every row queued behind.
  bool get isRetryable {
    final code = statusCode;
    if (code == null) return true; // network / transport
    if (code == 429) return true; // quota
    return code >= 500 && code < 600;
  }

  @override
  String toString() =>
      'SheetsException${statusCode == null ? '' : ' ($statusCode)'}: $message';
}

/// Read/write access to a spreadsheet.
abstract interface class SheetsGateway {
  /// Sheets of the spreadsheet, skipping those matching [ignore].
  Stream<SheetData> fetch({List<RegExp> ignore});

  /// Write [updates] in a single batch request.
  Future<void> write(List<SheetUpdate> updates);
}

/// Builds the A1 range of a cell.
///
/// The sheet title is quoted and its apostrophes doubled: a bare `App
/// Strings!E5` is not a valid range, and the API rejects the whole batch.
String cellRange({
  required String sheetTitle,
  required int column,
  required int row,
}) {
  final title = sheetTitle.replaceAll("'", "''");
  return "'$title'!${columnFromIndex(column)}${row + 1}";
}

/// Writes the localized cells of [row] into [sheetTitle], in one batch request.
///
/// Returns `true` when the row was written. A row that cannot be written is
/// reported and skipped — one unwritable row must not abort a run that may
/// have hundreds of good ones behind it.
Future<bool> updateRow({
  required SheetsGateway sheets,
  required String sheetTitle,
  required LocalizeRow row,
  RateLimiter? limiter,
  int attempts = 3,
  Duration Function(int attempt) backoff = defaultSheetsBackoff,
}) async {
  // Collect every non-empty cell into a single batch so the whole row is
  // written in ONE API request instead of one request per cell. This keeps us
  // well under the Google Sheets write quota (60 requests/min).
  final updates = <SheetUpdate>[
    for (final cell in row.cells)
      if (!cell.isEmpty)
        SheetUpdate(
          range: cellRange(
            sheetTitle: sheetTitle,
            column: cell.column,
            row: row.row,
          ),
          value: cell.text,
        ),
  ];
  if (updates.isEmpty) return false;

  for (var attempt = 1; attempt <= attempts; attempt++) {
    try {
      await limiter?.waitIfNeeded();
      await sheets.write(updates);
      return true;
    } on Object catch (e) {
      final retryable = e is! SheetsException || e.isRetryable;
      if (!retryable || attempt == attempts) {
        $err(
          'Error updating sheet "$sheetTitle" '
          'row [${row.row + 1}], skipping it: $e',
        );
        return false;
      }
      $err(
        'Retrying update for sheet "$sheetTitle" row [${row.row + 1}] '
        '(attempt $attempt/$attempts) due to error: $e',
      );
      await Future<void>.delayed(backoff(attempt));
    }
  }
  return false;
}

/// Exponential backoff between write attempts: 5s, 10s, 20s...
Duration defaultSheetsBackoff(int attempt) =>
    Duration(seconds: 5 * (1 << (attempt - 1)));

/// Rate limiter for spreadsheet calls: at most [maxRequestsPerMinute] within a
/// rolling [window].
///
/// Calls are serialized, so two concurrent callers cannot both squeeze past the
/// limit by observing the same pre-write state.
class RateLimiter {
  /// Creates a limiter allowing [maxRequestsPerMinute] calls per [window].
  ///
  /// [now] (milliseconds, monotonic) and [delay] are injectable so the limiter
  /// can be tested without spending real time.
  RateLimiter({
    required this.maxRequestsPerMinute,
    this.window = const Duration(minutes: 1),
    int Function()? now,
    Future<void> Function(Duration duration)? delay,
  })  : _now = now ?? _elapsed(),
        _delay = delay ?? _sleep;

  static int Function() _elapsed() {
    final stopwatch = Stopwatch()..start();
    return () => stopwatch.elapsedMilliseconds;
  }

  static Future<void> _sleep(Duration duration) =>
      Future<void>.delayed(duration);

  /// Maximum number of requests per rolling [window].
  final int maxRequestsPerMinute;

  /// Rolling window the limit applies to.
  final Duration window;

  final int Function() _now;
  final Future<void> Function(Duration duration) _delay;
  final Queue<int> _times = Queue<int>();
  Future<void> _tail = Future<void>.value();

  /// Wait, if necessary, until another request fits within the limit.
  Future<void> waitIfNeeded() {
    // Serialize: the check and the reservation must not interleave.
    final previous = _tail;
    final completer = Completer<void>();
    _tail = completer.future;
    return previous
        .then((_) => _reserve())
        .whenComplete(() => completer.complete());
  }

  Future<void> _reserve() async {
    final windowMs = window.inMilliseconds;
    final now = _now();

    // Drop requests that fell out of the window.
    while (_times.isNotEmpty && now - _times.first > windowMs)
      _times.removeFirst();

    if (_times.length >= maxRequestsPerMinute) {
      final wait = windowMs - (now - _times.first) + 100; // +100ms buffer
      $log('Rate limit reached, waiting ${wait}ms...');
      await _delay(Duration(milliseconds: wait));
      _times.removeFirst();
    }

    _times.add(_now());
  }
}
