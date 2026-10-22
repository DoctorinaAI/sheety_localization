import 'dart:io' as io;

import 'package:path/path.dart' as p;
import 'package:test/test.dart';

import '../sheety.dart';

void main() {
  group('resolveDartPageWidth', () {
    late io.Directory temp;

    setUp(() async {
      temp = await io.Directory.systemTemp.createTemp('sheety_page_width_');
    });

    tearDown(() async {
      await temp.delete(recursive: true);
    });

    TargetConfig dart(String output,
            [Map<String, Object?> options = const {}]) =>
        TargetConfig(target: Target.dart, output: output, options: options);

    test('defaults to 80 without an analysis_options.yaml', () {
      expect(resolveDartPageWidth(dart(p.join(temp.path, 'lib'))), 80);
    });

    test('reads the nearest analysis_options.yaml above the output', () {
      io.File(p.join(temp.path, 'analysis_options.yaml'))
          .writeAsStringSync('formatter:\n  page_width: 120\n');
      final output = p.join(temp.path, 'lib', 'src');
      expect(resolveDartPageWidth(dart(output)), 120);
    });

    test('the nearest file wins even without a page width', () {
      io.File(p.join(temp.path, 'analysis_options.yaml'))
          .writeAsStringSync('formatter:\n  page_width: 120\n');
      io.Directory(p.join(temp.path, 'pkg')).createSync();
      io.File(p.join(temp.path, 'pkg', 'analysis_options.yaml'))
          .writeAsStringSync('include: package:lints/recommended.yaml\n');
      expect(resolveDartPageWidth(dart(p.join(temp.path, 'pkg', 'lib'))), 80);
    });

    test('an explicit target option wins', () {
      io.File(p.join(temp.path, 'analysis_options.yaml'))
          .writeAsStringSync('formatter:\n  page_width: 120\n');
      final output = p.join(temp.path, 'lib');
      expect(resolveDartPageWidth(dart(output, {'page_width': 100})), 100);
      expect(resolveDartPageWidth(dart(output, {'pageWidth': 90})), 90);
    });

    test('a malformed analysis_options.yaml falls back to 80', () {
      io.File(p.join(temp.path, 'analysis_options.yaml'))
          .writeAsStringSync('formatter: [\n');
      expect(resolveDartPageWidth(dart(p.join(temp.path, 'lib'))), 80);
    });
  });

  group('resolveDartLanguageVersion', () {
    late io.Directory temp;
    setUp(() async {
      temp = await io.Directory.systemTemp.createTemp('sheety_language_');
    });
    tearDown(() async => temp.delete(recursive: true));

    TargetConfig dart(String output) =>
        TargetConfig(target: Target.dart, output: output);

    test('the minimum SDK of the nearest pubspec.yaml', () {
      io.File(p.join(temp.path, 'pubspec.yaml')).writeAsStringSync(
          'name: old\nenvironment:\n  sdk: ">=3.0.0 <4.0.0"\n');
      expect(resolveDartLanguageVersion(dart(p.join(temp.path, 'lib/src'))),
          '3.0');
    });

    test('a pubspec without an SDK constraint means the latest', () {
      io.File(p.join(temp.path, 'pubspec.yaml')).writeAsStringSync('name: x\n');
      expect(
          resolveDartLanguageVersion(dart(p.join(temp.path, 'lib'))), isNull);
    });

    test('constraint forms', () {
      expect(minimumSdkLanguageVersion('>=3.6.0 <4.0.0'), '3.6');
      expect(minimumSdkLanguageVersion('^3.7.2'), '3.7');
      expect(minimumSdkLanguageVersion('3.5.0'), '3.5');
      expect(minimumSdkLanguageVersion('>=2.19.0-0 <4.0.0'), '2.19');
      expect(minimumSdkLanguageVersion('<4.0.0'), isNull);
      expect(minimumSdkLanguageVersion('any'), isNull);
    });
  });
}
