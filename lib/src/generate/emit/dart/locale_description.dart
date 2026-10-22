/// English names of locales, exactly as gen-l10n's `describeLocale` writes
/// them into the doc comment of every locale class
/// (`/// The translations for Portuguese, as used in Brazil (`pt_BR`).`).
library;

import '../../model.dart';
import 'subtag_registry.dart';

Map<String, String>? _languages;
Map<String, String>? _regions;
Map<String, String>? _scripts;

Map<String, String> _parse(String table) => {
      for (final line in table.split('\n'))
        if (line.indexOf('\t') case final tab when tab > 0)
          line.substring(0, tab): line.substring(tab + 1),
    };

/// The registry description of the language subtag [code] (`pt` ->
/// `Portuguese`), or `null` when the registry does not know it.
String? languageDescription(String code) =>
    (_languages ??= _parse(subtagLanguages))[code];

/// The registry description of the region subtag [code] (`BR` -> `Brazil`).
String? regionDescription(String code) =>
    (_regions ??= _parse(subtagRegions))[code];

/// The registry description of the script subtag [code] (`Hant` ->
/// `Han (Traditional variant)`, shortened to `Han`).
String? scriptDescription(String code) =>
    (_scripts ??= _parse(subtagScripts))[code];

/// gen-l10n's `describeLocale`: `Portuguese, as used in Brazil`,
/// `Chinese, using the Han script`, `Chinese, as used in Taiwan, using the
/// Han script`.
///
/// gen-l10n aborts on a language that is not in the IANA registry; this
/// function uses the code itself instead (documented difference).
String describeLocale(LocaleTag locale) {
  var output = languageDescription(locale.language) ?? locale.language;
  final region = switch (locale.country) {
    final String country => regionDescription(country) ?? country,
    null => null,
  };
  final script = switch (locale.script) {
    final String script => scriptDescription(script) ?? script,
    null => null,
  };
  if (region != null) output += ', as used in $region';
  if (script != null) output += ', using the $script script';
  return output;
}

/// Turns a raw IANA registry (the text of Flutter's
/// `language_subtag_registry.dart`) into the three tables of
/// `subtag_registry.dart`, applying gen-l10n's
/// `precacheLanguageAndRegionTags` rules: multiple descriptions are joined
/// with a space, `United ...` and `... Republic` get a leading `the `, and
/// the text is cut at ` (` and at `, Province of `.
({
  Map<String, String> languages,
  Map<String, String> regions,
  Map<String, String> scripts,
}) parseSubtagRegistry(String registry) {
  final languages = <String, String>{};
  final regions = <String, String>{};
  final scripts = <String, String>{};
  for (final section in registry.split('%%').skip(1)) {
    final fields = <String, List<String>>{};
    List<String>? last;
    for (final line in section.split('\n')) {
      if (line.isEmpty) continue;
      if (line.startsWith('  ')) {
        last![last.length - 1] = '${last.last}${line.substring(1)}';
        continue;
      }
      final colon = line.indexOf(':');
      if (colon <= 0) throw FormatException('Unexpected line', line);
      last = fields.putIfAbsent(line.substring(0, colon), () => [])
        ..add(line.substring(colon + 2));
    }
    final type = fields['Type']?.single;
    final target = switch (type) {
      'language' => languages,
      'region' => regions,
      'script' => scripts,
      _ => null,
    };
    if (target == null) continue;
    var description = fields['Description']!.join(' ');
    if (description.startsWith('United ')) description = 'the $description';
    if (description.contains(' (')) {
      description = description.substring(0, description.indexOf(' ('));
    }
    if (description.contains(', Province of ')) {
      description =
          description.substring(0, description.indexOf(', Province of '));
    }
    if (description.endsWith(' Republic')) description = 'the $description';
    target[fields['Subtag']!.single] = description;
  }
  return (languages: languages, regions: regions, scripts: scripts);
}

const String _doc = 'Subtag, tab, description; one per line.';

/// Source of `subtag_registry.dart` for the given tables.
String subtagRegistrySource(
  ({
    Map<String, String> languages,
    Map<String, String> regions,
    Map<String, String> scripts,
  }) tables, {
  required String fileDate,
}) {
  String table(String name, String doc, Map<String, String> entries) {
    final lines = [
      for (final MapEntry(:key, :value) in entries.entries) '$key\t$value',
    ];
    for (final line in lines) {
      if (line.contains("'''") || line.contains('\n')) {
        throw FormatException('Cannot embed', line);
      }
    }
    return "/// $doc\nconst String $name = r'''\n${lines.join('\n')}\n''';\n";
  }

  return '// GENERATED from the IANA language subtag registry cached by\n'
      '// Flutter (packages/flutter_tools/lib/src/localizations/\n'
      '// language_subtag_registry.dart, File-Date: $fileDate), with the\n'
      "// description rules of gen-l10n's precacheLanguageAndRegionTags.\n"
      '// Regenerate with:\n'
      '//   UPDATE_GOLDENS=1 dart test '
      'test/generate/emit/dart/locale_description_test.dart\n'
      '// ignore_for_file: lines_longer_than_80_chars\n'
      'library;\n'
      '\n'
      '${table('subtagLanguages', _doc, tables.languages)}'
      '\n'
      '${table('subtagRegions', _doc, tables.regions)}'
      '\n'
      '${table('subtagScripts', _doc, tables.scripts)}';
}
