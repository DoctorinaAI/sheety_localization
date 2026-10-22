/// CLDR plural rules: operands, rule-expression parser and evaluator.
///
/// The rule syntax is the one of UTS #35, Part 3 "Language Plural Rules"
/// (https://unicode.org/reports/tr35/tr35-numbers.html#Language_Plural_Rules):
///
/// ```text
/// condition     = and_condition ('or' and_condition)*
/// and_condition = relation ('and' relation)*
/// relation      = expr ('=' | '!=') range_list
/// expr          = operand ('%' value)?
/// operand       = 'n' | 'i' | 'f' | 't' | 'v' | 'w' | 'c' | 'e'
/// range_list    = (range | value) (',' (range | value))*
/// range         = value '..' value
/// ```
///
/// The rule data itself lives in `plural_data.dart`, generated from the
/// Unicode `cldr-json` package by `tool/cldr_plurals.dart`.
library;

import 'plural_data.dart';

export 'plural_data.dart' show cldrVersion;

/// A CLDR plural category.
///
/// The declaration order is the canonical CLDR order
/// (`zero one two few many other`).
enum PluralCategory {
  /// `zero`
  zero,

  /// `one`
  one,

  /// `two`
  two,

  /// `few`
  few,

  /// `many`
  many,

  /// `other` — the mandatory fallback category of every locale.
  other;

  /// Parses a category keyword, returning `null` when it is not one.
  static PluralCategory? tryParse(String keyword) => switch (keyword) {
        'zero' => zero,
        'one' => one,
        'two' => two,
        'few' => few,
        'many' => many,
        'other' => other,
        _ => null,
      };
}

/// Kind of plural rules: cardinal (`1 file`) or ordinal (`1st file`).
enum PluralType {
  /// Cardinal numbers, used by ICU `plural`.
  cardinal,

  /// Ordinal numbers, used by ICU `selectordinal`.
  ordinal,
}

/// Plural operands of a decimal number, as defined by UTS #35.
///
/// | operand | meaning                                                    |
/// |---------|------------------------------------------------------------|
/// | `n`     | absolute value of the source number                        |
/// | `i`     | integer digits of `n`                                      |
/// | `v`     | number of visible fraction digits, with trailing zeros     |
/// | `w`     | number of visible fraction digits, without trailing zeros  |
/// | `f`     | visible fraction digits, with trailing zeros, as integer   |
/// | `t`     | visible fraction digits, without trailing zeros, as integer|
/// | `e`/`c` | exponent of the power of 10 in compact decimal notation    |
final class PluralOperands {
  /// Creates operands from their components.
  const PluralOperands({
    required this.i,
    this.v = 0,
    this.w = 0,
    this.f = 0,
    this.t = 0,
    this.e = 0,
  });

  /// Operands of a decimal string such as `1`, `1.50`, `-3.0` or `1.1c6`.
  ///
  /// The string is taken literally: `1.0` has `v = 1` and differs from `1`.
  /// A compact exponent (`c` or `e`, as used by the CLDR samples) shifts the
  /// decimal point and is reported as the [e] operand.
  factory PluralOperands.parse(String source) {
    final match = _decimal.firstMatch(source.trim());
    if (match == null) {
      throw FormatException('Not a decimal number', source);
    }
    var integer = match.group(1)!;
    var fraction = match.group(2) ?? '';
    final exponent = int.parse(match.group(3) ?? '0');
    if (exponent > 0) {
      final shifted = fraction.padRight(exponent, '0');
      integer += shifted.substring(0, exponent);
      fraction = shifted.substring(exponent);
    }
    final trimmed = fraction.replaceFirst(_trailingZeros, '');
    return PluralOperands(
      i: _bounded(integer),
      v: fraction.length,
      w: trimmed.length,
      f: fraction.isEmpty ? 0 : _bounded(fraction),
      t: trimmed.isEmpty ? 0 : _bounded(trimmed),
      e: exponent,
    );
  }

  /// Operands of [value] formatted the way ECMA-402 `Intl.PluralRules`
  /// formats a number by default.
  ///
  /// The shortest round-trip decimal representation of [value] is rounded
  /// half away from zero ("halfExpand") to at most [maximumFractionDigits]
  /// digits and then padded to at least [minimumFractionDigits] digits —
  /// exactly what `new Intl.PluralRules(locale, {minimumFractionDigits,
  /// maximumFractionDigits}).select(value)` does. The defaults (`0` and `3`)
  /// are the ECMA-402 defaults.
  factory PluralOperands.fromNum(
    num value, {
    int minimumFractionDigits = 0,
    int maximumFractionDigits = 3,
  }) {
    final text = _roundDecimal(
      _plainDecimal(value.abs()),
      maximumFractionDigits,
    );
    final dot = text.indexOf('.');
    var integer = dot < 0 ? text : text.substring(0, dot);
    var fraction = dot < 0 ? '' : text.substring(dot + 1);
    fraction = fraction.replaceFirst(_trailingZeros, '');
    if (fraction.length < minimumFractionDigits) {
      fraction = fraction.padRight(minimumFractionDigits, '0');
    }
    if (integer.isEmpty) integer = '0';
    return PluralOperands.parse(
      fraction.isEmpty ? integer : '$integer.$fraction',
    );
  }

  /// Operands exactly as `package:intl` (`plural_rules.dart`,
  /// `startRuleEvaluation`) computes them for `Intl.pluralLogic` without a
  /// `precision`.
  ///
  /// This differs from CLDR in two ways that matter for fractional values:
  /// `i` is `n.round()` (not truncated), and `f` is computed with floating
  /// point arithmetic from at most three fraction digits. An integral double
  /// (`1.0`) is first converted to an int, so `v` is `0` for it. The sign is
  /// kept (`n` is not made absolute). Only `i`, `v`, `f` and `t` are
  /// produced; `w` and `e` are always `0`, as in intl.
  factory PluralOperands.intl(num howMany) {
    var n = howMany;
    final truncated = n.truncate();
    if (truncated == n) n = truncated;
    final i = n.round();
    final text = '$n';
    final dot = text.indexOf('.');
    final decimals = dot < 0 ? 0 : text.length - dot - 1;
    final v = decimals < 3 ? decimals : 3;
    var base = 1;
    for (var k = 0; k < v; k++) {
      base *= 10;
    }
    final f = (n * base).floor() % base;
    var t = f;
    if (t != 0) {
      while (t % 10 == 0) {
        t ~/= 10;
      }
    }
    return PluralOperands(i: i, v: v, f: f, t: t);
  }

  /// Parses integer digits, keeping huge values within 64 bits.
  ///
  /// Plural rules only ever compare `i` with small numbers or take it modulo
  /// a power of ten no larger than 10^6, so a value beyond 18 digits is
  /// replaced by `1` followed by its last 17 digits: every modulo stays the
  /// same and the value stays too large to equal any rule constant.
  static int _bounded(String digits) {
    final stripped = digits.replaceFirst(RegExp('^0+(?=.)'), '');
    if (stripped.length <= 18) return int.parse(stripped);
    return int.parse('1${stripped.substring(stripped.length - 17)}');
  }

  static final RegExp _decimal =
      RegExp(r'^[-+]?(\d+)(?:\.(\d*))?(?:[ce](\d+))?$');
  static final RegExp _trailingZeros = RegExp(r'0+$');

  /// Integer digits of `n`.
  final int i;

  /// Number of visible fraction digits, with trailing zeros.
  final int v;

  /// Number of visible fraction digits, without trailing zeros.
  final int w;

  /// Visible fraction digits, with trailing zeros, as an integer.
  final int f;

  /// Visible fraction digits, without trailing zeros, as an integer.
  final int t;

  /// Compact decimal exponent (`c` and `e` are synonyms).
  final int e;

  /// Whether `n` is an integer (has no non-zero fraction digits).
  bool get isIntegral => f == 0;

  @override
  String toString() => 'PluralOperands(i: $i, v: $v, w: $w, f: $f, t: $t, '
      'e: $e)';

  @override
  bool operator ==(Object other) =>
      other is PluralOperands &&
      other.i == i &&
      other.v == v &&
      other.w == w &&
      other.f == f &&
      other.t == t &&
      other.e == e;

  @override
  int get hashCode => Object.hash(i, v, w, f, t, e);
}

/// Plain (non-exponential) shortest decimal representation of [value] >= 0.
String _plainDecimal(num value) {
  if (value is int) return '$value';
  final text = value.toString();
  final exp = text.indexOf('e');
  if (exp < 0) return text;
  // 1e+21, 1.5e-7 and alike: expand the exponent.
  final mantissa = text.substring(0, exp);
  final power = int.parse(text.substring(exp + 1));
  final dot = mantissa.indexOf('.');
  final digits = mantissa.replaceFirst('.', '');
  final pointAt = (dot < 0 ? mantissa.length : dot) + power;
  if (pointAt <= 0) return '0.${'0' * -pointAt}$digits';
  if (pointAt >= digits.length) return digits.padRight(pointAt, '0');
  return '${digits.substring(0, pointAt)}.${digits.substring(pointAt)}';
}

/// Rounds the decimal string [text] (non-negative) half away from zero to at
/// most [digits] fraction digits.
String _roundDecimal(String text, int digits) {
  final dot = text.indexOf('.');
  if (dot < 0 || text.length - dot - 1 <= digits) return text;
  final keep = text.substring(0, dot + 1 + digits).replaceFirst('.', '');
  final roundUp = text.codeUnitAt(dot + 1 + digits) >= 0x35; // '5'
  var number = BigInt.parse(keep);
  if (roundUp) number += BigInt.one;
  var result = number.toString().padLeft(digits + 1, '0');
  if (digits == 0) return result;
  final split = result.length - digits;
  result = '${result.substring(0, split)}.${result.substring(split)}';
  return result;
}

/// An operand of a plural rule relation.
enum PluralOperand {
  /// Absolute value of the number.
  n,

  /// Integer digits.
  i,

  /// Visible fraction digit count, with trailing zeros.
  v,

  /// Visible fraction digit count, without trailing zeros.
  w,

  /// Visible fraction digits, with trailing zeros.
  f,

  /// Visible fraction digits, without trailing zeros.
  t,

  /// Compact decimal exponent.
  e,
}

/// An inclusive integer range of a relation's range list.
typedef PluralRange = ({int low, int high});

/// One relation of a plural rule, e.g. `i % 10 = 2..4`.
final class PluralRelation {
  /// Creates a relation.
  const PluralRelation({
    required this.operand,
    required this.ranges,
    this.modulus,
    this.negated = false,
  });

  /// Operand the relation tests.
  final PluralOperand operand;

  /// Optional modulus (`% 10`).
  final int? modulus;

  /// Whether the relation is `!=` rather than `=`.
  final bool negated;

  /// Values and ranges the operand is matched against.
  final List<PluralRange> ranges;

  /// Evaluates the relation for [operands].
  bool evaluate(PluralOperands operands) {
    // `n` is the only operand that can be non-integral. A non-integral value
    // never equals an integer, so `=` is false and `!=` is true.
    final int value;
    switch (operand) {
      case PluralOperand.n:
        if (!operands.isIntegral) return negated;
        value = operands.i;
      case PluralOperand.i:
        value = operands.i;
      case PluralOperand.v:
        value = operands.v;
      case PluralOperand.w:
        value = operands.w;
      case PluralOperand.f:
        value = operands.f;
      case PluralOperand.t:
        value = operands.t;
      case PluralOperand.e:
        value = operands.e;
    }
    final m = modulus;
    final x = m == null ? value : value % m;
    var inRange = false;
    for (final (:low, :high) in ranges) {
      if (x >= low && x <= high) {
        inRange = true;
        break;
      }
    }
    return negated ? !inRange : inRange;
  }

  @override
  String toString() {
    final expr = modulus == null ? operand.name : '${operand.name} % $modulus';
    final list = ranges
        .map((r) => r.low == r.high ? '${r.low}' : '${r.low}..${r.high}')
        .join(',');
    return '$expr ${negated ? '!=' : '='} $list';
  }
}

/// A parsed plural rule condition: a disjunction of conjunctions.
///
/// An empty condition (no relations) is always true; that is how the
/// implicit `other` rule is represented.
final class PluralCondition {
  /// Creates a condition from `or`-ed groups of `and`-ed relations.
  const PluralCondition(this.alternatives);

  /// Parses a CLDR rule expression (without its `@integer` / `@decimal`
  /// samples). Throws a [FormatException] on malformed input.
  factory PluralCondition.parse(String source) => _RuleParser(source).parse();

  /// The `or` alternatives; each is a list of `and`-ed relations.
  final List<List<PluralRelation>> alternatives;

  /// Whether this condition is always true.
  bool get isAlways => alternatives.isEmpty;

  /// Evaluates the condition for [operands].
  bool evaluate(PluralOperands operands) {
    if (alternatives.isEmpty) return true;
    for (final group in alternatives) {
      if (group.every((r) => r.evaluate(operands))) return true;
    }
    return false;
  }

  @override
  String toString() => alternatives.map((g) => g.join(' and ')).join(' or ');
}

final class _RuleParser {
  _RuleParser(this.source);

  final String source;
  int _pos = 0;

  PluralCondition parse() {
    _skip();
    if (_pos >= source.length) return const PluralCondition([]);
    final alternatives = <List<PluralRelation>>[];
    do {
      final group = <PluralRelation>[];
      do {
        group.add(_relation());
      } while (_keyword('and'));
      alternatives.add(group);
    } while (_keyword('or'));
    _skip();
    if (_pos < source.length) _fail('Unexpected "${source[_pos]}"');
    return PluralCondition(alternatives);
  }

  PluralRelation _relation() {
    _skip();
    if (_pos >= source.length) _fail('Expected an operand');
    final operand = switch (source[_pos]) {
      'n' => PluralOperand.n,
      'i' => PluralOperand.i,
      'v' => PluralOperand.v,
      'w' => PluralOperand.w,
      'f' => PluralOperand.f,
      't' => PluralOperand.t,
      'e' || 'c' => PluralOperand.e,
      final other => _fail('Unknown operand "$other"'),
    };
    _pos++;
    _skip();
    int? modulus;
    if (_peek('%')) {
      _pos++;
      modulus = _value();
      if (modulus == 0) _fail('Modulus must not be zero');
    }
    _skip();
    final bool negated;
    if (_peek('!=')) {
      negated = true;
      _pos += 2;
    } else if (_peek('=')) {
      negated = false;
      _pos++;
    } else {
      _fail('Expected "=" or "!="');
    }
    final ranges = <PluralRange>[];
    do {
      final low = _value();
      _skip();
      if (_peek('..')) {
        _pos += 2;
        final high = _value();
        if (high < low) _fail('Empty range $low..$high');
        ranges.add((low: low, high: high));
      } else {
        ranges.add((low: low, high: low));
      }
      _skip();
    } while (_consume(','));
    return PluralRelation(
      operand: operand,
      modulus: modulus,
      negated: negated,
      ranges: ranges,
    );
  }

  int _value() {
    _skip();
    final start = _pos;
    while (_pos < source.length &&
        source.codeUnitAt(_pos) >= 0x30 &&
        source.codeUnitAt(_pos) <= 0x39) {
      _pos++;
    }
    if (start == _pos) _fail('Expected a number');
    return int.parse(source.substring(start, _pos));
  }

  bool _keyword(String word) {
    _skip();
    if (!source.startsWith(word, _pos)) return false;
    final end = _pos + word.length;
    if (end < source.length && source[end] != ' ') return false;
    _pos = end;
    return true;
  }

  bool _consume(String token) {
    _skip();
    if (!source.startsWith(token, _pos)) return false;
    _pos += token.length;
    return true;
  }

  bool _peek(String token) => source.startsWith(token, _pos);

  void _skip() {
    while (_pos < source.length && source[_pos] == ' ') {
      _pos++;
    }
  }

  Never _fail(String message) =>
      throw FormatException('Invalid plural rule: $message', source, _pos);
}

/// Plural rules of one locale for one [PluralType].
final class PluralRules {
  /// Creates rules from parsed [conditions]; `other` is implicit.
  PluralRules({
    required this.locale,
    required this.type,
    required Map<PluralCategory, PluralCondition> conditions,
  }) : conditions = Map.unmodifiable({
          for (final category in PluralCategory.values)
            if (category != PluralCategory.other &&
                conditions[category] != null)
              category: conditions[category]!,
        });

  /// The CLDR locale the rules belong to (`_` separated, e.g. `pt_PT`), or
  /// `root` for the default rules.
  final String locale;

  /// Cardinal or ordinal.
  final PluralType type;

  /// The conditions of every category except `other`, in CLDR order.
  final Map<PluralCategory, PluralCondition> conditions;

  /// Every category of the locale, in CLDR order, always ending in `other`.
  List<PluralCategory> get categories =>
      [...conditions.keys, PluralCategory.other];

  /// Selects the category of [operands]: the first matching condition in
  /// CLDR order, `other` when none matches.
  PluralCategory select(PluralOperands operands) {
    for (final MapEntry(key: category, value: condition)
        in conditions.entries) {
      if (condition.evaluate(operands)) return category;
    }
    return PluralCategory.other;
  }

  /// Selects the category of [value] formatted like `Intl.PluralRules` does
  /// by default (see [PluralOperands.fromNum]).
  PluralCategory selectNum(num value) => select(PluralOperands.fromNum(value));
}

final Map<(String, PluralType), PluralRules> _cache = {};

/// Resolves [locale] to the CLDR locale that holds its plural rules.
///
/// [locale] may use `_` or `-` and any case (`pt-br`, `pt_BR`, `zh_Hant_TW`).
/// The lookup tries the full tag, then `language_Script` / `language_REGION`,
/// then the bare language. Returns `null` when CLDR has no rules for the
/// language (callers then use the `root` rules: everything is `other`).
String? resolvePluralLocale(
  String locale, {
  PluralType type = PluralType.cardinal,
}) {
  final table = _table(type);
  final parts = locale.trim().replaceAll('-', '_').split('_');
  if (parts.isEmpty || parts.first.isEmpty) return null;
  final code = parts.first.toLowerCase();
  final language =
      table.containsKey(code) ? code : _deprecatedLanguages[code] ?? code;
  String? script;
  String? region;
  for (final part in parts.skip(1)) {
    if (part.length == 4) {
      script = part[0].toUpperCase() + part.substring(1).toLowerCase();
    } else if (part.length == 2 || part.length == 3) {
      region = part.toUpperCase();
    }
  }
  final candidates = [
    if (script != null && region != null) '${language}_${script}_$region',
    if (script != null) '${language}_$script',
    if (region != null) '${language}_$region',
    language,
  ];
  for (final candidate in candidates) {
    if (table.containsKey(candidate)) return candidate;
  }
  return null;
}

/// The CLDR locales (keys of the cardinal rules) whose rules distinguish
/// more than `other` but which `package:intl` (0.20.x) has no plural rules
/// for: intl renders every count of these languages as `other` (after the
/// exact `=0`/`=1`/`=2` matches), while the TypeScript and Python targets
/// use the CLDR rules. A test recomputes this list from package:intl.
const Set<String> intlMissingPluralLocales = {
  'ak', 'an', 'ars', 'asa', 'ast', 'bal', 'bem', 'bez', 'bho', 'blo', //
  'brx', 'ce', 'ceb', 'cgg', 'ckb', 'csw', 'cv', 'doi', 'dsb', 'dv', 'ee',
  'eo', 'ff', 'fo', 'fy', 'gd', 'guw', 'gv', 'ha', 'hsb', 'ia', 'ie', 'io',
  'iu', 'jgo', 'jmc', 'kab', 'kaj', 'kcg', 'kkj', 'kl', 'kok', 'kok_Latn',
  'ks', 'ksb', 'ksh', 'ku', 'kw', 'lag', 'lb', 'lg', 'lij', 'lld', 'mas',
  'mgo', 'mo', 'nah', 'naq', 'nd', 'nn', 'nnh', 'nr', 'nso', 'ny', 'om',
  'os', 'pap', 'pcm', 'prg', 'rm', 'rof', 'rwk', 'saq', 'sat', 'sc', 'scn',
  'sd', 'sdh', 'se', 'seh', 'sgs', 'sh', 'shi', 'sma', 'smi', 'smj', 'smn',
  'sms', 'sn', 'so', 'ss', 'ssy', 'st', 'syr', 'teo', 'ti', 'tig', 'tk',
  'tn', 'ts', 'tzm', 'ug', 've', 'vec', 'vo', 'vun', 'wa', 'wae', 'xh',
  'xog', 'yi',
};

/// Whether the Dart target (package:intl) chooses plural branches of
/// [locale] differently from CLDR, which the TypeScript and Python targets
/// use (see [intlMissingPluralLocales]).
bool intlLacksPluralRules(String locale) => switch (resolvePluralLocale(
      locale,
    )) {
      final String resolved => intlMissingPluralLocales.contains(resolved),
      null => false,
    };

/// Deprecated ISO 639 codes still in use (intl and Java accept them).
const Map<String, String> _deprecatedLanguages = {
  'iw': 'he',
  'in': 'id',
  'ji': 'yi',
  'jw': 'jv',
  'mo': 'ro',
};

Map<String, Map<String, String>> _table(PluralType type) => switch (type) {
      PluralType.cardinal => cldrCardinalRules,
      PluralType.ordinal => cldrOrdinalRules,
    };

/// Plural rules for [locale], falling back to the `root` rules (everything
/// is `other`) when CLDR has none for the language.
PluralRules pluralRulesFor(
  String locale, {
  PluralType type = PluralType.cardinal,
}) {
  final resolved = resolvePluralLocale(locale, type: type) ?? 'root';
  return _cache.putIfAbsent((resolved, type), () {
    final source = _table(type)[resolved] ?? const <String, String>{};
    return PluralRules(
      locale: resolved,
      type: type,
      conditions: {
        for (final MapEntry(:key, :value) in source.entries)
          PluralCategory.tryParse(key)!: PluralCondition.parse(value),
      },
    );
  });
}

/// Whether CLDR has plural rules of [type] for [locale]'s language.
bool hasPluralRules(String locale, {PluralType type = PluralType.cardinal}) =>
    resolvePluralLocale(locale, type: type) != null;

/// The categories a message must provide to be complete in [locale], in CLDR
/// order, always including `other`.
List<PluralCategory> requiredCategories(String locale,
        {bool ordinal = false}) =>
    pluralRulesFor(
      locale,
      type: ordinal ? PluralType.ordinal : PluralType.cardinal,
    ).categories;

/// Every locale with cardinal (or, with [ordinal], ordinal) rules, sorted.
List<String> pluralLocales({bool ordinal = false}) =>
    (ordinal ? cldrOrdinalRules : cldrCardinalRules).keys.toList()..sort();

/// Chooses the branch of a plural message the way `Intl.pluralLogic` of
/// `package:intl` does (the Dart target uses it at runtime; the TypeScript
/// and Python targets must replicate it).
///
/// [provided] are the categories the message has a branch for — after
/// gen-l10n's mapping of `=0`/`=1`/`=2` to `zero`/`one`/`two`. [category] is
/// the CLDR category of [howMany] for the target locale.
///
/// 1. An exact match wins first: `howMany == 0` picks `zero`, `== 1` picks
///    `one`, `== 2` picks `two`, if such a branch exists — regardless of the
///    locale's rules (so English `zero{}` is used for 0).
/// 2. Otherwise the CLDR [category] is used, falling back to `other` when
///    the message has no such branch — except that `two` falls back to
///    `few` first, then to `other` (an intl quirk).
PluralCategory choosePluralBranch(
  num howMany,
  Set<PluralCategory> provided,
  PluralCategory category,
) {
  if (howMany == 0 && provided.contains(PluralCategory.zero)) {
    return PluralCategory.zero;
  }
  if (howMany == 1 && provided.contains(PluralCategory.one)) {
    return PluralCategory.one;
  }
  if (howMany == 2 && provided.contains(PluralCategory.two)) {
    return PluralCategory.two;
  }
  if (provided.contains(category)) return category;
  if (category == PluralCategory.two && provided.contains(PluralCategory.few)) {
    return PluralCategory.few;
  }
  return PluralCategory.other;
}
