import 'dart:convert';
import 'dart:io' as io;

// The intl cross-check needs intl's own rule table to know which locales it
// covers; the public API only exposes evaluation.
// ignore: implementation_imports
import 'package:intl/src/plural_rules.dart' as intl_rules;
import 'package:intl/intl.dart' as intl;
import 'package:test/test.dart';

import '../sheety.dart';
import 'helpers.dart' show hasTool;

/// Locales of the real sheets (Flutter and backend scopes).
const _sheetLocales = [
  'en', 'ru', 'be', 'es', 'de', 'hi', 'it', 'fr', 'pt', 'pt_BR', 'zh', //
  'zh_CN', 'ko', 'bn', 'ar', 'fa', 'uz', 'he', 'id', 'ur', 'ja', 'ar_EG',
  'mr', 'vi', 'te', 'tr', 'pa_PK', 'sw', 'ta', 'zh_HK', 'th', 'gu', 'kn',
  'tl', 'pa', 'ml', 'my', 'uk', 'nl', 'am', 'ms', 'ne', 'ro', 'si', 'az',
  'km', 'ps', 'el', 'kk', 'hu', 'zu', 'cs', 'lo', 'bg', 'af', 'ca', 'da',
  'sk', 'pl',
];

void main() {
  test('intlMissingPluralLocales lists exactly what package:intl lacks', () {
    final missing = <String>{
      for (final locale in pluralLocales())
        if (!intl_rules.localeHasPluralRules(locale) &&
            pluralRulesFor(locale).conditions.isNotEmpty)
          locale,
    };
    expect(intlMissingPluralLocales, missing);
    // intl renders every such count as `other`; CLDR does not.
    for (final (locale, n, cldr) in [('gd', 3, 'few'), ('kw', 21, 'many')]) {
      expect(intlLacksPluralRules(locale), isTrue);
      expect(pluralRulesFor(locale).selectNum(n).name, cldr);
      expect(
        intl.Intl.pluralLogic<String>(n,
            locale: locale, few: 'few', many: 'many', other: 'other'),
        'other',
      );
    }
    expect(intlLacksPluralRules('gd_GB'), isTrue);
    expect(intlLacksPluralRules('ru'), isFalse);
    expect(intlLacksPluralRules('xx'), isFalse);
  });

  group('PluralCondition.parse', () {
    test('parses and prints relations', () {
      final c = PluralCondition.parse(
        'v = 0 and i % 10 = 2..4 and i % 100 != 12..14 or f = 1,3',
      );
      expect(c.alternatives, hasLength(2));
      expect(
        c.toString(),
        'v = 0 and i % 10 = 2..4 and i % 100 != 12..14 or f = 1,3',
      );
    });

    test('empty condition is always true', () {
      final c = PluralCondition.parse('  ');
      expect(c.isAlways, isTrue);
      expect(c.evaluate(PluralOperands.parse('42')), isTrue);
    });

    test('rejects malformed rules', () {
      for (final bad in [
        'x = 1',
        'n =',
        'n = 1 and',
        'n % 0 = 1',
        'n = 3..1'
      ]) {
        expect(
          () => PluralCondition.parse(bad),
          throwsFormatException,
          reason: bad,
        );
      }
    });

    test('every embedded CLDR rule parses', () {
      for (final ordinal in [false, true]) {
        for (final locale in pluralLocales(ordinal: ordinal)) {
          expect(
            () => pluralRulesFor(
              locale,
              type: ordinal ? PluralType.ordinal : PluralType.cardinal,
            ),
            returnsNormally,
            reason: locale,
          );
        }
      }
    });
  });

  group('PluralOperands', () {
    test('parse follows UTS #35 examples', () {
      expect(PluralOperands.parse('1'), const PluralOperands(i: 1));
      expect(
        PluralOperands.parse('1.0'),
        const PluralOperands(i: 1, v: 1),
      );
      expect(
        PluralOperands.parse('1.00'),
        const PluralOperands(i: 1, v: 2),
      );
      expect(
        PluralOperands.parse('1.3'),
        const PluralOperands(i: 1, v: 1, w: 1, f: 3, t: 3),
      );
      expect(
        PluralOperands.parse('1.30'),
        const PluralOperands(i: 1, v: 2, w: 1, f: 30, t: 3),
      );
      expect(
        PluralOperands.parse('1.03'),
        const PluralOperands(i: 1, v: 2, w: 2, f: 3, t: 3),
      );
      expect(
        PluralOperands.parse('1.230'),
        const PluralOperands(i: 1, v: 3, w: 2, f: 230, t: 23),
      );
      expect(
        PluralOperands.parse('1.2c6'),
        const PluralOperands(i: 1200000, e: 6),
      );
      expect(
        PluralOperands.parse('1.0000001c6'),
        const PluralOperands(i: 1000000, v: 1, w: 1, f: 1, t: 1, e: 6),
      );
      expect(PluralOperands.parse('-3'), const PluralOperands(i: 3));
    });

    test('fromNum mirrors Intl.PluralRules default formatting', () {
      expect(PluralOperands.fromNum(1), const PluralOperands(i: 1));
      expect(PluralOperands.fromNum(1.0), const PluralOperands(i: 1));
      expect(
        PluralOperands.fromNum(1, minimumFractionDigits: 1),
        const PluralOperands(i: 1, v: 1),
      );
      expect(
        PluralOperands.fromNum(1.5),
        const PluralOperands(i: 1, v: 1, w: 1, f: 5, t: 5),
      );
      // Rounded half away from zero to three fraction digits.
      expect(
        PluralOperands.fromNum(1.0005),
        const PluralOperands(i: 1, v: 3, w: 3, f: 1, t: 1),
      );
      expect(PluralOperands.fromNum(0.9999), const PluralOperands(i: 1));
      expect(PluralOperands.fromNum(-21), const PluralOperands(i: 21));
      final huge = PluralOperands.fromNum(1e21).i;
      expect(huge % 1000000, 0);
      expect(huge, greaterThanOrEqualTo(100000000000000000));
      expect(resolvePluralLocale('iw'), 'he');
    });

    test('intl rounds the integer digits', () {
      expect(
        PluralOperands.intl(1.5),
        const PluralOperands(i: 2, v: 1, f: 5, t: 5, n: 1.5),
      );
      expect(PluralOperands.intl(1.0), const PluralOperands(i: 1, n: 1));
      expect(PluralOperands.intl(-1).i, -1);
    });

    test('intl keeps the count: digits beyond the third are not lost', () {
      // f only sees three fraction digits, but `n` relations test the count.
      final tiny = PluralOperands.intl(1.0004);
      expect(tiny.f, 0);
      expect(tiny.isIntegral, isFalse);
      expect(PluralOperands.intl(21.0).isIntegral, isTrue);
      expect(PluralOperands.intl(9007199254740993).isIntegral, isTrue);
      expect(PluralOperands.parse('1.000').isIntegral, isTrue);
      expect(PluralOperands.parse('1.001').isIntegral, isFalse);
    });
  });

  group('CLDR samples', () {
    final file = io.File('test/fixtures/cldr_plural_samples.json');
    final json = jsonDecode(file.readAsStringSync()) as Map<String, Object?>;

    test('fixture matches the embedded CLDR version', () {
      expect(json['cldrVersion'], cldrVersion);
    });

    for (final type in PluralType.values) {
      test('${type.name}: every sample selects its own category', () {
        final table = json[type.name]! as Map<String, Object?>;
        var checked = 0;
        final failures = <String>[];
        for (final MapEntry(key: locale, value: categories) in table.entries) {
          final rules = pluralRulesFor(locale, type: type);
          expect(rules.locale, locale);
          for (final MapEntry(key: category, value: samples)
              in (categories! as Map<String, Object?>).entries) {
            for (final sample in expandSamples(samples! as String)) {
              checked++;
              final actual = rules.select(PluralOperands.parse(sample));
              if (actual.name != category) {
                failures.add('$locale $sample: expected $category, '
                    'got ${actual.name}');
              }
            }
          }
        }
        expect(failures, isEmpty);
        expect(checked, greaterThan(1000));
      });
    }
  });

  group('requiredCategories', () {
    test('known locales', () {
      String names(List<PluralCategory> c) => c.map((e) => e.name).join(' ');
      expect(names(requiredCategories('en')), 'one other');
      expect(names(requiredCategories('ru')), 'one few many other');
      expect(names(requiredCategories('ar_EG')), 'zero one two few many other');
      expect(names(requiredCategories('ja')), 'other');
      expect(names(requiredCategories('pt-BR')), 'one many other');
      expect(names(requiredCategories('pt_PT')), 'one many other');
      expect(
          names(requiredCategories('en', ordinal: true)), 'one two few other');
      expect(names(requiredCategories('xx')), 'other');
      expect(hasPluralRules('xx'), isFalse);
      expect(resolvePluralLocale('pt_PT'), 'pt_PT');
      expect(resolvePluralLocale('pt_BR'), 'pt');
      expect(resolvePluralLocale('zh-Hant-TW'), 'zh');
    });

    test('every sheet locale has CLDR rules', () {
      for (final locale in _sheetLocales) {
        expect(hasPluralRules(locale), isTrue, reason: locale);
      }
    });
  });

  group('choosePluralBranch (Intl.pluralLogic semantics)', () {
    const one = PluralCategory.one;
    const other = PluralCategory.other;
    const zero = PluralCategory.zero;
    const two = PluralCategory.two;
    const few = PluralCategory.few;
    test('exact 0/1/2 match wins over the CLDR category', () {
      expect(choosePluralBranch(0, {zero, one, other}, other), zero);
      expect(choosePluralBranch(1, {one, other}, few), one);
      expect(choosePluralBranch(2, {two, few, other}, few), two);
    });
    test('category with fallback to other', () {
      expect(choosePluralBranch(21, {one, other}, one), one);
      expect(choosePluralBranch(5, {one, other}, PluralCategory.many), other);
    });
    test('two falls back to few before other', () {
      expect(choosePluralBranch(22, {few, other}, two), few);
      expect(choosePluralBranch(22, {other}, two), other);
    });
  });

  group('cross-check', () {
    test(
      'evaluator agrees with node Intl.PluralRules',
      () async {
        final cases = <({String value, int minFd})>[
          for (var k = 0; k <= 1000; k++) (value: '$k', minFd: 0),
          for (final k in [10000, 100000, 1000000, 2000000, 10000000])
            (value: '$k', minFd: 0),
          for (var k = 0; k <= 100; k++)
            (value: (k / 10).toStringAsFixed(1), minFd: 1),
          for (var k = 0; k <= 300; k++)
            (value: (k / 100).toStringAsFixed(2), minFd: 2),
          for (final v in ['0.5', '1.5', '2.5', '0.25', '1.125', '21.3'])
            (value: v, minFd: 0),
        ];
        final locales = [
          ...{...pluralLocales(), ...pluralLocales(ordinal: true)},
        ];
        const script = '''
const input = JSON.parse(require('fs').readFileSync(0, 'utf8'));
const out = {};
for (const type of ['cardinal', 'ordinal']) {
  out[type] = {};
  for (const locale of input.locales) {
    const tag = locale.replace(/_/g, '-');
    if (Intl.PluralRules.supportedLocalesOf([tag]).length === 0) continue;
    const resolved = new Intl.PluralRules(tag, {type}).resolvedOptions().locale;
    const rules = {};
    const result = [];
    for (const c of input.cases) {
      let r = rules[c.minFd];
      if (!r) r = rules[c.minFd] = new Intl.PluralRules(tag,
          {type, minimumFractionDigits: c.minFd, maximumFractionDigits: 3});
      result.push(r.select(Number(c.value)));
    }
    out[type][locale] = {resolved, result};
  }
}
process.stdout.write(JSON.stringify(out));
''';
        final process = await io.Process.start('node', ['-e', script]);
        process.stdin.write(jsonEncode({
          'locales': locales,
          'cases': [
            for (final c in cases) {'value': c.value, 'minFd': c.minFd},
          ],
        }));
        await process.stdin.close();
        final stdout = await process.stdout.transform(utf8.decoder).join();
        final stderr = await process.stderr.transform(utf8.decoder).join();
        expect(await process.exitCode, 0, reason: stderr);
        final out = jsonDecode(stdout) as Map<String, Object?>;

        final mismatches = <String>[];
        var compared = 0;
        for (final type in PluralType.values) {
          final table = out[type.name]! as Map<String, Object?>;
          for (final locale in locales) {
            if (!hasPluralRules(locale, type: type)) continue;
            final entry = table[locale] as Map<String, Object?>?;
            if (entry == null) continue; // not supported by node's ICU
            final results = (entry['result']! as List).cast<String>();
            final rules = pluralRulesFor(locale, type: type);
            for (var k = 0; k < cases.length; k++) {
              final c = cases[k];
              final ours = rules
                  .select(PluralOperands.fromNum(
                    num.parse(c.value),
                    minimumFractionDigits: c.minFd,
                  ))
                  .name;
              compared++;
              if (ours != results[k]) {
                mismatches.add('${type.name} $locale ${c.value}: '
                    'ours=$ours node=${results[k]}');
              }
            }
          }
        }
        if (mismatches.isNotEmpty) {
          print('node disagrees on ${mismatches.length} of $compared '
              'cases:\n  ${mismatches.take(40).join('\n  ')}');
        }
        expect(mismatches, isEmpty);
        expect(compared, greaterThan(100000));
      },
      skip: _which('node') ? false : 'node is not on PATH',
      timeout: const Timeout(Duration(minutes: 2)),
    );

    test('intl (Dart) rule table vs CLDR on the sheet locales', () {
      final report = intlDiscrepancies();
      final sheet = {
        for (final MapEntry(:key, :value) in report.entries)
          if (_sheetLocales.contains(key)) key: value,
      };
      if (report.isNotEmpty) {
        print('intl vs CLDR $cldrVersion discrepancies (integers 0..1000 '
            'and decimals with intl operands):');
        for (final MapEntry(:key, :value) in report.entries) {
          print('  $key: ${value.take(6).join('; ')}'
              '${value.length > 6 ? ' (+${value.length - 6})' : ''}');
        }
      }
      // Every discrepancy on a locale the real sheets use must be known and
      // documented (see NOTES / README): update this list deliberately.
      expect(sheet.keys.toSet(), _knownIntlDiscrepancies);
    });

    test('intl operands differ from ECMA-402 for fractional values', () {
      // intl computes `i` as n.round(): 1.5 is "other" in French with intl,
      // but "one" (i = 1) in CLDR / Intl.PluralRules / the Python target.
      final report = <String, List<String>>{};
      for (final locale in _sheetLocales) {
        final rules = pluralRulesFor(locale);
        for (var k = 1; k < 1000; k++) {
          if (k % 10 == 0) continue;
          final value = k / 10;
          final theirs = intl.Intl.pluralLogic<String>(
            value,
            zero: 'zero',
            one: 'one',
            two: 'two',
            few: 'few',
            many: 'many',
            other: 'other',
            locale: locale,
            useExplicitNumberCases: false,
          );
          final ours = rules.selectNum(value).name;
          if (ours != theirs) {
            (report[locale] ??= []).add('$value: ecma=$ours intl=$theirs');
          }
        }
      }
      for (final MapEntry(:key, :value) in report.entries) {
        print('  operands $key: ${value.length} values, e.g. '
            '${value.take(3).join('; ')}');
      }
      expect(report['fr'], contains('1.5: ecma=one intl=other'));
    });

    test('evaluator over intl operands == intl for fractional counts', () {
      // `n` relations must test the count itself: `f` only sees three
      // fraction digits, so 1.001 is not `n = 1` (es), 1e-7 is not `n = 0`
      // (ar) and 2.0001 is not `n = 2` (mt).
      const values = <num>[
        0.5, 1.5, 2.5, 10.5, 0.1, 21.0, 1.001, 1.0004, 1.0001, 1e-7, 0.001, //
        0.0004, 2.0001, 2.0004, 3.0001, 11.0001, 21.0001, 100.0001,
        1000000.0001, 0.999, 1.999, -1.0004, -2.0001, -0.5,
      ];
      final integerReport = intlDiscrepancies();
      final locales = intl_rules.pluralRules.keys
          .where((l) => l != 'default' && l != 'en_ISO')
          .where((l) => hasPluralRules(l) && !integerReport.containsKey(l))
          .toList()
        ..sort();
      expect(locales, containsAll(['ar', 'be', 'es', 'lt', 'lv', 'mt', 'ro']));
      final mismatches = <String>[];
      for (final locale in locales) {
        final rules = pluralRulesFor(locale);
        for (final value in values) {
          final theirs = intl.Intl.pluralLogic<String>(
            value,
            zero: 'zero',
            one: 'one',
            two: 'two',
            few: 'few',
            many: 'many',
            other: 'other',
            locale: locale,
            useExplicitNumberCases: false,
          );
          final ours = rules.select(PluralOperands.intl(value)).name;
          if (ours != theirs) mismatches.add('$locale $value: $ours/$theirs');
        }
      }
      expect(mismatches, isEmpty, reason: mismatches.take(20).join('\n'));
      String select(String locale, num value) =>
          pluralRulesFor(locale).select(PluralOperands.intl(value)).name;
      expect(select('es', 1.001), 'other');
      expect(select('ar', 1e-7), 'other');
      expect(select('mt', 2.0001), 'other');
    });
  });
}

/// Locales of the sheets where intl's plural table disagrees with CLDR.
const _knownIntlDiscrepancies = <String>{};

/// Compares intl's plural rules with the CLDR evaluator, feeding both the
/// operands intl computes, for every locale intl has rules for.
Map<String, List<String>> intlDiscrepancies() {
  final result = <String, List<String>>{};
  final values = <num>[
    for (var k = 0; k <= 1000; k++) k,
    for (var k = 1; k < 100; k++) k / 10,
    1000000,
    2000000,
  ];
  final locales = intl_rules.pluralRules.keys
      .where((l) => l != 'default' && l != 'en_ISO')
      .toList()
    ..sort();
  for (final locale in locales) {
    if (!hasPluralRules(locale)) {
      result[locale] = ['no CLDR rules'];
      continue;
    }
    final rules = pluralRulesFor(locale);
    for (final value in values) {
      final theirs = intl.Intl.pluralLogic<String>(
        value,
        zero: 'zero',
        one: 'one',
        two: 'two',
        few: 'few',
        many: 'many',
        other: 'other',
        locale: locale,
        useExplicitNumberCases: false,
      );
      final ours = rules.select(PluralOperands.intl(value)).name;
      if (ours != theirs) {
        (result[locale] ??= []).add('$value: cldr=$ours intl=$theirs');
      }
    }
  }
  return result;
}

/// Expands the `@integer` / `@decimal` samples of a CLDR rule.
List<String> expandSamples(String samples) {
  final out = <String>[];
  for (final part in samples.split('@')) {
    final trimmed = part.trim();
    if (trimmed.isEmpty) continue;
    final space = trimmed.indexOf(' ');
    if (space < 0) continue;
    for (final raw in trimmed.substring(space + 1).split(',')) {
      final item = raw.trim();
      if (item.isEmpty || item == '…') continue;
      final tilde = item.indexOf('~');
      if (tilde < 0) {
        out.add(item);
        continue;
      }
      final low = item.substring(0, tilde);
      final high = item.substring(tilde + 1);
      if (low.contains('c') || high.contains('c')) {
        out
          ..add(low)
          ..add(high);
        continue;
      }
      final dot = low.indexOf('.');
      final digits = dot < 0 ? 0 : low.length - dot - 1;
      final scale = BigInt.from(10).pow(digits);
      BigInt scaled(String s) => BigInt.parse(s.replaceFirst('.', ''));
      final from = scaled(low);
      final to = scaled(high);
      var count = 0;
      for (var x = from; x <= to && count < 2000; x += BigInt.one, count++) {
        if (digits == 0) {
          out.add('$x');
        } else {
          final whole = x ~/ scale;
          final fraction = (x % scale).toString().padLeft(digits, '0');
          out.add('$whole.$fraction');
        }
      }
    }
  }
  return out;
}

bool _which(String tool) => hasTool(tool);
