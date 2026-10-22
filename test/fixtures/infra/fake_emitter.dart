import 'package:sheety_localization/sheety_localization.dart';

/// A deterministic stand-in for a real emitter: one text file per scope
/// plus an index, and one `.dart` file so formatting can be observed.
final class FakeEmitter implements Emitter {
  FakeEmitter(this.target, {this.fail = false});

  @override
  final Target target;

  /// Throw from [emit].
  final bool fail;

  @override
  List<GeneratedFile> emit(Catalog catalog, EmitOptions options) {
    if (fail) throw StateError('boom');
    final header = options.headerComment('#');
    return [
      for (final scope in catalog.scopes)
        GeneratedFile(
          '${scope.name}/${scope.name}.txt',
          '$header'
              'locales: ${scope.localeTags.join(' ')}\n'
              'keys: ${[for (final m in scope.messages) m.key].join(' ')}\n'
              '${options.options.isEmpty ? '' : 'options: '
                  '${options.options}\n'}',
        ),
      GeneratedFile(
        'index.txt',
        '$header${[for (final s in catalog.scopes) s.name].join('\n')}\n',
      ),
      if (target == Target.dart)
        GeneratedFile(
          'scopes.dart',
          '${options.headerComment('//')}'
              'const scopes = <String>[${[
            for (final s in catalog.scopes) "'${s.name}'"
          ].join(', ')}];\n',
        ),
    ];
  }
}

/// A registry of [FakeEmitter]s for every target.
TargetRegistry fakeRegistry({
  Set<Target> failing = const {},
  Map<String, OptionKind>? options,
}) =>
    TargetRegistry([
      for (final t in Target.values)
        TargetSpec(
          target: t,
          create: () => FakeEmitter(t, fail: failing.contains(t)),
          reserved: const {'reservedByFake'},
          options: options,
          legacyFile: t == Target.dart ? isLegacyDartFile : null,
        ),
    ]);

/// Formatter that upper-cases `const` to show it ran (and records calls).
final class FakeFormatter implements CodeFormatter {
  int calls = 0;

  /// The language version of the last call.
  String? languageVersion;

  @override
  Future<List<GeneratedFile>> format(
    List<GeneratedFile> files, {
    int pageWidth = 80,
    String? languageVersion,
  }) async {
    calls++;
    this.languageVersion = languageVersion;
    return [
      for (final f in files)
        f.relativePath.endsWith('.dart')
            ? GeneratedFile(f.relativePath, '${f.contents}// formatted\n')
            : f,
    ];
  }
}
