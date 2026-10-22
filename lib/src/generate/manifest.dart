/// The manifest written into every target's output directory: what was
/// generated, from which input, by which generator version, and which files
/// the generator owns.
library;

import 'dart:convert';

import 'package:crypto/crypto.dart' as crypto;

import 'emitter.dart';
import 'model.dart';

/// Name of the package, recorded in the manifest.
const String generatorName = 'sheety_localization';

/// Version of the generator. Must equal `version:` in `pubspec.yaml` (a test
/// enforces it).
const String generatorVersion = '1.0.0';

/// File name of the manifest inside a target's output directory.
const String manifestFileName = 'sheety_manifest.json';

/// Version of the manifest format itself.
const int manifestFormat = 1;

/// Lowercase hex SHA-256 of the UTF-8 encoding of [contents].
String sha256Hex(String contents) =>
    crypto.sha256.convert(utf8.encode(contents)).toString();

/// Translation coverage of one locale of a scope.
final class LocaleCoverage {
  /// Creates coverage counts.
  const LocaleCoverage({required this.translated, required this.fallback});

  /// Messages with a text of their own in the locale.
  final int translated;

  /// Messages that fall back to the parent locale or the base language.
  final int fallback;

  /// JSON form.
  Map<String, Object?> toJson() =>
      {'translated': translated, 'fallback': fallback};
}

/// One scope as recorded in the manifest.
final class ManifestScope {
  /// Creates a scope entry.
  const ManifestScope({
    required this.name,
    required this.sheet,
    required this.baseLocale,
    required this.locales,
    required this.keys,
    required this.coverage,
    this.synthetic = const {},
  });

  /// Summarizes [scope].
  factory ManifestScope.of(Scope scope) => ManifestScope(
        name: scope.name,
        sheet: scope.sheetTitle,
        baseLocale: scope.baseLocale.code,
        locales: [for (final l in scope.localeTags) l.code],
        keys: scope.messages.length,
        synthetic: {
          for (final MapEntry(:key, :value) in scope.syntheticLocales.entries)
            key.code: value.code,
        },
        coverage: {
          for (final locale in scope.localeTags)
            locale.code: () {
              final fallback = scope.fallbackCount(locale);
              return LocaleCoverage(
                translated: scope.messages.length - fallback,
                fallback: fallback,
              );
            }(),
        },
      );

  /// Scope name (sanitized sheet title).
  final String name;

  /// Sheet title.
  final String sheet;

  /// Base locale code.
  final String baseLocale;

  /// Locale codes in scope order.
  final List<String> locales;

  /// Synthetic locales and the locale each was filled from.
  final Map<String, String> synthetic;

  /// Number of messages.
  final int keys;

  /// Per-locale coverage, keyed by locale code.
  final Map<String, LocaleCoverage> coverage;

  /// JSON form.
  Map<String, Object?> toJson() => {
        'name': name,
        'sheet': sheet,
        'baseLocale': baseLocale,
        'locales': locales,
        if (synthetic.isNotEmpty) 'synthetic': synthetic,
        'keys': keys,
        'coverage': {
          for (final MapEntry(:key, :value) in coverage.entries)
            key: value.toJson(),
        },
      };
}

/// Contents of [manifestFileName].
///
/// Deterministic: no timestamps, no absolute paths, files sorted by path.
final class Manifest {
  /// Creates a manifest.
  Manifest({
    required this.target,
    required this.sourceHash,
    required this.scopes,
    required Map<String, String> files,
    this.version = generatorVersion,
  }) : files = Map.unmodifiable(
          Map.fromEntries(
            files.entries.toList()..sort((a, b) => a.key.compareTo(b.key)),
          ),
        );

  /// The manifest for [files] generated for [target] from [catalog] (the
  /// catalog as filtered for that target).
  factory Manifest.build(
    Target target,
    Catalog catalog,
    Iterable<GeneratedFile> files,
  ) =>
      Manifest(
        target: target.id,
        sourceHash: sha256Hex(catalog.toCanonicalJson()),
        scopes: [for (final s in catalog.scopes) ManifestScope.of(s)],
        files: {for (final f in files) f.relativePath: sha256Hex(f.contents)},
      );

  /// Parses manifest JSON; throws [FormatException] when it is not one.
  ///
  /// Only the fields the writer relies on (`files`) are required; the rest
  /// is informational.
  factory Manifest.parse(String source) {
    final json = jsonDecode(source);
    if (json is! Map<String, Object?> || json['generator'] != generatorName) {
      throw const FormatException('not a $generatorName manifest');
    }
    final files = json['files'];
    if (files is! Map<String, Object?> ||
        files.values.any((v) => v is! String)) {
      throw const FormatException('"files" must map paths to hashes');
    }
    return Manifest(
      target: json['target'] is String ? json['target']! as String : '',
      sourceHash:
          json['sourceHash'] is String ? json['sourceHash']! as String : '',
      version: json['version'] is String ? json['version']! as String : '',
      scopes: const [],
      files: files.cast<String, String>(),
    );
  }

  /// Target id (`dart`, `ts`, `python`).
  final String target;

  /// Generator version that wrote the files.
  final String version;

  /// SHA-256 of the canonical JSON of the target's catalog.
  final String sourceHash;

  /// Scopes the target was generated from.
  final List<ManifestScope> scopes;

  /// Generated files (relative POSIX path -> SHA-256), sorted by path. The
  /// manifest itself is not listed.
  final Map<String, String> files;

  /// JSON form.
  Map<String, Object?> toJson() {
    final locales = <String>{for (final s in scopes) ...s.locales}.toList();
    final bases = {for (final s in scopes) s.baseLocale};
    return {
      'generator': generatorName,
      'version': version,
      'format': manifestFormat,
      'target': target,
      'sourceHash': sourceHash,
      'baseLocale': bases.length == 1 ? bases.single : null,
      'locales': locales,
      'scopes': [for (final s in scopes) s.toJson()],
      'files': files,
    };
  }

  /// The file contents: two-space indented JSON with a trailing newline.
  String encode() => '${const JsonEncoder.withIndent('  ').convert(toJson())}'
      '\n';
}
