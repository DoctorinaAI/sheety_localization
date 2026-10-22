// Checks the embedded subtag table against the registry shipped with the
// Flutter SDK (skipped without one) and regenerates it with UPDATE_GOLDENS=1.
import 'dart:io' as io;

import 'package:sheety_localization/sheety_localization.dart';
import 'package:sheety_localization/src/generate/emit/dart/locale_description.dart';
import 'package:test/test.dart';

import 'helpers.dart';

void main() {
  group('describeLocale', () {
    test('matches gen-l10n for the usual shapes', () {
      expect(describeLocale(LocaleTag.parse('pt')), 'Portuguese');
      expect(
        describeLocale(LocaleTag.parse('pt_BR')),
        'Portuguese, as used in Brazil',
      );
      expect(describeLocale(LocaleTag.parse('es')), 'Spanish Castilian');
      expect(describeLocale(LocaleTag.parse('el')), 'Modern Greek');
      expect(
        describeLocale(LocaleTag.parse('en_US')),
        'English, as used in the United States',
      );
      expect(
        describeLocale(LocaleTag.parse('zh_Hant')),
        'Chinese, using the Han script',
      );
      expect(
        describeLocale(LocaleTag.parse('zh_Hant_TW')),
        'Chinese, as used in Taiwan, using the Han script',
      );
      expect(
        describeLocale(LocaleTag.parse('es_419')),
        'Spanish Castilian, as used in Latin America and the Caribbean',
      );
      expect(describeLocale(LocaleTag.parse('fil')), 'Filipino Pilipino');
    });

    test('falls back to the code for unknown subtags', () {
      expect(describeLocale(LocaleTag.parse('qqq_QQ')), 'qqq, as used in QQ');
    });
  });

  final flutter = flutterSdkRoot();
  final registryFile = flutter == null
      ? null
      : io.File(
          '$flutter/packages/flutter_tools/lib/src/localizations/'
          'language_subtag_registry.dart',
        );
  test(
    'embedded table equals the Flutter SDK registry',
    () {
      final source = registryFile!.readAsStringSync();
      final registry = source.split("'''")[1];
      final fileDate =
          RegExp(r'File-Date: (\S+)').firstMatch(registry)!.group(1)!;
      final generated = subtagRegistrySource(
        parseSubtagRegistry(registry),
        fileDate: fileDate,
      );
      final target = io.File('lib/src/generate/emit/dart/subtag_registry.dart');
      if (updateGoldens) target.writeAsStringSync(generated);
      expect(target.readAsStringSync(), generated);
    },
    skip: registryFile == null || !registryFile.existsSync()
        ? 'Flutter SDK not found'
        : false,
  );
}
