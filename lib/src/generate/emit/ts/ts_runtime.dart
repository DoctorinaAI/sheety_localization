/// The generated `runtime.ts`: plural / select logic identical to
/// `package:intl` (which the Dart target uses), Dart-compatible number
/// formatting, BCP 47 locale negotiation and the metadata types.
library;

import '../../cldr/plural_rules.dart';
import '../../model.dart';

/// The CLDR locale whose cardinal rules [locale] uses (`pt_BR` -> `pt`,
/// `pt_PT` -> `pt_PT`), or `root` (every number is `other`) when CLDR has
/// none.
String tsPluralLocale(LocaleTag locale) =>
    resolvePluralLocale(locale.code) ?? 'root';

/// Name of the exported rule function of the CLDR locale [cldrLocale] (a
/// value of [tsPluralLocale]): `plural_ru`, `plural_pt_PT`, `plural_root`.
String tsPluralRuleName(String cldrLocale) => 'plural_$cldrLocale';

/// The source of `runtime.ts` with compiled rule functions for
/// [pluralLocales] (values of [tsPluralLocale]; sorted and de-duplicated
/// here). [header] is the complete header (comment lines) of the file.
String tsRuntimeSource({
  required Iterable<String> pluralLocales,
  required String header,
}) {
  final locales = pluralLocales.toSet().toList()..sort();
  final rules = [for (final locale in locales) _compileRules(locale)];
  final out = StringBuffer()
    ..write(header)
    ..write(_runtimeHead);
  if (rules.any((r) => r.contains('inRange('))) out.write(_inRange);
  out
    ..write('/** Unicode CLDR release the plural rules come from. */\n')
    ..write("export const cldrVersion = '$cldrVersion';\n");
  for (final rule in rules) {
    out
      ..write('\n')
      ..write(rule);
  }
  return out.toString();
}

const String _inRange = '''
/** Whether `value` is an integer within `low..high`. */
function inRange(value: number, low: number, high: number): boolean {
  return Number.isInteger(value) && value >= low && value <= high;
}

''';

String _compileRules(String locale) {
  final rules = pluralRulesFor(locale);
  final out = StringBuffer();
  if (rules.conditions.isEmpty) {
    out.write('/** Plural rules of `$locale`: every number is `other`. */\n');
  } else {
    out.write('/**\n * CLDR cardinal plural rules of `$locale`:\n');
    for (final MapEntry(key: category, value: condition)
        in rules.conditions.entries) {
      out.write(' * - `${category.name}`: `$condition`\n');
    }
    out.write(' */\n');
  }
  final name = tsPluralRuleName(locale);
  if (rules.conditions.isEmpty) {
    out
      ..write('export function $name(_operands: PluralOperands): '
          'PluralCategory {\n')
      ..write("  return 'other';\n}\n");
    return out.toString();
  }
  out.write('export function $name(o: PluralOperands): PluralCategory {\n');
  for (final MapEntry(key: category, value: condition)
      in rules.conditions.entries) {
    out.write('  if (${_condition(condition)}) return '
        "'${category.name}';\n");
  }
  out.write("  return 'other';\n}\n");
  return out.toString();
}

String _condition(PluralCondition condition) {
  final groups = [
    for (final group in condition.alternatives)
      group.map(_relation).join(' && '),
  ];
  if (groups.length == 1) return groups.single;
  return [
    for (var k = 0; k < groups.length; k++)
      condition.alternatives[k].length > 1 ? '(${groups[k]})' : groups[k],
  ].join(' || ');
}

String _relation(PluralRelation relation) {
  // `n` is the count itself (possibly fractional, sign kept — like intl);
  // the other operands are integers computed by `pluralOperands`.
  final operand = 'o.${relation.operand.name}';
  final m = relation.modulus;
  final x = m == null ? operand : 'mod($operand, $m)';
  final tests = [
    for (final (:low, :high) in relation.ranges)
      low == high ? '$x === $low' : 'inRange($x, $low, $high)',
  ];
  final any = tests.length == 1 ? tests.single : '(${tests.join(' || ')})';
  if (!relation.negated) return any;
  if (tests.length == 1 && !tests.single.startsWith('inRange')) {
    return tests.single.replaceFirst(' === ', ' !== ');
  }
  return '!$any';
}

const String _runtimeHead = r'''
/* eslint-disable */
/**
 * Runtime of the generated messages; no dependencies, runs in browsers,
 * Node.js, Deno and workers.
 *
 * Plurals and selects behave exactly like `Intl.pluralLogic` and
 * `Intl.selectLogic` of Dart's `package:intl`, which the Flutter target of
 * the same sheet uses, so every target renders the same text:
 *
 * - an explicit `=0` / `=1` / `=2` (or `zero` / `one` / `two`) branch wins
 *   for the counts 0, 1 and 2 regardless of the language's rules;
 * - otherwise the CLDR category of the count is used, falling back to
 *   `other` when the message has no branch for it, except that `two` falls
 *   back to `few` first;
 * - the plural operands are computed like intl does: `i` is the count
 *   *rounded* (half away from zero), `v` and `f` come from at most three
 *   fraction digits of the shortest representation, the sign is kept and the
 *   compact exponent `e` is always 0.
 *
 * The rules are compiled from Unicode CLDR instead of using the engine's
 * `Intl.PluralRules`, whose results depend on the ICU data the engine ships
 * and which computes the operands differently for fractional counts.
 */

/** A CLDR plural category. */
export type PluralCategory = 'zero' | 'one' | 'two' | 'few' | 'many' | 'other';

/** Plural operands of a count (UTS #35), computed the way `package:intl` does. */
export interface PluralOperands {
  /** The count itself (not made absolute, possibly fractional). */
  readonly n: number;
  /** Integer digits: the count rounded half away from zero. */
  readonly i: number;
  /** Number of visible fraction digits (at most 3). */
  readonly v: number;
  /** Visible fraction digits without trailing zeros: always 0, as in intl. */
  readonly w: number;
  /** Visible fraction digits, with trailing zeros. */
  readonly f: number;
  /** Visible fraction digits, without trailing zeros. */
  readonly t: number;
  /** Compact decimal exponent: always 0, as in intl. */
  readonly e: number;
}

/** Plural rules of one language: the category of some operands. */
export type PluralRule = (operands: PluralOperands) => PluralCategory;

/** The branches of a plural message; `=0` / `=1` / `=2` are `zero` / `one` / `two`. */
export interface PluralCases {
  readonly zero?: string;
  readonly one?: string;
  readonly two?: string;
  readonly few?: string;
  readonly many?: string;
  readonly other: string;
}

/** The branches of a select message. */
export interface SelectCases {
  readonly other: string;
  readonly [choice: string]: string;
}

/** Dart's `%`: the result is never negative for a positive divisor. */
function mod(value: number, divisor: number): number {
  const r = value % divisor;
  return r < 0 ? r + divisor : r;
}

/** Plural operands of `count`, exactly as `package:intl` computes them. */
export function pluralOperands(count: number): PluralOperands {
  const n = count;
  const i = n < 0 ? -Math.round(-n) : Math.round(n);
  const text = String(n);
  const dot = text.indexOf('.');
  const v = dot < 0 ? 0 : Math.min(text.length - dot - 1, 3);
  const base = 10 ** v;
  const f = mod(Math.floor(n * base), base);
  let t = f;
  if (t !== 0) {
    while (t % 10 === 0) t /= 10;
  }
  return { n, i, v, w: 0, f, t, e: 0 };
}

/**
 * Chooses the branch of a plural message for `count` (`Intl.pluralLogic`).
 *
 * Throws a `RangeError` for `NaN` and infinite counts (Dart throws too).
 */
export function plural(count: number, rule: PluralRule, cases: PluralCases): string {
  if (!Number.isFinite(count)) throw new RangeError(`Invalid plural count: ${count}`);
  if (count === 0 && cases.zero !== undefined) return cases.zero;
  if (count === 1 && cases.one !== undefined) return cases.one;
  if (count === 2 && cases.two !== undefined) return cases.two;
  const category = rule(pluralOperands(count));
  const chosen = cases[category];
  if (chosen !== undefined) return chosen;
  if (category === 'two' && cases.few !== undefined) return cases.few;
  return cases.other;
}

const hasOwn = (target: object, key: string): boolean =>
  Object.prototype.hasOwnProperty.call(target, key);

/**
 * Chooses the branch of a select message (`Intl.selectLogic`): the exact
 * choice, else the part after the last `.` (`Gender.male` -> `male`), else
 * `other`.
 */
export function select(choice: string, cases: SelectCases): string {
  const exact = hasOwn(cases, choice) ? cases[choice] : undefined;
  if (exact !== undefined) return exact;
  const last = choice.slice(choice.lastIndexOf('.') + 1);
  const short = hasOwn(cases, last) ? cases[last] : undefined;
  if (short !== undefined) return short;
  return cases.other;
}

/**
 * Formats a `double` placeholder like Dart's `'$value'`: integral values get
 * a `.0` suffix (`1.0`), everything else is JavaScript's shortest
 * representation, which is also Dart's (`1.5`, `1e+21`, `1e-7`, `NaN`).
 */
export function formatDouble(value: number): string {
  if (Number.isInteger(value) && Math.abs(value) < 1e21) {
    return `${Object.is(value, -0) ? '-0' : String(value)}.0`;
  }
  return String(value);
}

// Locale negotiation is specified once and implemented identically by the
// Python runtime (`negotiate_locale`); a shared test table runs against both.
// Only ASCII is meaningful: whitespace is " \t\n\v\f\r", subtags are ASCII
// letters / digits.

const WHITESPACE = /^[ \t\n\v\f\r]+|[ \t\n\v\f\r]+$/g;
const strip = (text: string): string => text.replace(WHITESPACE, '');
const LANGUAGE = /^[A-Za-z]{2,3}$/;
const SCRIPT = /^[A-Za-z]{4}$/;
const REGION = /^(?:[A-Za-z]{2}|[0-9]{3})$/;
const QUALITY = /^(?:[0-9]+(?:\.[0-9]*)?|\.[0-9]+)$/;
const ALIASES: Readonly<Record<string, string>> = { iw: 'he', in: 'id', ji: 'yi', jw: 'jv', mo: 'ro' };
const alias = (language: string): string | undefined =>
  hasOwn(ALIASES, language) ? ALIASES[language] : undefined;

/**
 * Normalizes a BCP 47 / POSIX locale (`pt-br`, `PT_br`, `zh-Hant-TW`,
 * `en_US.UTF-8`, `de-DE-u-co-phonebk`) to the generator's code form
 * (`pt_BR`, `zh_Hant_TW`, `en_US`, `de_DE`); `undefined` when it is not a
 * locale (`*`, `C`, empty).
 *
 * The text before the first `.` and `@` is split at `-` and `_`; the first
 * subtag must be a 2-3 letter language, then an optional 4-letter script and
 * an optional 2-letter or 3-digit region are taken while they come in that
 * order; anything else ends the tag.
 */
export function normalizeLocale(tag: string): string | undefined {
  const head = (strip(tag).split('.')[0] ?? '').split('@')[0] ?? '';
  const parts = head.split(/[-_]/).filter((part) => part !== '');
  const first = parts[0];
  if (first === undefined || !LANGUAGE.test(first)) return undefined;
  let script: string | undefined;
  let region: string | undefined;
  for (const part of parts.slice(1)) {
    if (script === undefined && region === undefined && SCRIPT.test(part)) {
      script = part.charAt(0).toUpperCase() + part.slice(1).toLowerCase();
    } else if (region === undefined && REGION.test(part)) {
      region = part.toUpperCase();
    } else {
      break;
    }
  }
  return [first.toLowerCase(), script, region].filter((p) => p !== undefined).join('_');
}

/** `zh_Hant_TW` -> `zh_Hant_TW`, `zh_Hant`, `zh_TW`, `zh` (then the same for an alias). */
function candidates(code: string): string[] {
  const parts = code.split('_');
  const language = parts[0] ?? '';
  const rest = parts.slice(1);
  const script = rest.find((p) => p.length === 4);
  const region = rest.find((p) => p.length !== 4);
  const result: string[] = [];
  for (const lang of [language, alias(language)]) {
    if (lang === undefined) continue;
    if (script !== undefined && region !== undefined) result.push(`${lang}_${script}_${region}`);
    if (script !== undefined) result.push(`${lang}_${script}`);
    if (region !== undefined) result.push(`${lang}_${region}`);
    result.push(lang);
  }
  return result;
}

/**
 * The language tags of an HTTP `Accept-Language` header, best first:
 * `"fr-CH, fr;q=0.9, en;q=0.8, *;q=0.5"` -> `["fr-CH", "fr", "en"]`.
 *
 * A `q` value must be a plain decimal number (`0.8`, `1`, `.5`); values above
 * 1 count as 1, anything else as 0. Tags with `q=0` and the wildcard `*` are
 * dropped; equal weights keep their order.
 */
export function parseAcceptLanguage(header: string): string[] {
  const weighted: { readonly quality: number; readonly index: number; readonly tag: string }[] = [];
  header.split(',').forEach((item, index) => {
    const semi = item.indexOf(';');
    const tag = strip(semi < 0 ? item : item.slice(0, semi));
    if (tag === '' || tag === '*') return;
    let quality = 1;
    for (const param of (semi < 0 ? '' : item.slice(semi + 1)).split(';')) {
      const eq = param.indexOf('=');
      const name = strip(eq < 0 ? param : param.slice(0, eq));
      if (name !== 'q' && name !== 'Q') continue;
      const value = strip(eq < 0 ? '' : param.slice(eq + 1));
      quality = QUALITY.test(value) ? Math.min(Number(value), 1) : 0;
    }
    if (!(quality > 0)) return;
    weighted.push({ quality, index, tag });
  });
  weighted.sort((a, b) => b.quality - a.quality || a.index - b.index);
  return weighted.map((w) => w.tag);
}

/**
 * Picks the best of `available` (BCP 47 tags, `pt-BR`) for `requested`.
 *
 * `requested` is one tag (`pt-BR`), an `Accept-Language` header (anything
 * with `,` or `;`), a list of tags, best first (`navigator.languages`), or
 * nothing. Every requested tag (see `normalizeLocale`) is tried with its
 * fallbacks (`zh-Hant-TW` -> `zh-Hant` -> `zh-TW` -> `zh`, then the same
 * for the current code of a deprecated language: `iw` -> `he`); then the
 * first available locale of any requested language (`pt` -> `pt-BR`); then
 * `fallback`.
 */
export function negotiateLocale<L extends string>(
  requested: string | readonly string[] | null | undefined,
  available: readonly L[],
  fallback: L,
): L {
  if (requested == null) return fallback;
  const tags: readonly string[] =
    typeof requested !== 'string'
      ? requested
      : requested.includes(',') || requested.includes(';')
        ? parseAcceptLanguage(requested)
        : [requested];
  const byCode = new Map<string, L>();
  for (const locale of available) {
    const code = locale.replace(/-/g, '_');
    if (!byCode.has(code)) byCode.set(code, locale);
  }
  const codes: string[] = [];
  for (const tag of tags) {
    const code = normalizeLocale(tag);
    if (code !== undefined) codes.push(code);
  }
  for (const code of codes) {
    for (const candidate of candidates(code)) {
      const hit = byCode.get(candidate);
      if (hit !== undefined) return hit;
    }
  }
  for (const code of codes) {
    const language = code.split('_')[0] ?? '';
    const languages = [language, alias(language)];
    for (const locale of available) {
      if (languages.includes(locale.split('-')[0])) return locale;
    }
  }
  return fallback;
}

/** A message value: a plain string, or a function of the placeholders. */
export type MessageValue = string | ((args: never) => string);

/**
 * Renders the message `key` of `messages` (a dictionary of one locale) with
 * `args`, without static types: for tests and tooling.
 *
 * Throws a `RangeError` when the dictionary has no such message.
 */
export function formatMessage(
  messages: object,
  key: string,
  args: Readonly<Record<string, unknown>> = {},
): string {
  if (!hasOwn(messages, key)) throw new RangeError(`Unknown message: ${key}`);
  const value: unknown = (messages as Readonly<Record<string, unknown>>)[key];
  if (typeof value === 'string') return value;
  if (typeof value === 'function') return String((value as (args: unknown) => unknown)(args));
  throw new TypeError(`Not a message: ${key}`);
}

/** Type of a placeholder, as declared in the sheet (ARB names). */
export type PlaceholderType = 'String' | 'int' | 'num' | 'double' | 'Object';

/** A placeholder of a message. */
export interface PlaceholderInfo {
  readonly name: string;
  readonly type: PlaceholderType;
  readonly example: string | null;
  readonly description: string | null;
  /** Whether the sheet declares it (otherwise it was inferred from the text). */
  readonly declared: boolean;
}

/** The text of a message in one locale. */
export interface TemplateInfo {
  /** The ICU message, exactly as in the sheet. */
  readonly raw: string;
  /** Whether the locale has no text of its own and uses `source`'s. */
  readonly isFallback: boolean;
  /** The locale (BCP 47) the text was taken from. */
  readonly source: string;
}

/** Metadata of a message, for tests and tooling. */
export interface MessageEntry<L extends string = string, K extends string = string> {
  readonly key: K;
  readonly description: string | null;
  readonly placeholders: readonly PlaceholderInfo[];
  readonly templates: { readonly [P in L]: TemplateInfo };
}

''';
