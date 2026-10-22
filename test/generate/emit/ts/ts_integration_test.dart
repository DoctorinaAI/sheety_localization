// Integration tests of the TypeScript target: the generated tree must
// type-check with tsc 5.9 under the strictest options with both
// `moduleResolution: NodeNext` and `Bundler`, and, compiled and run with
// node, render every message of every locale exactly like the Dart code
// gen-l10n generates (package:intl semantics).
//
// Needs `node` and `npx` (tsc is fetched by `npx -y -p typescript@5.9`);
// skipped otherwise. With SHEETY_REAL_SNAPSHOT set, the real spreadsheet is
// verified as well.
@Tags(['integration'])
library;

import 'dart:convert';
import 'dart:io' as io;

import 'package:intl/intl.dart' as intl;
// ignore: implementation_imports
import 'package:intl/src/plural_rules.dart' as intl_rules;
import 'package:sheety_localization/sheety_localization.dart';
import 'package:test/test.dart';

import 'ts_helpers.dart';

final Object _skip =
    hasTool('node') && hasTool('npx') ? false : 'node / npx are not on PATH';

const _timeout = Timeout(Duration(minutes: 10));

void main() {
  group('fixture', () {
    late io.Directory dir;
    late Catalog catalog;

    setUpAll(() async {
      catalog = tsFixtureCatalog();
      dir = io.Directory.systemTemp.createTempSync('sheety_ts_');
      _writeProject(dir, emitTs(catalog), consumer: _fixtureConsumer);
    });

    tearDownAll(() {
      if (io.Platform.environment['SHEETY_KEEP_TMP'] != '1') {
        dir.deleteSync(recursive: true);
      }
    });

    test('type-checks with moduleResolution NodeNext', () async {
      await _tsc(dir, 'tsconfig.nodenext.json');
    });

    test('type-checks with moduleResolution Bundler', () async {
      await _tsc(dir, 'tsconfig.bundler.json');
    });

    test('renders every message like the Dart target', () async {
      await _tsc(dir, 'tsconfig.emit.json');
      final run = await _render(dir, catalog);
      _expectParity(catalog, run);
    });

    test('negotiates locales', () async {
      final requests = <Object?>[
        'pt-BR',
        'pt_br',
        'PT-br',
        'pt-PT',
        'pt',
        'de-AT',
        'de_at',
        'de-CH',
        'zh-Hant-TW',
        'xx',
        '',
        '*',
        null,
        ['xx', 'fr-CA', 'en'],
        ['ja-JP-u-ca-japanese'],
        'en-US.UTF-8',
        'ru_RU@euro',
        <String>[],
        ['x-private', 'pl'],
      ];
      final out = await _node(dir, '''
import * as gen from './dist/gen/index.js';
const requests = ${jsonEncode(requests)};
console.log(JSON.stringify({
  app: requests.map((r) => gen.app.resolveLocale(r)),
  errors: requests.map((r) => gen.errors.resolveLocale(r)),
  root: requests.map((r) => gen.resolveLocale(r)),
  loaded: (await gen.app.loadMessages('pt-PT')).title,
}));
''');
      final json = jsonDecode(out) as Map<String, Object?>;
      expect(json['app'], [
        'pt-BR', 'pt-BR', 'pt-BR', 'pt', 'pt', 'de-AT', 'de-AT', 'de', //
        'en', 'en', 'en', 'en', 'en', 'fr', 'ja', 'en', 'ru', 'en', 'pl',
      ]);
      // errors: base ru, has en and es-419 (+ synthetic es).
      expect(json['errors'], [
        'ru', 'ru', 'ru', 'ru', 'ru', 'ru', 'ru', 'ru', 'ru', 'ru', 'ru', //
        'ru', 'ru', 'en', 'ru', 'en', 'ru', 'ru', 'ru',
      ]);
      // Scopes disagree on the base: the root falls back to the first one.
      expect((json['root']! as List<Object?>).first, 'pt-BR');
      expect((json['root']! as List<Object?>)[9], 'en');
      expect(json['loaded'], 'Exemplo');
    });

    test('formats doubles like Dart', () async {
      final values = [
        1.0,
        -0.0,
        0.0,
        1.5,
        0.1 + 0.2,
        1e21,
        1e20,
        123456789012345680000.0,
        1.5e-7,
        1e-6,
        0.000001234,
        -2.0,
        5e-324,
        1.7976931348623157e308,
        double.nan,
        double.infinity,
        double.negativeInfinity,
        100.0,
        0.5,
      ];
      final out = await _node(dir, '''
import { formatDouble } from './dist/gen/runtime.js';
const values = [${values.map(_jsNumber).join(', ')}];
console.log(JSON.stringify(values.map(formatDouble)));
''');
      expect(jsonDecode(out), [for (final v in values) '$v']);
    });

    test('dictionaries are frozen and match the metadata', () async {
      final out = await _node(dir, '''
import { app } from './dist/gen/index.js';
import { messages } from './dist/gen/app/eager.js';
const en = await app.loaders.en();
console.log(JSON.stringify({
  frozen: Object.isFrozen(en),
  same: en === messages.en,
  keys: Object.keys(en),
  plain: typeof en.title,
  fn: typeof en.items,
}));
''');
      final json = jsonDecode(out) as Map<String, Object?>;
      expect(json['frozen'], isTrue);
      expect(json['same'], isTrue);
      expect(json['keys'], catalog.scope('app')!.messages.map((m) => m.key));
      expect(json['plain'], 'string');
      expect(json['fn'], 'function');
    });

    test(
      'works with @solid-primitives/i18n',
      () async {
        final install = await io.Process.run(
          'npm',
          [
            'install',
            '--no-audit',
            '--no-fund',
            '--no-save',
            '@solid-primitives/i18n@2',
            'solid-js@1',
          ],
          workingDirectory: dir.path,
        );
        if (install.exitCode != 0) {
          markTestSkipped('npm install failed: ${install.stderr}');
          return;
        }
        io.File('${dir.path}/solid/app.ts')
          ..createSync(recursive: true)
          ..writeAsStringSync(_solidConsumer);
        // solid-js' types need the DOM library; the generated code itself
        // is checked without it by the other tests.
        for (final (name, module, resolution) in [
          ('tsconfig.solid-nodenext.json', 'NodeNext', 'NodeNext'),
          ('tsconfig.solid-bundler.json', 'ESNext', 'Bundler'),
        ]) {
          io.File('${dir.path}/$name').writeAsStringSync(prettyJson({
            'compilerOptions': {
              ...strictCompilerOptions(
                module: module,
                moduleResolution: resolution,
              ),
              'lib': ['ES2022', 'DOM'],
              'skipLibCheck': true,
              'outDir': 'dist-solid',
              'rootDir': '.',
            },
            'include': ['src/gen/**/*.ts', 'solid/**/*.ts'],
          }));
        }
        await _tsc(dir, 'tsconfig.solid-bundler.json');
        await _tsc(dir, 'tsconfig.solid-nodenext.json');
        final out = await _node(dir, "import './dist-solid/solid/app.js';\n");
        expect(
          out.trim().split('\n'),
          ['Beispiel (AT)', '3 Artikel', 'Hallo, Ann!', 'Ein Artikel'],
        );
      },
      skip: hasTool('npm') ? false : 'npm is not on PATH',
    );
  }, skip: _skip, timeout: _timeout);

  group('plural rules', () {
    test(
      'compiled CLDR rules + intl operands == Intl.pluralLogic',
      () async {
        final dir = io.Directory.systemTemp.createTempSync('sheety_ts_pl_');
        addTearDown(() => dir.deleteSync(recursive: true));
        final all = pluralLocales();
        // Locales whose rules package:intl knows under the same name.
        final shared = [
          for (final l in all)
            if (intl.Intl.verifiedLocale(
                  l,
                  intl_rules.localeHasPluralRules,
                  onFailure: (_) => null,
                ) ==
                intl.Intl.canonicalizedLocale(l))
              l,
        ];
        expect(shared.length, greaterThan(80));
        io.File('${dir.path}/runtime.ts')
          ..createSync(recursive: true)
          ..writeAsStringSync(
            tsRuntimeSource(pluralLocales: shared, header: ''),
          );
        io.File('${dir.path}/package.json')
            .writeAsStringSync('{"type": "module", "private": true}\n');
        io.File('${dir.path}/tsconfig.json').writeAsStringSync(prettyJson({
          'compilerOptions': {
            ...strictCompilerOptions(
              module: 'NodeNext',
              moduleResolution: 'NodeNext',
            ),
            'outDir': 'dist',
          },
          'files': ['runtime.ts'],
        }));
        await _tsc(dir, 'tsconfig.json');
        final numbers = <num>[
          for (var k = 0; k <= 220; k++) k,
          for (var k = 1; k <= 25; k++) -k,
          1000,
          1001,
          10000,
          100000,
          1000000,
          2000000,
          1000001,
          10000000,
          for (var k = 0; k <= 120; k++) k / 10,
          for (var k = 0; k <= 40; k++) k / 4,
          0.01,
          0.001,
          0.0001,
          1.0001,
          1.05,
          1.005,
          2.999,
          11.5,
          21.25,
          101.5,
          1e-7,
          -0.5,
          -1.5,
          -2.5,
          -21.5,
          1000000.5,
          3.14159,
        ];
        const sets = [
          ['zero', 'one', 'two', 'few', 'many', 'other'],
          ['one', 'other'],
          ['few', 'other'],
          ['many', 'other'],
          ['two', 'few', 'other'],
          ['zero', 'other'],
        ];
        final out = await _node(dir, '''
import * as rt from './dist/runtime.js';
const locales = ${jsonEncode(shared)};
const numbers = [${numbers.map(_jsNumber).join(', ')}];
const sets = ${jsonEncode(sets)};
const out = [];
for (const l of locales) {
  const rule = rt['plural_' + l];
  for (const n of numbers) {
    for (const s of sets) {
      const cases = Object.fromEntries(s.map((c) => [c, c]));
      out.push(rt.plural(n, rule, cases));
    }
  }
}
console.log(JSON.stringify(out));
''');
        final ts = (jsonDecode(out) as List<Object?>).cast<String>();
        final mismatches = <String>[];
        var k = 0;
        for (final l in shared) {
          for (final n in numbers) {
            for (final s in sets) {
              String? c(String name) => s.contains(name) ? name : null;
              final dart = intl.Intl.pluralLogic<String>(
                n,
                locale: intl.Intl.canonicalizedLocale(l),
                zero: c('zero'),
                one: c('one'),
                two: c('two'),
                few: c('few'),
                many: c('many'),
                other: 'other',
              );
              if (dart != ts[k]) {
                mismatches.add('$l($n, $s): dart=$dart ts=${ts[k]}');
              }
              k++;
            }
          }
        }
        expect(k, ts.length);
        expect(mismatches, isEmpty, reason: mismatches.take(40).join('\n'));
        printOnFailure('compared $k selections in ${shared.length} locales; '
            '${all.length - shared.length} CLDR locales are unknown to intl');
      },
      skip: _skip,
      timeout: _timeout,
    );
  });

  group('real snapshot', () {
    final path = io.Platform.environment['SHEETY_REAL_SNAPSHOT'];
    test(
      'type-checks and renders like the Dart target',
      () async {
        final result = readSnapshot(path!, options: const ReaderOptions());
        final errorScopes = {
          for (final d in result.diagnostics)
            // duplicate-label rows are merged deterministically; the scope
            // is still consistent, so it is emitted.
            if (d.isError && d.code.id != 'duplicate-label' && d.scope != null)
              d.scope!,
        };
        final catalog = result.catalog.where(
          (s) => !errorScopes.contains(s.name),
        );
        final validation = [
          ...validateCatalog(catalog),
          ...const TypeScriptEmitter().validate(catalog),
        ];
        expect(
          validation.where((d) => d.isError && d.code.id != 'duplicate-label'),
          isEmpty,
          reason: formatDiagnostics(validation, minimum: Severity.error),
        );
        print('real snapshot: ${catalog.scopes.length} scopes emitted '
            '(${catalog.scopes.map((s) => s.name).join(', ')}); excluded '
            'because of errors: ${errorScopes.toList()..sort()}');
        final dir = io.Directory.systemTemp.createTempSync('sheety_ts_real_');
        addTearDown(() {
          if (io.Platform.environment['SHEETY_KEEP_TMP'] != '1') {
            dir.deleteSync(recursive: true);
          }
        });
        _writeProject(dir, emitTs(catalog));
        await _tsc(dir, 'tsconfig.nodenext.json');
        await _tsc(dir, 'tsconfig.bundler.json');
        await _tsc(dir, 'tsconfig.emit.json');
        final run = await _render(dir, catalog);
        final count = _expectParity(catalog, run);
        print('real snapshot: $count renders identical to the Dart target');
      },
      skip: _skip != false
          ? _skip
          : path == null
              ? 'SHEETY_REAL_SNAPSHOT is not set'
              : false,
      timeout: _timeout,
    );
  });
}

String _jsNumber(num n) => switch (n) {
      double(isNaN: true) => 'NaN',
      double(isInfinite: true) => n > 0 ? 'Infinity' : '-Infinity',
      double(isNegative: true) when n == 0 => '-0',
      _ => '$n',
    };

/// Writes the generated [files] under `src/gen/` of a node project in
/// [dir], with tsconfigs for both module resolutions and one for emitting.
void _writeProject(
  io.Directory dir,
  List<GeneratedFile> files, {
  String? consumer,
}) {
  writeFiles(io.Directory('${dir.path}/src/gen'), files);
  if (consumer != null) {
    io.File('${dir.path}/src/consumer.ts').writeAsStringSync(consumer);
  }
  io.File('${dir.path}/package.json')
      .writeAsStringSync('{"type": "module", "private": true}\n');
  void config(String name, Map<String, Object?> options) =>
      io.File('${dir.path}/$name').writeAsStringSync(prettyJson({
        'compilerOptions': options,
        'include': ['src/**/*.ts'],
      }));
  config('tsconfig.nodenext.json', {
    ...strictCompilerOptions(module: 'NodeNext', moduleResolution: 'NodeNext'),
    'noEmit': true,
  });
  config('tsconfig.bundler.json', {
    ...strictCompilerOptions(module: 'ESNext', moduleResolution: 'Bundler'),
    'noEmit': true,
  });
  config('tsconfig.emit.json', {
    ...strictCompilerOptions(module: 'NodeNext', moduleResolution: 'NodeNext'),
    'outDir': 'dist',
    'rootDir': 'src',
    'declaration': true,
  });
}

Future<void> _tsc(io.Directory dir, String config) async {
  final result = await runTsc(dir, ['-p', config]);
  expect(
    result.exitCode,
    0,
    reason: 'tsc -p $config\n${result.stdout}\n${result.stderr}',
  );
}

Future<String> _node(io.Directory dir, String script) async {
  final file = io.File('${dir.path}/script_${script.hashCode}.mjs')
    ..writeAsStringSync(script);
  final result = await io.Process.run(
    'node',
    [file.path],
    workingDirectory: dir.path,
    stdoutEncoding: utf8,
  );
  expect(result.exitCode, 0, reason: '${result.stderr}');
  return result.stdout as String;
}

typedef _Job = ({
  Scope scope,
  LocaleTag locale,
  Message message,
  List<Map<String, Object?>> args
});

typedef _Run = ({
  List<_Job> jobs,
  List<Object?> results,
  Map<String, Object?> entries,
});

/// Renders every message of every locale of [catalog] with
/// [exampleArgs] in node, through the generated `meta.ts`.
Future<_Run> _render(io.Directory dir, Catalog catalog) async {
  final jobs = <_Job>[
    for (final scope in catalog.scopes)
      for (final locale in scope.localeTags)
        for (final message in scope.messages)
          (
            scope: scope,
            locale: locale,
            message: message,
            args: exampleArgs(message),
          ),
  ];
  final input = io.File('${dir.path}/input.json')
    ..writeAsStringSync(jsonEncode([
      for (final job in jobs)
        [job.scope.name, job.locale.bcp47, job.message.key, job.args],
    ]));
  final output = io.File('${dir.path}/output.json');
  await _node(dir, '''
import { readFileSync, writeFileSync } from 'node:fs';
import * as meta from './dist/gen/meta.js';
import * as gen from './dist/gen/index.js';
const jobs = JSON.parse(readFileSync(${jsonEncode(input.path)}, 'utf8'));
const dicts = new Map();
const results = [];
for (const [scope, locale, key, argsList] of jobs) {
  const id = scope + '/' + locale;
  let dict = dicts.get(id);
  if (dict === undefined) {
    dict = await gen[scope].loaders[locale]();
    dicts.set(id, dict);
  }
  results.push(argsList.map((args) => {
    try {
      return gen.formatMessage(dict, key, args);
    } catch (e) {
      return { error: String(e) };
    }
  }));
}
const entries = {};
for (const scope of meta.scopes) entries[scope] = meta[scope].entries;
writeFileSync(${jsonEncode(output.path)}, JSON.stringify({ results, entries }));
''');
  final json = jsonDecode(output.readAsStringSync()) as Map<String, Object?>;
  return (
    jobs: jobs,
    results: json['results']! as List<Object?>,
    entries: json['entries']! as Map<String, Object?>,
  );
}

/// Compares the node results of [run] with [renderDart] and the metadata
/// with the catalog; returns the number of compared renders.
int _expectParity(Catalog catalog, _Run run) {
  expect(run.results.length, run.jobs.length);
  final mismatches = <String>[];
  var compared = 0;
  for (var k = 0; k < run.jobs.length; k++) {
    final job = run.jobs[k];
    final ts = run.results[k]! as List<Object?>;
    final ast = job.message.translationFor(job.locale).ast;
    for (var a = 0; a < job.args.length; a++) {
      String dart;
      try {
        dart = renderDart(ast, job.locale, toDart(job.message, job.args[a]));
      } on Object catch (e) {
        dart = 'Dart error: $e';
      }
      compared++;
      if (ts[a] != dart) {
        mismatches.add('${job.scope.name}/${job.locale.bcp47}/'
            '${job.message.key} ${jsonEncode(job.args[a])}:\n'
            '  dart: ${jsonEncode(dart)}\n  ts:   ${jsonEncode(ts[a])}');
      }
    }
  }
  expect(
    mismatches,
    isEmpty,
    reason: '${mismatches.length} of $compared differ:\n'
        '${mismatches.take(30).join('\n')}',
  );

  for (final scope in catalog.scopes) {
    final entries = (run.entries[scope.name]! as List<Object?>)
        .cast<Map<String, Object?>>();
    expect(entries.map((e) => e['key']), scope.messages.map((m) => m.key));
    for (final (index, message) in scope.messages.indexed) {
      final entry = entries[index];
      expect(entry['description'], message.description);
      expect(entry['placeholders'], [
        for (final p in message.placeholders)
          {
            'name': p.name,
            'type': p.type.arbName,
            'example': p.example,
            'description': p.description,
            'declared': p.declared,
          },
      ]);
      expect(entry['templates'], {
        for (final locale in scope.localeTags)
          locale.bcp47: {
            'raw': message.translationFor(locale).raw,
            'isFallback': message.translationFor(locale).isFallback,
            'source': message.translationFor(locale).source.bcp47,
          },
      });
    }
  }
  return compared;
}

/// Uses the generated API the way an application does; `@ts-expect-error`
/// lines prove that wrong calls do not compile.
const String _fixtureConsumer = r'''
import { app, errors, resolveLocale, scopes, sign_up, supportedLocales } from './gen/index.js';
import type { SupportedLocale } from './gen/index.js';
import type { AppKey, AppMessages } from './gen/app/types.js';
import en from './gen/app/en.js';
import { messages as all } from './gen/app/eager.js';
import { entries, format } from './gen/app/meta.js';

const locale: app.Locale = app.resolveLocale(['pt-PT', 'en']);
const dict: AppMessages = await app.loaders[locale]();
const title: string = dict.title;
const items: string = dict.items({ count: 3 });
const pronoun: string = dict.pronoun({ gender: 'female', count: 2 });
const seen: string = dict.lastSeen({ when: 5 }) + dict.lastSeen({ when: 'now' });
const keys: readonly AppKey[] = entries.map((e) => e.key);
const fallback: boolean = entries[0]?.templates['pt-BR'].isFallback ?? false;
const rendered: Promise<string> = format('de', 'items', { count: 1 });
const root: SupportedLocale = resolveLocale('es-419');
const sync: string = all['de-AT'].title + en.title;
const scopeNames: readonly string[] = scopes;
const signUp: string = (await sign_up.loadMessages('de')).signUp;
const notFound: string = (await errors.loaders.ru()).notFound;

// @ts-expect-error the count is required
dict.items({});
// @ts-expect-error the name is a string
dict.greeting({ name: 1 });
// @ts-expect-error a plain message is not a function
dict.title({});
// @ts-expect-error unknown locale
app.loaders['xx'];
// @ts-expect-error dictionaries are read-only
dict.title = 'x';

export const used = [title, items, pronoun, seen, keys, fallback, rendered, root, sync, scopeNames, signUp, notFound, supportedLocales];
''';

/// `@solid-primitives/i18n` straight on the generated dictionaries.
const String _solidConsumer = r'''
import * as i18n from '@solid-primitives/i18n';
import { createResource, createSignal } from 'solid-js';
import { app } from '../src/gen/index.js';
import type { AppMessages } from '../src/gen/app/types.js';
import { messages } from '../src/gen/app/eager.js';

// Reactive: the dictionary of the current locale is loaded lazily.
export function useI18n() {
  const [locale, setLocale] = createSignal<app.Locale>(app.resolveLocale('de-AT'));
  const [dict] = createResource(locale, (l) => app.loaders[l]());
  const t = i18n.translator(dict);
  return { locale, setLocale, t };
}

// Synchronous: a dictionary that is already there (SSR, tests).
const t = i18n.translator(() => messages['de-AT']);
const title: string = t('title');
const items: string = t('items', { count: 3 });
console.log(title);
console.log(items);

const flat: i18n.Flatten<AppMessages> = i18n.flatten(messages.de);
const greeting: string = i18n.translator(() => flat)('greeting', { name: 'Ann' });
console.log(greeting);

console.log(messages.de.items({ count: 1 }));
''';
