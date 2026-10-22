// Tests over the real (internal) spreadsheet. The data is not part of the
// repository: point SHEETY_REAL_SNAPSHOT at a snapshot JSON
// (`{"sheets":[{"title":..,"values":[[..]]}]}`) and SHEETY_REAL_REFERENCE at
// the output of the previous generator for that snapshot (a directory with
// `lib/src/l10n/<scope>/app_<locale>.arb` and
// `lib/src/generated/<scope>/<scope>_localization.dart`). Without them the
// tests are skipped.
import 'dart:convert';
import 'dart:io' as io;

import 'package:sheety_localization/sheety_localization.dart';
import 'package:test/test.dart';

const _flutterScopes = [
  'app',
  'chat',
  'errors',
  'pay',
  'paywall',
  'profiles',
  'settings',
  'sign_up',
];

void main() {
  final snapshotPath = io.Platform.environment['SHEETY_REAL_SNAPSHOT'];
  final referencePath = io.Platform.environment['SHEETY_REAL_REFERENCE'];
  final skipSnapshot =
      snapshotPath == null ? 'SHEETY_REAL_SNAPSHOT is not set' : false;
  final skipReference = snapshotPath == null || referencePath == null
      ? 'SHEETY_REAL_SNAPSHOT / SHEETY_REAL_REFERENCE are not set'
      : false;

  late final List<SheetData> sheets;
  late final ReadResult result;
  late final ReadResult legacy;
  late final List<Diagnostic> validation;

  setUpAll(() {
    if (snapshotPath == null) return;
    final json = jsonDecode(io.File(snapshotPath).readAsStringSync())
        as Map<String, Object?>;
    sheets = [
      for (final sheet
          in (json['sheets']! as List<Object?>).cast<Map<String, Object?>>())
        (
          title: sheet['title']! as String,
          values: [
            for (final row in sheet['values']! as List<Object?>)
              (row! as List<Object?>).toList(),
          ],
        ),
    ];
    final mustache = [RegExp('^backend')];
    result = readCatalog(
      sheets,
      options: ReaderOptions(mustacheSheets: mustache),
    );
    legacy = readCatalog(
      sheets,
      options: ReaderOptions(
        includeEmpty: false,
        legacyRegionalOverride: true,
        mustacheSheets: mustache,
      ),
    );
    validation = validateCatalog(result.catalog, targets: Target.values);
  });

  group('real snapshot', () {
    test('every cell parses (backend sheets as mustache)', () {
      final syntax = result.diagnostics.where(
        (d) =>
            d.code == DiagnosticCode.icuSyntax ||
            d.code == DiagnosticCode.pluralMissingOther,
      );
      expect(syntax, isEmpty, reason: syntax.join('\n'));
      for (final name in _flutterScopes) {
        expect(result.catalog.scope(name), isNotNull, reason: name);
      }
    }, skip: skipSnapshot);

    test('backend-monetization is mustache with {{avg_cost}} / {{price}}', () {
      final scope = result.catalog.scope('backend_monetization')!;
      expect(scope.syntax, MessageSyntax.mustache);
      expect(
        scope.message('monetization_help_message2')!.placeholders.map(
              (p) => '$p',
            ),
        ['Object avg_cost'],
      );
      expect(
        scope.message('monetization_premium_offer')!.placeholders.single.name,
        'price',
      );
      expect(result.catalog.scope('chat')!.syntax, MessageSyntax.icu);
      // As ICU, the same sheet fails with a hint.
      final icu = readCatalog(
        sheets.where((s) => s.title == 'backend-monetization'),
      );
      expect(
        icu.diagnostics
            .where((d) => d.code == DiagnosticCode.icuSyntax)
            .map((d) => d.message.contains('looks like mustache')),
        allOf(hasLength(greaterThanOrEqualTo(2)), everyElement(isTrue)),
      );
    }, skip: skipSnapshot);

    test('no short rows are dropped and no parent is overridden', () {
      expect(
        result.diagnostics.where(
          (d) =>
              d.code == DiagnosticCode.shortRow ||
              d.code == DiagnosticCode.parentOverridden,
        ),
        isEmpty,
      );
      expect(
        legacy.diagnostics
            .where((d) => d.code == DiagnosticCode.shortRow)
            .length,
        4,
      );
    }, skip: skipSnapshot);

    test('help and locales are not localization sheets', () {
      final skipped = {
        for (final d in result.diagnostics)
          if (d.code == DiagnosticCode.notLocalizationSheet) d.sheetTitle,
      };
      expect(skipped, containsAll(<String>['help', 'locales']));
      expect(result.catalog.scope('help'), isNull);
      expect(result.catalog.scope('locales'), isNull);
    }, skip: skipSnapshot);

    test('prints the diagnostics', () {
      final all = [...result.diagnostics, ...validation];
      final counts = <String, int>{};
      for (final d in all) {
        final k = '${d.severity.name.padRight(7)} ${d.code.id}';
        counts[k] = (counts[k] ?? 0) + 1;
      }
      final summary = (counts.entries.toList()
            ..sort((a, b) => a.key.compareTo(b.key)))
          .map((e) => '  ${e.key}: ${e.value}')
          .join('\n');
      print('Diagnostics of the real snapshot:\n$summary');
      final out = io.Platform.environment['SHEETY_DIAGNOSTICS_OUT'];
      if (out != null) {
        io.File(out).writeAsStringSync('${formatDiagnostics(all)}\n');
        print('Full report written to $out');
      } else {
        print(formatDiagnostics(all, minimum: Severity.warning));
      }
    }, skip: skipSnapshot);

    test('canonical JSON is deterministic', () {
      final again = readCatalog(
        sheets,
        options: ReaderOptions(mustacheSheets: [RegExp('^backend')]),
      );
      expect(
        again.catalog.toCanonicalJson(),
        result.catalog.toCanonicalJson(),
      );
    }, skip: skipSnapshot);
  });

  for (final mode in ['legacy mode', 'default mode']) {
    final isLegacy = mode == 'legacy mode';
    group('real snapshot vs the previous generator ($mode)', () {
      for (final name in _flutterScopes) {
        test('$name: keys, texts, placeholders and descriptions match', () {
          final catalog = isLegacy ? legacy.catalog : result.catalog;
          final scope = catalog.scope(name)!;
          // Locales with a real column and a regional sibling column (ar with
          // ar_EG, pa with pa_PK): 0.6.0 let the regional column overwrite
          // them; the default mode keeps the real column's text.
          final overridable = {
            for (final l in scope.locales)
              if (l.tag.isLanguageOnly &&
                  !l.isSynthetic &&
                  scope.locales.any(
                    (r) => r.tag.parent == l.tag && !r.isSynthetic,
                  ))
                l.tag,
          };
          final values = sheets.firstWhere((s) => s.title == name).values;
          final dir = io.Directory('$referencePath/lib/src/l10n/$name');
          final arbs = {
            for (final file in dir.listSync().whereType<io.File>())
              if (file.path.endsWith('.arb'))
                _arbLocale(file):
                    jsonDecode(file.readAsStringSync()) as Map<String, Object?>,
          };
          final template = arbs['en']!;
          final templateKeys = [
            for (final k in template.keys)
              if (!k.startsWith('@')) k,
          ];
          expect(
            [for (final m in scope.messages) m.key],
            templateKeys,
            reason: 'message keys and their order',
          );

          // Same locales (synthetic parents included).
          expect(
            scope.localeTags.map((t) => t.code).toSet(),
            arbs.keys.toSet(),
          );

          for (final MapEntry(key: code, value: arb) in arbs.entries) {
            final locale = LocaleTag.parse(code);
            for (final message in scope.messages) {
              final own = message.translations[locale];
              if (!isLegacy && overridable.contains(locale)) {
                final expected = _ownCell(values, message.key, code);
                expect(own?.raw, expected, reason: '$code ${message.key}');
                if (own != null) expect(own.source, locale);
                continue;
              }
              final value = arb[message.key];
              expect(
                own?.raw,
                value,
                reason: '$code ${message.key} (row ${message.row})',
              );
            }
          }

          // Declared placeholders and descriptions, from the template meta.
          for (final message in scope.messages) {
            final meta = template['@${message.key}']! as Map<String, Object?>;
            expect(message.description, meta['description'],
                reason: message.key);
            final declared = switch (meta['placeholders']) {
              final Map<String, Object?> map => map,
              _ => const <String, Object?>{},
            };
            expect(
              [
                for (final p in message.placeholders)
                  if (p.declared) p.name,
              ],
              declared.keys.toList(),
              reason: message.key,
            );
            for (final MapEntry(key: p, value: attributes)
                in declared.entries) {
              final placeholder = message.placeholder(p)!;
              final attrs = attributes! as Map<String, Object?>;
              if (attrs['type'] case final String type) {
                expect(placeholder.type.arbName, type, reason: message.key);
              }
              expect(placeholder.example, attrs['example'], reason: p);
              expect(placeholder.description, attrs['description'], reason: p);
            }
          }

          // Signatures of the generated Dart: parameter order and inferred
          // types (undeclared placeholders are Object, plural counts num).
          final dart = io.File(
            '$referencePath/lib/src/generated/$name/${name}_localization.dart',
          ).readAsStringSync();
          final signatures = _signatures(dart);
          expect(signatures.keys.toList(), templateKeys);
          for (final message in scope.messages) {
            expect(
              [
                for (final p in message.placeholders)
                  '${p.type.arbName} ${p.name}',
              ],
              signatures[message.key],
              reason: message.key,
            );
          }
        }, skip: skipReference);
      }
    });
  }

  test('default mode differs from 0.6.0 only in overridden locales', () {
    var differing = 0;
    for (final name in _flutterScopes) {
      final a = result.catalog.scope(name)!;
      final b = legacy.catalog.scope(name)!;
      for (final m in a.messages) {
        for (final l in a.localeTags) {
          if (m.translations[l]?.raw !=
              b.message(m.key)!.translations[l]?.raw) {
            expect(l.code, 'ar', reason: '${m.key} $l');
            differing++;
          }
        }
      }
    }
    expect(differing, greaterThan(0));
  }, skip: skipReference);
}

final String Function(String) _sanitize = sanitizer();

/// The text of [key] in the [code] column: the last non-empty cell among the
/// rows with that label (duplicates overwrite).
String? _ownCell(List<List<Object?>> values, String key, String code) {
  final column = values.first.indexOf(code);
  String? text;
  for (final row in values.skip(1)) {
    if (row.isEmpty || row.first is! String) continue;
    if (_sanitize(row.first! as String) != key) continue;
    final cell = row.length > column ? row[column] : null;
    if (cell is String && cell.isNotEmpty) text = cell;
  }
  return text;
}

String _arbLocale(io.File file) {
  final json = jsonDecode(file.readAsStringSync()) as Map<String, Object?>;
  return json['@@locale']! as String;
}

/// Abstract members of the gen-l10n base class: key -> `Type name` params.
Map<String, List<String>> _signatures(String source) {
  final start = source.indexOf('abstract class ');
  final end = source.indexOf('class _', start);
  final body = source.substring(start, end);
  final member = RegExp(
    r'^\s*String\s+(?:get\s+(\w+)|(\w+)\s*\(([^)]*)\))\s*;',
    multiLine: true,
  );
  return {
    for (final m in member.allMatches(body))
      (m.group(1) ?? m.group(2))!: [
        for (final p in (m.group(3) ?? '').split(','))
          if (p.trim().isNotEmpty) p.trim().replaceAll(RegExp(r'\s+'), ' '),
      ],
  };
}
