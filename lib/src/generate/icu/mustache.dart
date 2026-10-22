/// Mustache-style messages (`Hello {{name}}`) and the syntax switch between
/// them and ICU.
///
/// A mustache message parses into the same [IcuMessage] tree as ICU, with
/// `{{name}}` becoming an [IcuArgument], so every consumer of the AST works
/// unchanged. There is no plural or select.
library;

import 'ast.dart';
import 'parser.dart';

/// The message syntax of a scope (sheet).
enum MessageSyntax {
  /// ICU MessageFormat, the gen-l10n subset (`{name}`, plural, select).
  icu,

  /// Mustache-style placeholders: `{{name}}`; everything else is text.
  mustache;

  /// Looks a syntax up by its [name] (`icu`, `mustache`).
  static MessageSyntax? byName(String name) {
    for (final s in values) if (s.name == name) return s;
    return null;
  }
}

/// Parses [source] in [syntax]. Throws an [IcuSyntaxException].
IcuMessage parseMessage(String source, MessageSyntax syntax) =>
    switch (syntax) {
      MessageSyntax.icu => parseIcu(source),
      MessageSyntax.mustache => parseMustache(source),
    };

final RegExp _name = RegExp(r'^[A-Za-z_][A-Za-z0-9_]*$');
final RegExp _dotted = RegExp(r'^[A-Za-z_][A-Za-z0-9_]*(\.[A-Za-z0-9_]+)+$');

/// Parses a mustache-style message.
///
/// * `{{ name }}` — whitespace inside the braces is tolerated; `name` must
///   be an identifier (`[A-Za-z_][A-Za-z0-9_]*`). Dotted names
///   (`{{user.name}}`) are rejected.
/// * Every other character, single `{` and `}` and a lone `}}` included, is
///   literal text.
/// * An unterminated `{{` is an error at its offset.
IcuMessage parseMustache(String source) {
  final parts = <IcuNode>[];
  final text = StringBuffer();
  var textStart = 0;
  var index = 0;

  void flush(int end) {
    if (text.isEmpty) return;
    parts.add(IcuText(text.toString(), textStart, end));
    text.clear();
  }

  while (index < source.length) {
    if (!source.startsWith('{{', index)) {
      if (text.isEmpty) textStart = index;
      text.write(source[index]);
      index++;
      continue;
    }
    final close = source.indexOf('}}', index + 2);
    if (close < 0) {
      throw IcuSyntaxException('Unterminated "{{"', source, index);
    }
    final inner = source.substring(index + 2, close);
    final name = inner.trim();
    if (name.isEmpty) {
      throw IcuSyntaxException('Empty placeholder "{{}}"', source, index);
    }
    final nameOffset = index + 2 + inner.indexOf(name);
    if (_dotted.hasMatch(name)) {
      throw IcuSyntaxException(
        'Dotted placeholder names ("$name") are not supported',
        source,
        nameOffset,
        kind: IcuErrorKind.unsupported,
      );
    }
    if (!_name.hasMatch(name)) {
      throw IcuSyntaxException(
        'Invalid placeholder name "$name"',
        source,
        nameOffset,
      );
    }
    flush(index);
    parts.add(IcuArgument(name, index, close + 2));
    index = close + 2;
  }
  flush(source.length);
  return IcuMessage(parts, 0, source.length);
}

final RegExp _looksLikeMustache =
    RegExp(r'\{\{\s*[A-Za-z_][A-Za-z0-9_.]*\s*\}\}');

/// Whether [source] contains a `{{name}}` placeholder (used to hint that an
/// ICU sheet is probably a mustache one).
bool looksLikeMustache(String source) => _looksLikeMustache.hasMatch(source);
