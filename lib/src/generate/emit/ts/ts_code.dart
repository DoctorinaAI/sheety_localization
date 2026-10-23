/// Helpers that turn values into TypeScript source text: string literals,
/// property keys and doc comments.
library;

final RegExp _identifier = RegExp(r'^[A-Za-z_$][A-Za-z0-9_$]*$');

/// Whether [name] can be written as a bare property key / identifier name.
bool isTsIdentifierName(String name) => _identifier.hasMatch(name);

/// A single-quoted JavaScript string literal with the exact value [value].
///
/// Escapes `\`, `'`, every control character, U+2028/U+2029 (line
/// terminators), U+FEFF and lone surrogates; everything else (including any
/// well-formed non-ASCII text) is kept verbatim, so the generated files stay
/// readable.
String tsString(String value) => "'${_escape(value, "'")}'";

/// The body (without the backticks) of a template literal whose cooked value
/// is [value]: like [tsString], but escapes `` ` `` and every `$` instead of
/// `'`.
String tsTemplateText(String value) => _escape(value, '`');

String _escape(String value, String quote) {
  final out = StringBuffer();
  final units = value.codeUnits;
  for (var k = 0; k < units.length; k++) {
    final c = units[k];
    switch (c) {
      case 0x5C: // \
        out.write(r'\\');
      case 0x0A:
        out.write(r'\n');
      case 0x0D:
        out.write(r'\r');
      case 0x09:
        out.write(r'\t');
      case 0x08:
        out.write(r'\b');
      case 0x0C:
        out.write(r'\f');
      case 0x27 when quote == "'": // '
        out.write(r"\'");
      case 0x60 when quote == '`': // `
        out.write(r'\`');
      case 0x24 when quote == '`': // $
        out.write(r'\$');
      case 0x2028 || 0x2029 || 0xFEFF:
        out.write(_unicodeEscape(c));
      default:
        if (c < 0x20 || c == 0x7F) {
          out.write(r'\x');
          out.write(c.toRadixString(16).toUpperCase().padLeft(2, '0'));
        } else if (c >= 0xD800 && c <= 0xDBFF) {
          final next = k + 1 < units.length ? units[k + 1] : 0;
          if (next >= 0xDC00 && next <= 0xDFFF) {
            out.writeCharCode(c);
            out.writeCharCode(next);
            k++;
          } else {
            out.write(_unicodeEscape(c));
          }
        } else if (c >= 0xDC00 && c <= 0xDFFF) {
          out.write(_unicodeEscape(c)); // a low surrogate without a high one
        } else {
          out.writeCharCode(c);
        }
    }
  }
  return out.toString();
}

String _unicodeEscape(int unit) =>
    r'\u' + unit.toRadixString(16).toUpperCase().padLeft(4, '0');

/// [name] as an object-literal property key: bare when it is an identifier
/// name, otherwise a string literal. `__proto__` is written as a computed key
/// (`['__proto__']`) because the literal form would set the prototype
/// instead of defining a property.
String tsPropertyKey(String name) {
  if (name == '__proto__') return "['__proto__']";
  return isTsIdentifierName(name) ? name : tsString(name);
}

/// [text] made safe for a `/** ... */` comment: no `*/`, line breaks
/// normalized to `\n`, and control characters, U+2028/U+2029, U+FEFF and
/// lone surrogates shown as escapes (` `) so the file stays valid,
/// well-formed UTF-8.
String tsCommentText(String text) {
  final normalized = text
      .replaceAll('*/', r'*\/')
      .replaceAll('\r\n', '\n')
      .replaceAll('\r', '\n');
  final out = StringBuffer();
  final units = normalized.codeUnits;
  for (var k = 0; k < units.length; k++) {
    final c = units[k];
    final next = k + 1 < units.length ? units[k + 1] : 0;
    if (c >= 0xD800 && c <= 0xDBFF && next >= 0xDC00 && next <= 0xDFFF) {
      out
        ..writeCharCode(c)
        ..writeCharCode(next);
      k++;
    } else if (c >= 0xD800 && c <= 0xDFFF) {
      out.writeCharCode(0xFFFD);
    } else if ((c < 0x20 && c != 0x0A && c != 0x09) ||
        c == 0x7F ||
        c == 0x2028 ||
        c == 0x2029 ||
        c == 0xFEFF) {
      out.write(_unicodeEscape(c));
    } else {
      out.writeCharCode(c);
    }
  }
  return out.toString();
}

/// A JSDoc block indented by [indent], one ` * ` line per line of [lines]
/// (each may contain `\n`). Empty when there are no lines.
String tsDocComment(List<String> lines, {String indent = ''}) {
  final all = [
    for (final line in lines) ...tsCommentText(line).split('\n'),
  ];
  while (all.isNotEmpty && all.last.trim().isEmpty) {
    all.removeLast();
  }
  if (all.isEmpty) return '';
  final out = StringBuffer('$indent/**\n');
  for (final line in all) {
    out.write(line.isEmpty ? '$indent *\n' : '$indent * $line\n');
  }
  out.write('$indent */\n');
  return out.toString();
}
