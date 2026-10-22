import 'package:test/test.dart';

import '../sheety.dart';

final class _Echo implements Emitter {
  @override
  Target get target => Target.ts;

  @override
  List<GeneratedFile> emit(Catalog catalog, EmitOptions options) => [
        for (final scope in catalog.scopes)
          GeneratedFile(
            '${scope.name}/index.ts',
            '${options.headerComment('//')}export {};\n',
          ),
      ];
}

void main() {
  test('Target ids', () {
    expect(Target.values.map((t) => t.id), ['dart', 'ts', 'python']);
    expect(Target.byId('python'), Target.python);
    expect(Target.byId('js'), isNull);
  });

  test('GeneratedFile requires a normalized relative POSIX path', () {
    expect(GeneratedFile('a/b.dart', '').relativePath, 'a/b.dart');
    for (final bad in ['', '/a', 'a//b', './a', 'a/../b', r'a\b', 'a/']) {
      expect(() => GeneratedFile(bad, ''), throwsArgumentError, reason: bad);
    }
  });

  test('EmitOptions header and options', () {
    const options = EmitOptions(options: {'format': true, 'n': 3});
    expect(options.headerComment('//'),
        '// This file is generated, do not edit it manually!\n');
    expect(const EmitOptions(header: 'a\n\nb').headerComment('#'),
        '# a\n#\n# b\n');
    expect(const EmitOptions(header: '').headerComment('//'), '');
    expect(options.option('format', false), isTrue);
    expect(options.option('n', 'x'), 'x');
    expect(options.option('missing', 7), 7);
  });

  test('an emitter is a pure function of the catalog', () {
    final catalog = readCatalog([
      (
        title: 'app',
        values: [
          ['label', 'description', 'meta', 'en'],
          ['a', '', '', 'A'],
        ],
      ),
    ]).catalog;
    final files = _Echo().emit(catalog, const EmitOptions());
    expect(files.single.relativePath, 'app/index.ts');
    expect(files.single.contents, startsWith('// This file is generated'));
  });
}
