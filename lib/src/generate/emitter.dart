/// The contract between the core and the per-language code generators.
library;

import 'model.dart';

/// An output language of `generate`.
enum Target {
  /// Dart for Flutter (gen-l10n compatible).
  dart('dart'),

  /// TypeScript (ESM, no runtime dependencies).
  ts('ts'),

  /// Python (>= 3.9, no runtime dependencies).
  python('python');

  const Target(this.id);

  /// Stable identifier, used in config files and diagnostics.
  final String id;

  /// Looks a target up by its [id].
  static Target? byId(String id) {
    for (final t in values) if (t.id == id) return t;
    return null;
  }
}

/// Whether [text] contains a lone (unpaired) UTF-16 surrogate, which no
/// UTF-8 file can hold.
bool hasLoneSurrogate(String text) => _loneSurrogate.hasMatch(text);

/// [text] with every lone surrogate replaced by U+FFFD (the replacement
/// character), for comments and docstrings: string literals escape them and
/// keep the value, but a comment must be well-formed text (a lone surrogate
/// written to a UTF-8 file turns into U+FFFD anyway, so `--check` would never
/// match, and Python rejects it in a docstring).
String commentText(String text) => text.replaceAll(_loneSurrogate, '\uFFFD');

final RegExp _loneSurrogate = RegExp(
    r'[\uD800-\uDBFF](?![\uDC00-\uDFFF])|(?<![\uD800-\uDBFF])[\uDC00-\uDFFF]');

/// A file produced by an [Emitter].
final class GeneratedFile {
  /// Creates a file at [relativePath] with [contents].
  GeneratedFile(this.relativePath, this.contents) {
    if (relativePath.isEmpty ||
        relativePath.startsWith('/') ||
        relativePath.contains(r'\') ||
        relativePath
            .split('/')
            .any((s) => s.isEmpty || s == '.' || s == '..')) {
      throw ArgumentError.value(
        relativePath,
        'relativePath',
        'Must be a normalized relative POSIX path',
      );
    }
  }

  /// Path relative to the target's output directory, `/` separated.
  final String relativePath;

  /// File contents (UTF-8 when written).
  final String contents;

  @override
  String toString() => 'GeneratedFile($relativePath, '
      '${contents.length} chars)';
}

/// Options common to every emitter, plus target-specific ones.
final class EmitOptions {
  /// Creates options.
  const EmitOptions({
    this.header = defaultHeader,
    this.options = const <String, Object?>{},
  });

  /// The default [header].
  static const String defaultHeader =
      'This file is generated, do not edit it manually!';

  /// Text of the header comment of every generated file, without comment
  /// markers (an emitter prefixes each line with `// ` or `# `). Multiple
  /// lines are separated by `\n`. Empty means no header.
  final String header;

  /// Target-specific options (from `sheety.yaml` / CLI), e.g.
  /// `{'format': true}` for Dart.
  final Map<String, Object?> options;

  /// The option [key] if it is a [T], otherwise [fallback].
  T option<T>(String key, T fallback) => switch (options[key]) {
        final T value => value,
        _ => fallback,
      };

  /// [header] as comment lines starting with [prefix] (`//`, `#`), each
  /// followed by a newline; empty when there is no header.
  String headerComment(String prefix) {
    if (header.isEmpty) return '';
    return [
      for (final line in header.split('\n'))
        line.isEmpty ? '$prefix\n' : '$prefix $line\n',
    ].join();
  }
}

/// Generates the files of one [target] from a [Catalog].
///
/// Emitters are pure: same catalog and options, byte-identical files (no
/// timestamps, no absolute paths, stable ordering).
abstract interface class Emitter {
  /// The language this emitter produces.
  Target get target;

  /// Generates every file for [catalog]. Paths are relative to the target's
  /// output directory.
  List<GeneratedFile> emit(Catalog catalog, EmitOptions options);
}
