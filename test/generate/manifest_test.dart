import 'dart:convert';
import 'dart:io' as io;

import 'package:sheety_localization/sheety_localization.dart';
import 'package:test/test.dart';
import 'package:yaml/yaml.dart';

Future<Catalog> _catalog() async {
  final sheets = await const SnapshotSource('test/fixtures/basic_snapshot.json')
      .fetchAll();
  return readCatalog(sheets).catalog;
}

void main() {
  test('generatorVersion matches pubspec.yaml', () {
    final pubspec =
        loadYaml(io.File('pubspec.yaml').readAsStringSync()) as YamlMap;
    expect(generatorVersion, pubspec['version']);
  });

  test('sha256Hex', () {
    expect(sha256Hex(''),
        'e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855');
  });

  group('Manifest', () {
    test('is deterministic and sorts files', () async {
      final catalog = await _catalog();
      final files = [
        GeneratedFile('b/x.txt', 'b'),
        GeneratedFile('a.txt', 'a'),
      ];
      final one = Manifest.build(Target.ts, catalog, files).encode();
      final two =
          Manifest.build(Target.ts, catalog, files.reversed.toList()).encode();
      expect(one, two);
      expect(one, endsWith('}\n'));
      final json = jsonDecode(one) as Map<String, Object?>;
      expect((json['files']! as Map).keys, ['a.txt', 'b/x.txt']);
      expect(json['generator'], 'sheety_localization');
      expect(json['version'], generatorVersion);
      expect(json['target'], 'ts');
      expect(json['sourceHash'], sha256Hex(catalog.toCanonicalJson()));
      expect(one, isNot(contains(RegExp(r'\d{4}-\d\d-\d\dT'))));
    });

    test('records scopes, locales, keys and coverage', () async {
      final catalog = await _catalog();
      final json = Manifest.build(Target.dart, catalog, const []).toJson();
      expect(json['baseLocale'], 'en');
      final scopes = (json['scopes']! as List).cast<Map<String, Object?>>();
      expect([for (final s in scopes) s['name']], ['app', 'sign_up']);
      final app = scopes.first;
      expect(app['sheet'], 'app');
      expect(app['keys'], 7);
      expect(app['locales'], containsAll(['en', 'ru', 'pt_BR', 'pt', 'de']));
      expect((app['synthetic']! as Map)['pt'], 'pt_BR');
      final coverage = app['coverage']! as Map<String, Object?>;
      expect(coverage['en'], {'translated': 7, 'fallback': 0});
      final pt = coverage['pt_BR']! as Map<String, Object?>;
      expect(pt['fallback'], greaterThan(0));
      expect((pt['translated']! as int) + (pt['fallback']! as int), 7);
      expect((json['locales']! as List).first, 'en');
    });

    test('parse reads files back and rejects foreign JSON', () async {
      final catalog = await _catalog();
      final text = Manifest.build(
          Target.python, catalog, [GeneratedFile('x.py', 'print()')]).encode();
      final parsed = Manifest.parse(text);
      expect(parsed.files, {'x.py': sha256Hex('print()')});
      expect(parsed.target, 'python');
      expect(() => Manifest.parse('{"name": "app"}'), throwsFormatException);
      expect(() => Manifest.parse('[]'), throwsFormatException);
      expect(
        () => Manifest.parse(
            '{"generator": "sheety_localization", "files": {"a": 1}}'),
        throwsFormatException,
      );
    });
  });
}
