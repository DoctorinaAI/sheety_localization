/// The TypeScript target: ESM modules with no runtime dependencies, typed
/// per scope, one lazily loadable module per locale.
///
/// Layout under the output directory:
///
/// ```text
/// runtime.ts              plural/select logic (package:intl semantics), CLDR
///                         rules of the used locales, locale negotiation,
///                         metadata types
/// index.ts                every scope as a namespace, `scopes`,
///                         `supportedLocales`, `resolveLocale`
/// meta.ts                 every scope's metadata module as a namespace
/// <scope>/types.ts        `interface <Scope>Messages`, `type <Scope>Key`
/// <scope>/<locale>.ts     the dictionary of one locale (`en.ts`, `pt-BR.ts`)
/// <scope>/index.ts        `locales`, `Locale`, `baseLocale`, lazy `loaders`,
///                         `resolveLocale`, `loadMessages`
/// <scope>/eager.ts        every dictionary, statically imported (SSR / SSG)
/// <scope>/meta.ts         `entries` (keys, placeholders, raw ICU per
///                         locale, fallbacks) and an untyped `format`
/// ```
library;

import '../../diagnostics.dart';
import '../../emitter.dart';
import '../../icu/ast.dart';
import '../../model.dart';
import '../../naming.dart';
import '../../validate.dart';
import 'ts_code.dart';
import 'ts_runtime.dart';

export 'ts_code.dart' show tsString, tsTemplateText;
export 'ts_runtime.dart' show tsPluralLocale, tsPluralRuleName, tsRuntimeSource;

/// Generates the TypeScript target.
final class TypeScriptEmitter implements Emitter {
  /// Creates the emitter.
  const TypeScriptEmitter();

  /// Names exported by the generated root `index.ts` / `meta.ts` besides the
  /// scope namespaces: a scope must not be called like one of them.
  static const Set<String> rootExports = {
    'scopes',
    'ScopeName',
    'supportedLocales',
    'SupportedLocale',
    'baseLocale',
    'isSupportedLocale',
    'resolveLocale',
    'negotiateLocale',
    'formatMessage',
    'MessageEntry',
    'MessageValue',
    'PlaceholderInfo',
    'PlaceholderType',
    'PluralCategory',
    'TemplateInfo',
  };

  @override
  Target get target => Target.ts;

  /// TypeScript identifier diagnostics for [catalog] (already filtered to
  /// the scopes of this target): the core checks of [validateIdentifiers]
  /// plus scopes that would shadow an export of the root `index.ts`.
  List<Diagnostic> validate(Catalog catalog, {DiagnosticSink? sink}) {
    final out = sink ?? DiagnosticSink();
    final before = out.diagnostics.length;
    validateIdentifiers(catalog, Target.ts, sink: out);
    for (final scope in catalog.scopes) {
      if (!rootExports.contains(scope.name)) continue;
      out.report(
        DiagnosticCode.reservedWord,
        'Scope "${scope.name}" is also the name of an export of the '
        'generated index.ts',
        scope: scope.name,
        sheetTitle: scope.sheetTitle,
        target: Target.ts.id,
      );
    }
    return out.diagnostics.sublist(before);
  }

  @override
  List<GeneratedFile> emit(Catalog catalog, EmitOptions options) {
    final header = '${options.headerComment('//')}/* eslint-disable */\n';
    final pluralLocales = <String>{};
    final files = <GeneratedFile>[];
    for (final scope in catalog.scopes) {
      files.addAll(_ScopeEmitter(scope, header, pluralLocales).emit());
    }
    files
      ..add(GeneratedFile(
        'runtime.ts',
        tsRuntimeSource(
          pluralLocales: pluralLocales,
          header: options.headerComment('//'),
        ),
      ))
      ..add(GeneratedFile('index.ts', _rootIndex(catalog, header)))
      ..add(GeneratedFile('meta.ts', _rootMeta(catalog, header)))
      ..sort((a, b) => a.relativePath.compareTo(b.relativePath));
    return files;
  }
}

/// `<scope>Messages` type name.
String tsMessagesType(Scope scope) => '${toPascalCase(scope.name)}Messages';

/// `<scope>Key` type name.
String tsKeyType(Scope scope) => '${toPascalCase(scope.name)}Key';

String _tsType(PlaceholderType type) => switch (type) {
      PlaceholderType.string => 'string',
      PlaceholderType.int ||
      PlaceholderType.num ||
      PlaceholderType.double =>
        'number',
      PlaceholderType.object => 'string | number',
    };

String _argsType(Message message) => '{ ${[
      for (final p in message.placeholders)
        'readonly ${tsPropertyKey(p.name)}: ${_tsType(p.type)}',
    ].join('; ')} }';

String _argAccess(String name) =>
    isTsIdentifierName(name) ? 'args.$name' : 'args[${tsString(name)}]';

String _list(Iterable<String> items) => '[${items.join(', ')}]';

String _rootIndex(Catalog catalog, String header) {
  final out = StringBuffer(header);
  final locales = [for (final l in catalog.locales) l.bcp47];
  if (locales.isNotEmpty) {
    out.write("import { negotiateLocale } from './runtime.js';\n\n");
  }
  for (final scope in catalog.scopes) {
    out.write("export * as ${scope.name} from './${scope.name}/index.js';\n");
  }
  if (catalog.scopes.isNotEmpty) out.write('\n');
  out
    ..write('export type {\n')
    ..write('  MessageEntry,\n  MessageValue,\n  PlaceholderInfo,\n')
    ..write('  PlaceholderType,\n  PluralCategory,\n  TemplateInfo,\n')
    ..write("} from './runtime.js';\n")
    ..write("export { formatMessage, negotiateLocale } from './runtime.js';\n")
    ..write('\n/** Every scope (sheet), in sheet order. */\n')
    ..write('export const scopes = '
        '${_list(catalog.scopes.map((s) => tsString(s.name)))} as const;\n\n')
    ..write('/** The name of a scope. */\n')
    ..write('export type ScopeName = (typeof scopes)[number];\n\n')
    ..write('/** Every locale of any scope (BCP 47), in order of first '
        'appearance. */\n')
    ..write('export const supportedLocales = '
        '${_list(locales.map(tsString))} as const;\n\n')
    ..write('/** A locale of any scope. */\n')
    ..write('export type SupportedLocale = '
        '(typeof supportedLocales)[number];\n');
  if (locales.isEmpty) return out.toString();
  final base = (catalog.baseLocale ?? catalog.locales.first).bcp47;
  out
    ..write('\n/**\n * The base language of the scopes')
    ..write(catalog.baseLocale == null
        ? ' (they differ, so the base of the first scope).\n */\n'
        : '.\n */\n')
    ..write('export const baseLocale = ${tsString(base)};\n\n')
    ..write('/** Whether `value` is one of the [supportedLocales]. */\n')
    ..write('export function isSupportedLocale(value: string): '
        'value is SupportedLocale {\n')
    ..write('  return (supportedLocales as readonly string[])'
        '.includes(value);\n}\n\n')
    ..write('/**\n * The supported locale that best matches `requested` '
        '(e.g. `navigator.languages`),\n')
    ..write(' * see `negotiateLocale`; [baseLocale] when none does.\n */\n')
    ..write('export function resolveLocale(\n')
    ..write('  requested: string | readonly string[] | null | undefined,\n')
    ..write('): SupportedLocale {\n')
    ..write('  return negotiateLocale(requested, supportedLocales, '
        'baseLocale);\n}\n');
  return out.toString();
}

String _rootMeta(Catalog catalog, String header) {
  final out = StringBuffer(header)
    ..write('// Metadata of every scope, for tests and tooling; '
        'production code does\n// not need to import it.\n\n');
  for (final scope in catalog.scopes) {
    out.write("export * as ${scope.name} from './${scope.name}/meta.js';\n");
  }
  out.write("export { scopes } from './index.js';\n");
  return out.toString();
}

final class _ScopeEmitter {
  _ScopeEmitter(this.scope, this.header, this.pluralLocales);

  final Scope scope;
  final String header;
  final Set<String> pluralLocales;

  String get _type => tsMessagesType(scope);
  String get _key => tsKeyType(scope);
  String get _dir => scope.name;

  List<GeneratedFile> emit() => [
        GeneratedFile('$_dir/types.ts', _types()),
        GeneratedFile('$_dir/index.ts', _index()),
        GeneratedFile('$_dir/eager.ts', _eager()),
        GeneratedFile('$_dir/meta.ts', _meta()),
        for (final locale in scope.locales)
          GeneratedFile('$_dir/${locale.tag.bcp47}.ts', _locale(locale)),
      ];

  String _types() {
    final out = StringBuffer(header)
      ..write(tsDocComment([
        'Messages of the `${scope.name}` scope (sheet '
            '"${scope.sheetTitle}"), base locale `${scope.baseLocale.bcp47}`.',
        '',
        'A message without placeholders is a string, a message with '
            'placeholders is a',
        'function of an object with one property per placeholder.',
        '',
        'A type alias rather than an interface: object types get an implicit '
            'index',
        'signature, so the dictionary is assignable to `Record<string, ...>` '
            '(e.g. to',
        "`@solid-primitives/i18n`'s `BaseRecordDict`).",
      ]))
      ..write('export type $_type = {\n');
    for (final message in scope.messages) {
      final doc = <String>[
        if (message.description case final String d
            when d.trim().isNotEmpty) ...[d.trim(), ''],
        '`${scope.baseLocale.bcp47}`: ${message.base.raw}',
        if (message.hasPlaceholders) '',
        for (final p in message.placeholders)
          '@param args.${p.name} `${p.type.arbName}`'
              '${p.example == null ? '' : ', e.g. `${p.example}`'}'
              '${p.description == null ? '' : ' - ${p.description}'}',
      ];
      out
        ..write(tsDocComment(doc, indent: '  '))
        ..write('  readonly ${tsPropertyKey(message.key)}: ')
        ..write(message.hasPlaceholders
            ? '(args: ${_argsType(message)}) => string'
            : 'string')
        ..write(';\n');
    }
    out
      ..write('};\n\n')
      ..write('/** The key of a message of the `${scope.name}` scope. */\n')
      ..write('export type $_key = keyof $_type;\n');
    return out.toString();
  }

  String _index() {
    final locales = [for (final l in scope.locales) l.tag.bcp47];
    final out = StringBuffer(header)
      ..write("import { negotiateLocale } from '../runtime.js';\n")
      ..write("import type { $_type } from './types.js';\n\n")
      ..write("export type { $_key, $_type } from './types.js';\n\n")
      ..write('/** The scope name (sheet "${tsCommentText(scope.sheetTitle)}'
          '"). */\n')
      ..write('export const scope = ${tsString(scope.name)};\n\n')
      ..write('/** The base language: the fallback of every message. */\n')
      ..write('export const baseLocale = '
          '${tsString(scope.baseLocale.bcp47)};\n\n')
      ..write('/** Every locale of the scope (BCP 47), base first. */\n')
      ..write('export const locales = ${_list(locales.map(tsString))} '
          'as const;\n\n')
      ..write('/** A locale of the scope. */\n')
      ..write('export type Locale = (typeof locales)[number];\n\n')
      ..write('/**\n * Loads the dictionary of a locale; each locale is a '
          'separate module, so\n * bundlers emit one chunk per locale.\n */\n')
      ..write('export const loaders: { readonly [L in Locale]: () => '
          'Promise<$_type> } = {\n');
    for (final locale in locales) {
      out.write('  ${tsString(locale)}: () => '
          "import('./$locale.js').then((m) => m.messages),\n");
    }
    out
      ..write('};\n\n')
      ..write('/** Whether `value` is one of the [locales]. */\n')
      ..write('export function isLocale(value: string): value is Locale {\n')
      ..write('  return (locales as readonly string[]).includes(value);\n')
      ..write('}\n\n')
      ..write('/**\n * The locale that best matches `requested` (e.g. '
          '`navigator.languages`):\n')
      ..write(' * `pt-BR` -> `pt` -> [baseLocale], case-insensitive, `_` '
          'or `-`,\n * an `Accept-Language` header too (see '
          '`negotiateLocale`).\n */\n')
      ..write('export function resolveLocale(\n')
      ..write('  requested: string | readonly string[] | null | '
          'undefined,\n')
      ..write('): Locale {\n')
      ..write('  return negotiateLocale(requested, locales, baseLocale);\n')
      ..write('}\n\n')
      ..write('/** Loads the dictionary of the best match for `requested`. '
          '*/\n')
      ..write('export function loadMessages(\n')
      ..write('  requested: string | readonly string[] | null | '
          'undefined,\n')
      ..write('): Promise<$_type> {\n')
      ..write('  return loaders[resolveLocale(requested)]();\n')
      ..write('}\n');
    return out.toString();
  }

  String _localeVar(LocaleTag tag) => 'locale_${tag.code}';

  String _eager() {
    final out = StringBuffer(header)
      ..write('// Every dictionary of the scope, statically imported: for '
          'server-side\n// rendering and static sites. Client code should '
          'use the lazy `loaders`.\n')
      ..write("import type { Locale } from './index.js';\n")
      ..write("import type { $_type } from './types.js';\n");
    for (final locale in scope.locales) {
      out.write('import { messages as ${_localeVar(locale.tag)} } from '
          "'./${locale.tag.bcp47}.js';\n");
    }
    out
      ..write('\n/** The dictionary of every locale. */\n')
      ..write('export const messages: { readonly [L in Locale]: $_type } = '
          '{\n');
    for (final locale in scope.locales) {
      out.write('  ${tsString(locale.tag.bcp47)}: '
          '${_localeVar(locale.tag)},\n');
    }
    out.write('};\n');
    return out.toString();
  }

  String _meta() {
    final out = StringBuffer(header)
      ..write('// Metadata of the scope, for tests and tooling: raw ICU '
          'templates of every\n// locale, placeholders with examples, '
          'fallbacks. Production code does not\n// need to import it.\n')
      ..write("import { formatMessage } from '../runtime.js';\n")
      ..write("import type { MessageEntry } from '../runtime.js';\n")
      ..write("import { loaders } from './index.js';\n")
      ..write("import type { Locale } from './index.js';\n")
      ..write("import type { $_key } from './types.js';\n\n")
      ..write("export { baseLocale, locales, scope } from './index.js';\n\n")
      ..write('/** Every message, in sheet order. */\n')
      ..write('export const entries: readonly MessageEntry<Locale, $_key>[] '
          '= [\n');
    for (final message in scope.messages) {
      out
        ..write('  {\n')
        ..write('    key: ${tsString(message.key)},\n')
        ..write('    description: ${_nullable(message.description)},\n');
      if (message.placeholders.isEmpty) {
        out.write('    placeholders: [],\n');
      } else {
        out.write('    placeholders: [\n');
        for (final p in message.placeholders) {
          out.write('      { name: ${tsString(p.name)}, type: '
              '${tsString(p.type.arbName)}, example: ${_nullable(p.example)}, '
              'description: ${_nullable(p.description)}, declared: '
              '${p.declared} },\n');
        }
        out.write('    ],\n');
      }
      out.write('    templates: {\n');
      for (final locale in scope.localeTags) {
        final t = message.translationFor(locale);
        out.write('      ${tsString(locale.bcp47)}: { raw: ${tsString(t.raw)}, '
            'isFallback: ${t.isFallback}, source: '
            '${tsString(t.source.bcp47)} },\n');
      }
      out
        ..write('    },\n')
        ..write('  },\n');
    }
    out
      ..write('];\n\n')
      ..write('/**\n * Renders the message `key` of `locale` with `args` '
          '(placeholder name -> value),\n * without static types.\n */\n')
      ..write('export async function format(\n')
      ..write('  locale: Locale,\n')
      ..write('  key: string,\n')
      ..write('  args: Readonly<Record<string, unknown>> = {},\n')
      ..write('): Promise<string> {\n')
      ..write('  return formatMessage(await loaders[locale](), key, args);\n')
      ..write('}\n');
    return out.toString();
  }

  String _nullable(String? value) => value == null ? 'null' : tsString(value);

  String _locale(ScopeLocale locale) {
    final tag = locale.tag;
    final rule = tsPluralRuleName(tsPluralLocale(tag));
    final imports = <String>{};
    final body = StringBuffer();
    var fallbacks = 0;
    for (final message in scope.messages) {
      final translation = message.translationFor(tag);
      if (translation.isFallback) fallbacks++;
      final ctx = _Ctx(message, rule, imports);
      final String value;
      if (message.hasPlaceholders) {
        final expr = ctx.expr(translation.ast, '  ');
        final param = ctx.usesArgs ? 'args' : '_args';
        value = '($param: ${_argsType(message)}): string => $expr';
      } else {
        value = ctx.expr(translation.ast, '  ');
      }
      body.write('  ${tsPropertyKey(message.key)}: $value,');
      if (translation.isFallback) {
        body.write(' // fallback: ${translation.source.bcp47}');
      }
      body.write('\n');
    }
    if (imports.contains(rule)) pluralLocales.add(tsPluralLocale(tag));
    final sortedImports = imports.toList()..sort();
    final doc = <String>[
      'Messages of the `${scope.name}` scope in `${tag.bcp47}`.',
      if (locale.syntheticFrom case final LocaleTag from) ...[
        '',
        'The sheet has no `${tag.code}` column: the texts are copied from '
            '`${from.bcp47}`.',
      ],
      if (fallbacks > 0) ...[
        '',
        '$fallbacks of ${scope.messages.length} messages have no '
            'translation and use a fallback text.',
      ],
    ];
    final out = StringBuffer(header);
    if (sortedImports.isNotEmpty) {
      out.write('import { ${sortedImports.join(', ')} } from '
          "'../runtime.js';\n");
    }
    out
      ..write("import type { $_type } from './types.js';\n\n")
      ..write(tsDocComment(doc))
      ..write('export const messages: $_type = /* @__PURE__ */ '
          'Object.freeze({\n')
      ..write(body)
      ..write('});\n\n')
      ..write('export default messages;\n');
    return out.toString();
  }
}

/// Translates one message of one locale into a TypeScript expression.
final class _Ctx {
  _Ctx(this.message, this.rule, this.imports);

  final Message message;
  final String rule;
  final Set<String> imports;
  bool usesArgs = false;

  /// An expression of type `string` for [ast]; [indent] is the indentation
  /// of the line the expression starts on.
  String expr(IcuMessage ast, String indent) {
    final parts = ast.parts;
    if (parts.isEmpty) return "''";
    if (ast.isPlainText) return tsString(ast.plainText);
    if (parts.length == 1) {
      switch (parts.single) {
        case final IcuPlural plural:
          return _plural(plural, indent);
        case final IcuSelect select:
          return _select(select, indent);
        case IcuArgument(:final name)
            when message.placeholder(name)?.type == PlaceholderType.string:
          usesArgs = true;
          return _argAccess(name);
        case IcuText() || IcuArgument():
          break;
      }
    }
    final out = StringBuffer('`');
    for (final part in parts) {
      switch (part) {
        case IcuText(:final text):
          out.write(tsTemplateText(text));
        case IcuArgument(:final name):
          out.write('\${${_argument(name)}}');
        case final IcuPlural plural:
          out.write('\${${_plural(plural, indent)}}');
        case final IcuSelect select:
          out.write('\${${_select(select, indent)}}');
      }
    }
    out.write('`');
    return out.toString();
  }

  String _argument(String name) {
    usesArgs = true;
    final access = _argAccess(name);
    if (message.placeholder(name)?.type == PlaceholderType.double) {
      imports.add('formatDouble');
      return 'formatDouble($access)';
    }
    return access;
  }

  String _plural(IcuPlural plural, String indent) {
    usesArgs = true;
    imports
      ..add('plural')
      ..add(rule);
    final inner = '$indent  ';
    final out = StringBuffer(
      'plural(${_argAccess(plural.argument)}, $rule, {\n',
    );
    for (final MapEntry(key: category, value: branch) in plural.cases.entries) {
      out.write('$inner${category.name}: ${expr(branch, inner)},\n');
    }
    out.write('$indent})');
    return out.toString();
  }

  String _select(IcuSelect select, String indent) {
    usesArgs = true;
    imports.add('select');
    // A later duplicate case wins, at the position of the first one (what
    // a JavaScript object literal with duplicate keys would do).
    final cases = <String, IcuMessage>{};
    for (final branch in select.branches) {
      cases[branch.value] = branch.message;
    }
    final inner = '$indent  ';
    final out = StringBuffer(
      'select(${_argAccess(select.argument)}, {\n',
    );
    for (final MapEntry(:key, :value) in cases.entries) {
      out.write('$inner${tsPropertyKey(key)}: ${expr(value, inner)},\n');
    }
    out.write('$indent})');
    return out.toString();
  }
}
