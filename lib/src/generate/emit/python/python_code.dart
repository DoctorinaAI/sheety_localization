/// Python source helpers: string literals, docstrings and identifiers.
library;

import '../../emitter.dart';
import '../../model.dart';
import '../../naming.dart';

/// A Python string literal (`"..."`) whose value is exactly [value].
///
/// Double quotes (the `black` / `ruff format` default), with `\\`, `\"`,
/// `\n`, `\r`, `\t` and `\x..` / `\u....` escapes for control characters,
/// line and paragraph separators, the byte order mark and lone surrogates.
/// Everything else (non-ASCII letters, emoji, `'`, `$`, `{`, `}`) is kept
/// as is; the file is UTF-8.
String pyString(String value) => '"${_escape(value, quote: '"')}"';

/// The literal part of an f-string: like [pyString] without the quotes,
/// with `{` and `}` doubled.
String pyFStringText(String value) =>
    _escape(value, quote: '"').replaceAll('{', '{{').replaceAll('}', '}}');

/// [value] as the body of a `"""` docstring: backslashes are escaped, a
/// double quote only where it could end the docstring (followed by
/// another one, or last), newlines are kept and every non-empty line after
/// the first is prefixed with [indent]. Lone surrogates become U+FFFD (see
/// `commentText`).
String pyDocText(String value, String indent) {
  final escaped = _escape(commentText(value), quote: '', keepNewlines: true);
  final quoted = StringBuffer();
  for (var i = 0; i < escaped.length; i++) {
    final char = escaped[i];
    final last = i == escaped.length - 1;
    quoted.write(
      char == '"' && (last || escaped[i + 1] == '"') ? r'\"' : char,
    );
  }
  final lines = quoted.toString().split('\n');
  return [
    for (var i = 0; i < lines.length; i++)
      i == 0 || lines[i].trimRight().isEmpty
          ? lines[i].trimRight()
          : '$indent${lines[i].trimRight()}',
  ].join('\n');
}

String _escape(String value,
    {required String quote, bool keepNewlines = false}) {
  final out = StringBuffer();
  final units = value.codeUnits;
  for (var index = 0; index < units.length; index++) {
    final unit = units[index];
    if (unit >= 0xD800 && unit <= 0xDBFF) {
      final next = index + 1 < units.length ? units[index + 1] : -1;
      if (next >= 0xDC00 && next <= 0xDFFF) {
        out.writeCharCode(unit);
        out.writeCharCode(next);
        index++;
      } else {
        out.write(_hex(unit));
      }
      continue;
    }
    if (unit >= 0xDC00 && unit <= 0xDFFF) {
      out.write(_hex(unit));
      continue;
    }
    switch (unit) {
      case 0x5C:
        out.write(r'\\');
      case 0x0A:
        out.write(keepNewlines ? '\n' : r'\n');
      case 0x0D:
        out.write(r'\r');
      case 0x09:
        out.write(r'\t');
      default:
        if (quote.isNotEmpty && String.fromCharCode(unit) == quote) {
          out.write('\\$quote');
        } else if (unit < 0x20 ||
            (unit >= 0x7F && unit <= 0x9F) ||
            unit == 0x2028 ||
            unit == 0x2029 ||
            unit == 0xFEFF) {
          out.write(_hex(unit));
        } else {
          out.writeCharCode(unit);
        }
    }
  }
  return out.toString();
}

String _hex(int unit) => unit <= 0xFF
    ? '\\x${unit.toRadixString(16).padLeft(2, '0')}'
    : '\\u${unit.toRadixString(16).padLeft(4, '0')}';

/// The Python attribute (property or method) of a message key:
/// snake_case, see [toSnakeCase] (`drawerTooltipHelp` ->
/// `drawer_tooltip_help`, `getHTTPError` -> `get_http_error`).
String pyMessageName(String key) =>
    targetName(Target.python, IdentifierRole.message, key);

/// The Python keyword parameter of a placeholder (snake_case).
String pyParameterName(String placeholder) =>
    targetName(Target.python, IdentifierRole.parameter, placeholder);

/// The module of a locale inside a scope package: `_pt_BR`.
String pyLocaleModule(LocaleTag locale) => '_${locale.code}';

/// The Python annotation of a placeholder type.
String pyType(PlaceholderType type) => switch (type) {
      PlaceholderType.string => 'str',
      PlaceholderType.int => 'int',
      PlaceholderType.num || PlaceholderType.double => 'float',
      PlaceholderType.object => 'object',
    };

/// A `tuple` literal of strings, with the trailing comma a 1-tuple needs.
String pyStringTuple(Iterable<String> values) {
  final items = [for (final v in values) pyString(v)];
  if (items.isEmpty) return '()';
  if (items.length == 1) return '(${items.single},)';
  return '(${items.join(', ')})';
}
