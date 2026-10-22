/// Syntax tree of the ICU MessageFormat subset `generate` supports.
///
/// The subset is exactly what Flutter's gen-l10n accepts with its defaults
/// (`use-escaping: false`, no relaxed syntax): text, `{arg}`,
/// `{n, plural, ...}` and `{x, select, ...}`, nested freely. Apostrophes and
/// `#` are ordinary text.
library;

import '../cldr/plural_rules.dart';

/// A node of a parsed message. [start] and [end] are offsets into the source
/// string (`end` exclusive).
sealed class IcuNode {
  const IcuNode(this.start, this.end);

  /// Offset of the first character of the node.
  final int start;

  /// Offset just past the last character of the node.
  final int end;
}

/// Literal text.
final class IcuText extends IcuNode {
  /// Creates a text node.
  const IcuText(this.text, int start, int end) : super(start, end);

  /// The text, exactly as written (no unescaping happens).
  final String text;

  @override
  String toString() => 'IcuText(${_quote(text)})';
}

/// A simple argument: `{name}`.
final class IcuArgument extends IcuNode {
  /// Creates an argument node.
  const IcuArgument(this.name, int start, int end) : super(start, end);

  /// Placeholder name.
  final String name;

  @override
  String toString() => 'IcuArgument($name)';
}

/// How a plural branch was selected in the source.
enum IcuPluralSelectorKind {
  /// An exact value: `=0`, `=1`, `=2`.
  exact,

  /// A CLDR category keyword: `zero`, `one`, `two`, `few`, `many`, `other`.
  keyword,
}

/// One branch of a plural: `=0{...}` or `few{...}`.
final class IcuPluralBranch {
  /// Creates a branch.
  const IcuPluralBranch({
    required this.selector,
    required this.kind,
    required this.category,
    required this.message,
    required this.start,
  });

  /// The selector as written: `=0`, `one`, `other`.
  final String selector;

  /// Whether the selector is exact (`=1`) or a keyword (`one`).
  final IcuPluralSelectorKind kind;

  /// The category the branch is used for. gen-l10n maps `=0`, `=1` and `=2`
  /// onto `zero`, `one` and `two` (`pluralCases` in `gen_l10n.dart`); other
  /// exact values are rejected by the parser.
  final PluralCategory category;

  /// The branch message.
  final IcuMessage message;

  /// Offset of the selector.
  final int start;

  @override
  String toString() => '$selector$message';
}

/// A plural: `{count, plural, one{...} other{...}}`.
final class IcuPlural extends IcuNode {
  /// Creates a plural node.
  const IcuPlural(this.argument, this.branches, int start, int end)
      : super(start, end);

  /// Name of the numeric placeholder.
  final String argument;

  /// Branches in source order.
  final List<IcuPluralBranch> branches;

  /// The effective branch of every category, as gen-l10n generates the
  /// `Intl.pluralLogic` call: when two branches map onto the same category
  /// (`=1{...}` and `one{...}`) the one written *later* wins.
  ///
  /// Keys are in CLDR order (`zero` ... `other`).
  Map<PluralCategory, IcuMessage> get cases {
    final byCategory = <PluralCategory, IcuMessage>{};
    for (final branch in branches) {
      byCategory[branch.category] = branch.message;
    }
    return {
      for (final category in PluralCategory.values)
        if (byCategory[category] case final IcuMessage message)
          category: message,
    };
  }

  /// Branches overridden by a later branch of the same category.
  List<IcuPluralBranch> get overriddenBranches {
    final seen = <PluralCategory>{};
    final overridden = <IcuPluralBranch>[];
    for (final branch in branches.reversed) {
      if (!seen.add(branch.category)) overridden.add(branch);
    }
    return overridden.reversed.toList();
  }

  @override
  String toString() => 'IcuPlural($argument, ${branches.join(' ')})';
}

/// One branch of a select: `male{...}`.
final class IcuSelectBranch {
  /// Creates a branch.
  const IcuSelectBranch({
    required this.value,
    required this.message,
    required this.start,
  });

  /// The case value as written (`male`, `other`, `1`).
  final String value;

  /// The branch message.
  final IcuMessage message;

  /// Offset of the case value.
  final int start;

  @override
  String toString() => '$value$message';
}

/// A select: `{gender, select, male{...} other{...}}`.
final class IcuSelect extends IcuNode {
  /// Creates a select node.
  const IcuSelect(this.argument, this.branches, int start, int end)
      : super(start, end);

  /// Name of the String placeholder.
  final String argument;

  /// Branches in source order.
  final List<IcuSelectBranch> branches;

  /// Case values that occur more than once.
  List<String> get duplicateValues {
    final seen = <String>{};
    return [
      for (final branch in branches)
        if (!seen.add(branch.value)) branch.value,
    ];
  }

  @override
  String toString() => 'IcuSelect($argument, ${branches.join(' ')})';
}

/// How a placeholder is used in a message.
enum IcuPlaceholderUsage {
  /// `{name}`
  argument,

  /// `{name, plural, ...}`
  plural,

  /// `{name, select, ...}`
  select,
}

/// A use of a placeholder somewhere in a message.
typedef IcuPlaceholderUse = ({
  String name,
  IcuPlaceholderUsage usage,
  int offset,
});

/// A markup tag found in literal text: `<b>`, `</b>` or `<br/>`.
typedef IcuTag = ({String name, bool closing, bool selfClosing, int offset});

/// A message: a sequence of nodes.
final class IcuMessage {
  /// Creates a message.
  const IcuMessage(this.parts, this.start, this.end);

  /// Nodes in source order.
  final List<IcuNode> parts;

  /// Offset of the message start.
  final int start;

  /// Offset just past the message end.
  final int end;

  /// Whether the message is only literal text (or empty).
  bool get isPlainText => parts.every((p) => p is IcuText);

  /// The concatenated literal text of a plain-text message.
  ///
  /// Throws a [StateError] when the message has arguments.
  String get plainText {
    if (!isPlainText) throw StateError('Not a plain text message');
    return parts.map((p) => (p as IcuText).text).join();
  }

  /// Every node of the message and of all nested branch messages, in
  /// depth-first source order.
  Iterable<IcuNode> get allNodes sync* {
    for (final part in parts) {
      yield part;
      switch (part) {
        case IcuPlural(:final branches):
          for (final b in branches) yield* b.message.allNodes;
        case IcuSelect(:final branches):
          for (final b in branches) yield* b.message.allNodes;
        case IcuText() || IcuArgument():
          break;
      }
    }
  }

  /// Every placeholder use, in depth-first source order.
  List<IcuPlaceholderUse> get placeholderUses => [
        for (final node in allNodes)
          switch (node) {
            IcuArgument(:final name) => (
                name: name,
                usage: IcuPlaceholderUsage.argument,
                offset: node.start,
              ),
            IcuPlural(:final argument) => (
                name: argument,
                usage: IcuPlaceholderUsage.plural,
                offset: node.start,
              ),
            IcuSelect(:final argument) => (
                name: argument,
                usage: IcuPlaceholderUsage.select,
                offset: node.start,
              ),
            IcuText() => null,
          },
      ].nonNulls.toList();

  /// Names of the placeholders used, in order of first use.
  List<String> get placeholderNames => {
        for (final use in placeholderUses) use.name,
      }.toList();

  /// Every plural node, at any depth.
  Iterable<IcuPlural> get plurals => allNodes.whereType<IcuPlural>();

  /// Every select node, at any depth.
  Iterable<IcuSelect> get selects => allNodes.whereType<IcuSelect>();

  /// Markup tags in the literal text of this message only (not of nested
  /// branches), in order.
  List<IcuTag> get ownTags => [
        for (final part in parts)
          if (part is IcuText) ...scanTags(part.text, part.start),
      ];

  /// Markup tags of the whole message, nested branches included.
  List<IcuTag> get allTags => [
        for (final node in allNodes)
          if (node is IcuText) ...scanTags(node.text, node.start),
      ];

  @override
  String toString() => '{${parts.join(', ')}}';
}

final RegExp _tag = RegExp(r'<(/?)([A-Za-z][A-Za-z0-9_.\-]*)\s*(/?)>');

/// Finds markup tags (`<b>`, `</b>`, `<br/>`) in [text]; [base] is added to
/// every offset.
List<IcuTag> scanTags(String text, [int base = 0]) => [
      for (final m in _tag.allMatches(text))
        (
          name: m.group(2)!,
          closing: m.group(1)!.isNotEmpty,
          selfClosing: m.group(3)!.isNotEmpty,
          offset: base + m.start,
        ),
    ];

String _quote(String text) =>
    "'${text.replaceAll('\n', r'\n').replaceAll("'", r"\'")}'";
