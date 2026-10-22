// Parity of the Dart emitter with `flutter gen-l10n` on the real (internal)
// spreadsheet. The data is not part of the repository: point
// SHEETY_REAL_SNAPSHOT at the snapshot JSON and SHEETY_REAL_REFERENCE at the
// Flutter package generated from it by sheety_localization 0.6.0 +
// gen-l10n (`lib/localization.dart`, `lib/src/generated/**`). Without them
// the tests are skipped.
import 'dart:io' as io;

import 'package:path/path.dart' as p;
import 'package:sheety_localization/sheety_localization.dart';
import 'package:test/test.dart';

import '../../helpers.dart';
import 'helpers.dart';
import 'version_api.dart';

/// Sheets the Flutter package does not contain (the 0.6.0 `--ignore`).
final RegExp _ignored = RegExp('^help|^backend|^telegram|^locales');

/// 0.6.0's reader behaviour, which the reference was generated with.
const ReaderOptions _legacy =
    ReaderOptions(includeEmpty: false, legacyRegionalOverride: true);

void main() {
  final snapshotPath = io.Platform.environment['SHEETY_REAL_SNAPSHOT'];
  final referencePath = io.Platform.environment['SHEETY_REAL_REFERENCE'];
  final skip = snapshotPath == null || referencePath == null
      ? 'SHEETY_REAL_SNAPSHOT / SHEETY_REAL_REFERENCE are not set'
      : false;

  late io.Directory temp;
  late Map<String, String> reference;

  /// Emits [catalog], writes it under a fresh directory, formats it like
  /// the reference (page width 120) and reads it back.
  Future<Map<String, String>> formatted(
    Catalog catalog, {
    required bool metadata,
    required String name,
  }) async {
    final files = const DartEmitter().emit(
      catalog,
      EmitOptions(options: {'metadata': metadata}),
    );
    final root = p.join(temp.path, name);
    writeTree(root, {for (final f in files) f.relativePath: f.contents});
    final result = await dartFormat([root], pageWidth: 120);
    expect(result.exitCode, 0, reason: '${result.stderr}');
    return readTree(root);
  }

  Catalog flutterCatalog(ReaderOptions options) {
    final result = readCatalog(loadSnapshot(snapshotPath!), options: options);
    return result.catalog.where((s) => !_ignored.hasMatch(s.sheetTitle));
  }

  setUpAll(() async {
    if (skip != false) return;
    temp = io.Directory.systemTemp.createTempSync('sheety_dart_parity_');
    final lib = p.join(referencePath!, 'lib');
    final copy = p.join(temp.path, 'reference');
    writeTree(copy, {
      for (final MapEntry(:key, :value) in readTree(lib).entries)
        if (key == 'localization.dart' || key.startsWith('src/generated/'))
          key: value,
    });
    // The reference is already formatted; format it again with the same
    // formatter version as ours so only the emitter can make a difference.
    await dartFormat([copy], pageWidth: 120);
    reference = {
      for (final MapEntry(:key, :value) in readTree(copy).entries)
        key: escapeRawControls(value),
    };
  });

  tearDownAll(() {
    if (skip == false) temp.deleteSync(recursive: true);
  });

  test(
    'gen-l10n mode is identical to the reference after dart format',
    () async {
      final ours = await formatted(
        flutterCatalog(_legacy),
        metadata: false,
        name: 'ours',
      );
      expect(ours.keys.toSet(), reference.keys.toSet());
      final different = [
        for (final path in reference.keys)
          if (ours[path] != reference[path]) path,
      ];
      expect(
        different,
        isEmpty,
        reason: different.isEmpty
            ? null
            : firstDifference(reference[different.first]!,
                ours[different.first]!, different.first),
      );
    },
    skip: skip,
  );

  test(
    'with default reader options only ar/pa strings differ',
    () async {
      final ours = await formatted(
        flutterCatalog(const ReaderOptions()),
        metadata: false,
        name: 'defaults',
      );
      expect(ours.keys.toSet(), reference.keys.toSet());
      for (final path in reference.keys) {
        if (ours[path] == reference[path]) continue;
        expect(
          path,
          matches(RegExp(r'_localization_(ar|pa)\.dart$')),
          reason: firstDifference(reference[path]!, ours[path]!, path),
        );
      }
    },
    skip: skip,
  );

  test(
    'tool/version.dart sees the same API with and without metadata',
    () async {
      final catalog = flutterCatalog(_legacy);
      final plain = await formatted(catalog, metadata: false, name: 'api0');
      final meta = await formatted(catalog, metadata: true, name: 'api1');
      final raw = {
        for (final f in const DartEmitter().emit(catalog, const EmitOptions()))
          f.relativePath: f.contents,
      };
      final expected = VersionApi.of(reference);
      expect(expected.members, isNotEmpty);
      expect(expected.locales, hasLength(59));
      for (final (name, files) in [
        ('gen-l10n mode', plain),
        ('metadata', meta),
        ('metadata, unformatted', raw),
      ]) {
        final api = VersionApi.of(files);
        expect(api.members, expected.members, reason: name);
        expect(api.locales, expected.locales, reason: name);
      }
    },
    skip: skip,
  );
}

/// gen-l10n copies control characters other than `\n \f \t \r \b`
/// into the string literals verbatim; the emitter writes them as `\u{..}`
/// escapes (documented difference). Applies the same escaping to [code].
String escapeRawControls(String code) => code.replaceAllMapped(
      RegExp('[\x00-\x07\x0B\x0E-\x1F\x7F]'),
      (m) => '\\u{${m[0]!.codeUnitAt(0).toRadixString(16)}}',
    );

/// A short description of the first line where [expected] and [actual]
/// differ.
String firstDifference(String expected, String actual, String path) {
  final a = expected.split('\n');
  final b = actual.split('\n');
  for (var i = 0; i < a.length || i < b.length; i++) {
    final x = i < a.length ? a[i] : '<eof>';
    final y = i < b.length ? b[i] : '<eof>';
    if (x != y) {
      return '$path:${i + 1}\n  expected: $x\n  actual:   $y';
    }
  }
  return '$path: equal';
}
