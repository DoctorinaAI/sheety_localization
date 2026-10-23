/// Sanity checks applied to every translation returned by the model.
library;

import '../generate/icu/ast.dart';
import '../generate/icu/mustache.dart';
import '../generate/icu/parser.dart';

/// HTML/XML-like tags: `<b>`, `</b>`, `<br/>`.
final RegExp _tag = RegExp(r'</?[a-zA-Z][^<>]*>');

/// Leading argument of an ICU placeholder: `{name}`, `{name, number}`,
/// `{name, plural, ...}`.
final RegExp _argument = RegExp(r'^\s*([a-zA-Z_][a-zA-Z0-9_]*)\s*(,|$)');

/// An argument carrying a sub-message directive, whose branches are ordinary
/// translatable text: `{count, plural, one {...} other {...}}`.
final RegExp _directive = RegExp(
  r'^\s*[a-zA-Z_][a-zA-Z0-9_]*\s*,\s*(plural|select|selectordinal)\s*,',
);

/// Placeholders and markup found in a text.
class Placeholders {
  /// Creates the placeholder inventory of a text.
  const Placeholders({
    required this.arguments,
    required this.directives,
    required this.branchArguments,
    required this.tags,
  });

  /// Names of every ICU argument, at any nesting depth: `{name}` -> `name`.
  ///
  /// A set rather than a multiset: the number of times a placeholder occurs
  /// legitimately differs between languages, because plural categories do —
  /// English has two, Russian has four, Japanese has one.
  final Set<String> arguments;

  /// Arguments carrying a `plural` / `select` directive. Tracked separately so
  /// that a translation which flattened the directive into plain text — losing
  /// the pluralization while keeping the argument name — is still rejected.
  final Set<String> directives;

  /// Arguments used *inside* the branches of a directive, unioned over the
  /// branches. `{value, plural, one{{value} year} other{{value} years}}` uses
  /// `value` both as the plural argument and inside its branches; a
  /// translation that keeps the directive but drops the number from the
  /// branches ("лет" instead of "5 лет") is caught only by this set.
  final Set<String> branchArguments;

  /// Markup tags, sorted, compared as a multiset.
  final List<String> tags;
}

/// Extract the ICU placeholders and markup tags of [text].
///
/// The scanner matches braces by depth instead of using a regular expression:
/// `{count, plural, one {# message} other {# messages}}` is ONE placeholder
/// named `count` whose branch bodies are translatable text — a naive
/// `\{[^{}]*\}` pattern would instead report the branches themselves and
/// reject every correct translation of a plural.
Placeholders extractPlaceholders(String text) {
  final arguments = <String>{};
  final directives = <String>{};
  final branchArguments = <String>{};

  void scan(String source, {required bool inBranch}) {
    var i = 0;
    while (i < source.length) {
      if (source.codeUnitAt(i) != 0x7B /* { */) {
        i++;
        continue;
      }
      // Find the brace matching the one at [i].
      var depth = 0;
      var j = i;
      for (; j < source.length; j++) {
        final char = source.codeUnitAt(j);
        if (char == 0x7B /* { */) {
          depth++;
        } else if (char == 0x7D /* } */) {
          depth--;
          if (depth == 0) break;
        }
      }
      if (j >= source.length) break; // Unbalanced: nothing more to trust here.

      final inner = source.substring(i + 1, j);
      final argument = _argument.firstMatch(inner);
      final isDirective = _directive.hasMatch(inner);
      if (argument != null) {
        final name = argument.group(1)!;
        arguments.add(name);
        if (isDirective) directives.add(name);
        if (inBranch) branchArguments.add(name);
      }
      // Branch bodies may hold placeholders of their own.
      scan(inner, inBranch: inBranch || isDirective);
      i = j + 1;
    }
  }

  scan(text, inBranch: false);

  return Placeholders(
    arguments: arguments,
    directives: directives,
    branchArguments: branchArguments,
    tags: _tag.allMatches(text).map((m) => m.group(0)!).toList()..sort(),
  );
}

/// Whether every brace in [text] is matched.
bool _hasBalancedBraces(String text) {
  var depth = 0;
  for (var i = 0; i < text.length; i++) {
    final char = text.codeUnitAt(i);
    if (char == 0x7B /* { */) {
      depth++;
    } else if (char == 0x7D /* } */) {
      depth--;
      if (depth < 0) return false;
    }
  }
  return depth == 0;
}

/// Upper bound on how much longer a translation may be than its source before
/// we treat it as model rambling rather than a translation.
///
/// Scripts differ in density, so the factor is deliberately generous and only
/// catches runaway output (the "билиберда" case), not verbose languages.
const int kMaxTranslationLengthFactor = 8;

/// Minimal allowed length budget, so short sources such as "OK" do not trip
/// the length guard.
const int kMinTranslationLengthBudget = 160;

/// Validates a single [translation] against its English [source].
///
/// Returns `null` when the translation looks sane, or a human-readable reason
/// why it must be rejected. A rejected translation is retried on its own
/// instead of being written to the sheet.
String? validateTranslation({
  required String source,
  required String? translation,
}) {
  if (translation == null) return 'missing in response';
  final text = translation.trim();
  if (text.isEmpty) return 'empty text';

  // Model leaked its wrapper instead of translating.
  if (text.contains('```')) return 'markdown fence in text';

  // Runaway generation: the model got stuck and kept writing.
  final budget = (source.length * kMaxTranslationLengthFactor)
      .clamp(kMinTranslationLengthBudget, 1 << 20);
  if (text.length > budget)
    return 'suspiciously long (${text.length} chars for a '
        '${source.length}-char source)';

  // Unicode replacement character means the payload is already corrupted.
  if (text.contains('�')) return 'contains replacement characters';

  if (_hasBalancedBraces(source) && !_hasBalancedBraces(text))
    return 'unbalanced braces in text';

  // Placeholders must survive translation. A valid ICU source is read by the
  // parser of `generate` (in `{g, select, male{He} other{They}}` the `{He}`
  // is branch text, not a placeholder named `He`), anything else by the
  // brace scanner.
  final Placeholders expected;
  final Placeholders actual;
  final sourceAst = _tryParse(() => parseIcu(source));
  if (sourceAst != null) {
    final textAst = _tryParse(() => parseIcu(text));
    if (textAst == null)
      return validateSyntax(source: source, translation: text);
    expected = _placeholdersOf(sourceAst, source);
    actual = _placeholdersOf(textAst, text);
  } else {
    expected = extractPlaceholders(source);
    actual = extractPlaceholders(text);
  }

  final missing = expected.arguments.difference(actual.arguments);
  final extra = actual.arguments.difference(expected.arguments);
  if (missing.isNotEmpty || extra.isNotEmpty)
    return 'placeholder mismatch: '
        'missing ${missing.toList()..sort()}, '
        'unexpected ${extra.toList()..sort()}';

  final lost = expected.directives.difference(actual.directives);
  if (lost.isNotEmpty) return 'lost ICU directive for ${lost.toList()..sort()}';

  final droppedInBranch =
      expected.branchArguments.difference(actual.branchArguments);
  if (droppedInBranch.isNotEmpty)
    return 'placeholder dropped inside a plural/select branch: '
        '${droppedInBranch.toList()..sort()}';

  if (expected.tags.join(' ') != actual.tags.join(' '))
    return 'markup mismatch: expected ${expected.tags}, got ${actual.tags}';

  return validateSyntax(source: source, translation: text);
}

/// Checks [translation] with the parsers of `generate`, so that `localize`
/// never writes a text `generate` rejects.
///
/// `localize` does not know which sheets are mustache sheets, so the syntax
/// is inferred from the [source]:
///
/// * a source that is a valid ICU message (the gen-l10n subset) makes an ICU
///   sheet: the translation must parse as ICU too (no `{n, number}`, `=5`,
///   `selectordinal`, ...) and use the same placeholders the same way (an
///   argument stays an argument, a plural count stays a plural count);
/// * a source that is not valid ICU but has mustache placeholders
///   (`{{name}}`) makes a mustache sheet: the translation must parse as
///   mustache, have the same `{{name}}` set, and must not turn one of them
///   into an ICU-style `{name}`;
/// * a source that is neither (`generate` rejects it in any sheet) gets no
///   further check.
///
/// Returns `null` when the translation is acceptable, or the reason why not.
String? validateSyntax({required String source, required String translation}) {
  final icu = _tryParse(() => parseIcu(source));
  if (icu != null) {
    final IcuMessage parsed;
    try {
      parsed = parseIcu(translation);
    } on IcuSyntaxException catch (e) {
      return 'not a valid ICU message: ${e.message} at offset ${e.offset}';
    }
    final expected = _uses(icu);
    final actual = _uses(parsed);
    if (expected.length != actual.length || !expected.containsAll(actual))
      return 'placeholder usage mismatch: expected '
          '${expected.toList()..sort()}, got ${actual.toList()..sort()}';
    return null;
  }

  if (!looksLikeMustache(source)) return null;
  final mustache = _tryParse(() => parseMustache(source));
  if (mustache == null) return null;
  final IcuMessage parsed;
  try {
    parsed = parseMustache(translation);
  } on IcuSyntaxException catch (e) {
    return 'not a valid mustache message: ${e.message} at offset ${e.offset}';
  }
  final expected = mustache.placeholderNames.toSet();
  final actual = parsed.placeholderNames.toSet();
  if (expected.length != actual.length || !expected.containsAll(actual))
    return 'mustache placeholder mismatch: expected '
        '${expected.toList()..sort()}, got ${actual.toList()..sort()}';
  for (final name in expected) {
    final single =
        RegExp('(?<!\\{)\\{\\s*${RegExp.escape(name)}\\s*\\}(?!\\})');
    if (single.hasMatch(translation))
      return 'mustache placeholder {{$name}} turned into {$name}';
  }
  return null;
}

IcuMessage? _tryParse(IcuMessage Function() parse) {
  try {
    return parse();
  } on IcuSyntaxException {
    return null;
  }
}

/// The [Placeholders] of a parsed ICU [message] whose source is [text].
Placeholders _placeholdersOf(IcuMessage message, String text) {
  final uses = message.placeholderUses;
  final branchArguments = <String>{};
  for (final node in message.allNodes) {
    final branches = switch (node) {
      IcuPlural(:final branches) => [for (final b in branches) b.message],
      IcuSelect(:final branches) => [for (final b in branches) b.message],
      IcuText() || IcuArgument() => const <IcuMessage>[],
    };
    for (final branch in branches) {
      branchArguments.addAll(branch.placeholderNames);
    }
  }
  return Placeholders(
    arguments: {for (final use in uses) use.name},
    directives: {
      for (final use in uses)
        if (use.usage != IcuPlaceholderUsage.argument) use.name,
    },
    branchArguments: branchArguments,
    tags: _tag.allMatches(text).map((m) => m.group(0)!).toList()..sort(),
  );
}

/// `name` for an argument, `name (plural)` / `name (select)` otherwise.
Set<String> _uses(IcuMessage message) => {
      for (final use in message.placeholderUses)
        switch (use.usage) {
          IcuPlaceholderUsage.argument => use.name,
          IcuPlaceholderUsage.plural => '${use.name} (plural)',
          IcuPlaceholderUsage.select => '${use.name} (select)',
        },
    };
