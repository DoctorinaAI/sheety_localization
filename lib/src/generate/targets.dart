/// The emitters `generate` can run, keyed by [Target].
library;

import 'diagnostics.dart';
import 'emit/dart/dart_emitter.dart';
import 'emit/python/python_emitter.dart';
import 'emit/ts/ts_emitter.dart';
import 'emitter.dart';
import 'model.dart';

/// The type of the value of a target option (`targets.<t>.options.<key>`).
enum OptionKind {
  /// Any string.
  string('a string'),

  /// A normalized relative POSIX path (`src/generated`), or empty.
  relativePath('a relative path like src/generated (or "")'),

  /// `true` or `false`.
  boolean('true or false'),

  /// An integer greater than zero.
  positiveInteger('a positive integer');

  const OptionKind(this.description);

  /// What a valid value looks like, for error messages.
  final String description;

  /// Whether [value] is a valid value of this kind.
  bool accepts(Object? value) => switch (this) {
        OptionKind.string => value is String,
        OptionKind.relativePath => value is String &&
            (value.trim().isEmpty ||
                (!value.trim().startsWith('/') &&
                    !value.contains(r'\') &&
                    !value
                        .trim()
                        .split('/')
                        .any((s) => s.isEmpty || s == '.' || s == '..'))),
        OptionKind.boolean => value is bool,
        OptionKind.positiveInteger => value is int && value > 0,
      };
}

/// How the pipeline runs one [Target].
final class TargetSpec {
  /// Creates a registration.
  const TargetSpec({
    required this.target,
    required this.create,
    this.reserved = const {},
    this.options,
    this.legacyFile,
    this.validate,
  });

  /// The language.
  final Target target;

  /// Creates the emitter.
  final Emitter Function() create;

  /// Names the emitter uses itself, so the sheet cannot take them (passed to
  /// `validateIdentifiers`).
  final Set<String> reserved;

  /// The keys `options:` of the target may contain and the kind of their
  /// values; an unknown key or a value of another kind is an error. `null`
  /// accepts anything (typos are then not caught).
  final Map<String, OptionKind>? options;

  /// Recognizes, by relative path, files an older version generated into
  /// the output that this one no longer does (reported, never deleted).
  final bool Function(String relativePath)? legacyFile;

  /// Identifier checks of the target over its (filtered) catalog with the
  /// target's `options:`, replacing the default
  /// `validateIdentifiers(catalog, target, reserved: ...)`.
  final List<Diagnostic> Function(
    Catalog catalog,
    Map<String, Object?> options,
  )? validate;
}

/// A set of [TargetSpec]s.
final class TargetRegistry {
  /// Creates a registry of [specs].
  TargetRegistry(Iterable<TargetSpec> specs)
      : _specs = {for (final s in specs) s.target: s};

  final Map<Target, TargetSpec> _specs;

  /// The registration of [target], if available.
  TargetSpec? operator [](Target target) => _specs[target];

  /// Targets with an emitter.
  List<Target> get available => [
        for (final t in Target.values)
          if (_specs.containsKey(t)) t,
      ];
}

/// 0.6.0 wrote ARB files (`src/l10n/<scope>/app_<locale>.arb`) next to the
/// generated Dart; 1.0 no longer does.
bool isLegacyDartFile(String relativePath) => relativePath.endsWith('.arb');

/// The emitters shipped with the package.
TargetRegistry defaultTargets() => TargetRegistry([
      TargetSpec(
        target: Target.dart,
        create: DartEmitter.new,
        options: const {
          'directory': OptionKind.relativePath,
          'barrel': OptionKind.relativePath,
          'metadata': OptionKind.boolean,
          'page_width': OptionKind.positiveInteger,
          'pageWidth': OptionKind.positiveInteger,
        },
        legacyFile: isLegacyDartFile,
        validate: (catalog, options) =>
            const DartEmitter().validate(catalog, options),
      ),
      TargetSpec(
        target: Target.ts,
        create: TypeScriptEmitter.new,
        options: const {},
        validate: (catalog, _) => const TypeScriptEmitter().validate(catalog),
      ),
      const TargetSpec(
        target: Target.python,
        create: PythonEmitter.new,
        reserved: PythonEmitter.reservedNames,
        options: {},
      ),
    ]);
