/// Parser of the ICU MessageFormat subset of Flutter's gen-l10n.
///
/// The lexer mirrors gen-l10n's `Parser.lexIntoTokens`
/// (`flutter_tools/lib/src/localizations/message_parser.dart`) with
/// `useEscaping: false` and no relaxed syntax, which are gen-l10n's
/// defaults:
///
/// * Outside braces everything except `{` and `}` is literal text —
///   apostrophes, `#`, `<tags>` included.
/// * Inside braces whitespace is insignificant; tokens are numbers
///   (`[0-9]+`), `,`, `=`, `:` and words (`[a-zA-Z0-9|_]+`). A word right
///   after `{` is always a placeholder name; elsewhere `plural`, `select`,
///   `other`, `date` and `time` are keywords.
///
/// The grammar and the extra checks mirror gen-l10n's parser and code
/// generator: plurals and selects need an `other` case, plural keywords are
/// limited to `zero one two few many other`, exact plural cases to `=0 =1
/// =2` (gen-l10n's `pluralCases`). Where gen-l10n silently accepts broken
/// input, this parser reports an error instead:
///
/// * a `}` outside any argument (gen-l10n silently drops the rest of the
///   message);
/// * a placeholder name containing `|` (gen-l10n generates uncompilable
///   Dart).
///
/// Not supported (errors): `selectordinal`, `offset:`, `number` / `date` /
/// `time` argument formats, escaping with apostrophes.
library;

import '../cldr/plural_rules.dart';
import 'ast.dart';

/// Kind of ICU syntax problem.
enum IcuErrorKind {
  /// Malformed syntax.
  syntax,

  /// A plural or select without an `other` case.
  missingOther,

  /// Valid ICU, but outside the supported subset.
  unsupported,
}

/// An ICU message that cannot be parsed.
final class IcuSyntaxException implements Exception {
  /// Creates an exception at [offset] of [source].
  const IcuSyntaxException(
    this.message,
    this.source,
    this.offset, {
    this.kind = IcuErrorKind.syntax,
  });

  /// What is wrong.
  final String message;

  /// The message source.
  final String source;

  /// 0-based offset of the problem in [source].
  final int offset;

  /// Classification of the problem.
  final IcuErrorKind kind;

  /// The source line with a caret under [offset], for display.
  String get excerpt {
    final at = offset.clamp(0, source.length);
    final lineStart = source.lastIndexOf('\n', at == 0 ? 0 : at - 1) + 1;
    var lineEnd = source.indexOf('\n', at);
    if (lineEnd < 0) lineEnd = source.length;
    final line = source.substring(lineStart, lineEnd);
    return '$line\n${' ' * (at - lineStart)}^';
  }

  @override
  String toString() => 'IcuSyntaxException: $message (at offset $offset)';
}

/// Parses [source] into an [IcuMessage].
///
/// Throws an [IcuSyntaxException] when [source] is not in the supported
/// subset.
IcuMessage parseIcu(String source) => _Parser(source).parse();

/// Like [parseIcu], but returns `null` instead of throwing.
IcuMessage? tryParseIcu(String source) {
  try {
    return parseIcu(source);
  } on IcuSyntaxException {
    return null;
  }
}

enum _T {
  text,
  open,
  close,
  comma,
  equal,
  colon,
  number,
  word,
  plural,
  select,
  other,
  date,
  time,
}

final class _Token {
  const _Token(this.type, this.value, this.start);
  final _T type;
  final String value;
  final int start;
  int get end => start + value.length;
}

final RegExp _text = RegExp(r'[^{}]+');
final RegExp _whitespace = RegExp(r'\s+');
final RegExp _number = RegExp('[0-9]+');
final RegExp _word = RegExp(r'[a-zA-Z0-9|_]+');
final RegExp _validName = RegExp(r'^[a-zA-Z_][a-zA-Z0-9_]*$');

const _pluralKeywords = {
  'zero': PluralCategory.zero,
  'one': PluralCategory.one,
  'two': PluralCategory.two,
  'few': PluralCategory.few,
  'many': PluralCategory.many,
};

const _exactCases = {
  '0': PluralCategory.zero,
  '1': PluralCategory.one,
  '2': PluralCategory.two,
};

final class _Parser {
  _Parser(this.source);

  final String source;
  late final List<_Token> _tokens = _lex();
  int _index = 0;

  Never _fail(
    String message,
    int offset, [
    IcuErrorKind kind = IcuErrorKind.syntax,
  ]) =>
      throw IcuSyntaxException(message, source, offset, kind: kind);

  // Lexer: a transcription of gen-l10n's lexIntoTokens (useEscaping: false,
  // placeholders: null).
  List<_Token> _lex() {
    final tokens = <_Token>[];
    var isString = true;
    var index = 0;
    while (index < source.length) {
      if (isString) {
        final text = _text.matchAsPrefix(source, index);
        if (text != null) {
          tokens.add(_Token(_T.text, text.group(0)!, index));
          index = text.end;
          continue;
        }
        // Only `{` or `}` can be here.
        final brace = source[index];
        tokens.add(_Token(brace == '{' ? _T.open : _T.close, brace, index));
        isString = false;
        index++;
        continue;
      }
      final space = _whitespace.matchAsPrefix(source, index);
      if (space != null) {
        index = space.end;
        continue;
      }
      final number = _number.matchAsPrefix(source, index);
      if (number != null) {
        tokens.add(_Token(_T.number, number.group(0)!, index));
        index = number.end;
        continue;
      }
      final char = source[index];
      switch (char) {
        case ',':
          tokens.add(_Token(_T.comma, char, index));
          index++;
          continue;
        case '=':
          tokens.add(_Token(_T.equal, char, index));
          index++;
          continue;
        case ':':
          tokens.add(_Token(_T.colon, char, index));
          index++;
          continue;
        case '{' || '}':
          tokens.add(_Token(char == '{' ? _T.open : _T.close, char, index));
          isString = true;
          index++;
          continue;
      }
      final word = _word.matchAsPrefix(source, index);
      if (word == null) {
        _fail('Unexpected character "$char"', index);
      }
      final value = word.group(0)!;
      final afterBrace = tokens.isNotEmpty && tokens.last.type == _T.open;
      final type = afterBrace
          ? _T.word
          : switch (value) {
              'plural' => _T.plural,
              'select' => _T.select,
              'other' => _T.other,
              'date' => _T.date,
              'time' => _T.time,
              _ => _T.word,
            };
      tokens.add(_Token(type, value, index));
      index = word.end;
    }
    return tokens;
  }

  _Token? get _peek => _index < _tokens.length ? _tokens[_index] : null;

  _Token? _peekAt(int ahead) =>
      _index + ahead < _tokens.length ? _tokens[_index + ahead] : null;

  _Token _expect(_T type, String what) {
    final token = _peek;
    if (token == null) {
      _fail('Expected $what but the message ended', source.length);
    }
    if (token.type != type) {
      _fail('Expected $what but found "${token.value}"', token.start);
    }
    _index++;
    return token;
  }

  IcuMessage parse() {
    final message = _message(0);
    final rest = _peek;
    if (rest != null) {
      // gen-l10n stops at the first unmatched "}" and silently drops the
      // remainder of the message; we refuse to lose text.
      _fail('Unmatched "}"', rest.start);
    }
    return message;
  }

  /// message := (text | placeholder | plural | select)*
  /// Stops at the end of input or at a "}" (left for the caller).
  IcuMessage _message(int start) {
    final parts = <IcuNode>[];
    while (true) {
      final token = _peek;
      if (token == null || token.type == _T.close) break;
      if (token.type == _T.text) {
        _index++;
        parts.add(IcuText(token.value, token.start, token.end));
        continue;
      }
      // An open brace: the lexer produces nothing else in string mode.
      parts.add(_argument());
    }
    final end = _peek?.start ?? source.length;
    return IcuMessage(parts, parts.isEmpty ? start : parts.first.start, end);
  }

  IcuNode _argument() {
    final open = _expect(_T.open, '"{"');
    final name = _peek;
    if (name == null) {
      _fail('Expected a placeholder name but the message ended', source.length);
    }
    if (name.type != _T.word) {
      _fail(
        'Expected a placeholder name but found "${name.value}"',
        name.start,
      );
    }
    if (!_validName.hasMatch(name.value)) {
      _fail('Invalid placeholder name "${name.value}"', name.start);
    }
    _index++;
    final next = _peek;
    if (next == null) {
      _fail('Expected "}" but the message ended', source.length);
    }
    if (next.type == _T.close) {
      _index++;
      return IcuArgument(name.value, open.start, next.end);
    }
    if (next.type != _T.comma) {
      _fail('Expected "}" but found "${next.value}"', next.start);
    }
    final kind = _peekAt(1);
    switch (kind?.type) {
      case _T.plural:
        _index += 2;
        return _plural(open, name.value);
      case _T.select:
        _index += 2;
        return _select(open, name.value);
      case _T.date || _T.time:
        _fail(
          '"${kind!.value}" arguments are not supported; '
          'pass a preformatted String placeholder instead',
          kind.start,
          IcuErrorKind.unsupported,
        );
      case _T.word when kind!.value == 'selectordinal':
        _fail(
          '"selectordinal" is not supported by gen-l10n',
          kind.start,
          IcuErrorKind.unsupported,
        );
      case _T.word when kind!.value == 'number':
        _fail(
          '"number" arguments are not supported; '
          'pass a preformatted String placeholder instead',
          kind.start,
          IcuErrorKind.unsupported,
        );
      case _:
        _fail('Expected "}" but found ","', next.start);
    }
  }

  IcuPlural _plural(_Token open, String argument) {
    final comma = _peek;
    if (comma != null &&
        comma.type == _T.comma &&
        _peekAt(1)?.type == _T.word &&
        _peekAt(1)!.value == 'offset') {
      _fail(
        '"offset" is not supported by gen-l10n',
        _peekAt(1)!.start,
        IcuErrorKind.unsupported,
      );
    }
    _expect(_T.comma, '","');
    final branches = <IcuPluralBranch>[];
    while (true) {
      final token = _peek;
      if (token == null) break;
      if (token.type == _T.number) {
        _fail(
          'Plural case "${token.value}" needs an "=" ("=${token.value}")',
          token.start,
        );
      }
      if (token.type != _T.word &&
          token.type != _T.other &&
          token.type != _T.equal) {
        break;
      }
      final String selector;
      final IcuPluralSelectorKind kind;
      final PluralCategory category;
      switch (token.type) {
        case _T.word:
          if (token.value == 'offset' && _peekAt(1)?.type == _T.colon) {
            _fail(
              '"offset" is not supported by gen-l10n',
              token.start,
              IcuErrorKind.unsupported,
            );
          }
          final keyword = _pluralKeywords[token.value];
          if (keyword == null) {
            _fail(
              'Plural case must be one of "zero", "one", "two", "few", '
              '"many", "other", "=0", "=1" or "=2", found "${token.value}"',
              token.start,
            );
          }
          _index++;
          selector = token.value;
          kind = IcuPluralSelectorKind.keyword;
          category = keyword;
        case _T.other:
          _index++;
          selector = 'other';
          kind = IcuPluralSelectorKind.keyword;
          category = PluralCategory.other;
        default: // _T.equal
          _index++;
          final number = _expect(_T.number, 'a number after "="');
          final exact = _exactCases[number.value];
          if (exact == null) {
            _fail(
              'Exact plural case "=${number.value}" is not supported; '
              'gen-l10n only accepts "=0", "=1" and "=2"',
              token.start,
              IcuErrorKind.unsupported,
            );
          }
          selector = '=${number.value}';
          kind = IcuPluralSelectorKind.exact;
          category = exact;
      }
      final open = _expect(_T.open, '"{"');
      final message = _message(open.end);
      _expect(_T.close, '"}"');
      branches.add(IcuPluralBranch(
        selector: selector,
        kind: kind,
        category: category,
        message: message,
        start: token.start,
      ));
    }
    final close = _expect(_T.close, '"}"');
    if (!branches.any((b) => b.selector == 'other')) {
      _fail(
        'Plural must have an "other" case',
        open.start,
        IcuErrorKind.missingOther,
      );
    }
    return IcuPlural(argument, branches, open.start, close.end);
  }

  IcuSelect _select(_Token open, String argument) {
    _expect(_T.comma, '","');
    final branches = <IcuSelectBranch>[];
    while (true) {
      final token = _peek;
      if (token == null ||
          (token.type != _T.word &&
              token.type != _T.number &&
              token.type != _T.other)) {
        break;
      }
      _index++;
      final open = _expect(_T.open, '"{"');
      final message = _message(open.end);
      _expect(_T.close, '"}"');
      branches.add(IcuSelectBranch(
        value: token.value,
        message: message,
        start: token.start,
      ));
    }
    final close = _expect(_T.close, '"}"');
    if (!branches.any((b) => b.value == 'other')) {
      _fail(
        'Select must have an "other" case',
        open.start,
        IcuErrorKind.missingOther,
      );
    }
    return IcuSelect(argument, branches, open.start, close.end);
  }
}
