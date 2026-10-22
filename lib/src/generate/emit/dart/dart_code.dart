/// Dart code for message texts, reproducing gen-l10n's `generateString`,
/// `generateReturnExpr` and `_generateMethod` (FT `localizations_utils.dart`
/// and `gen_l10n.dart`).
library;

import '../../icu/ast.dart';
import 'layout.dart';

/// Escapes [value] for a single-quoted Dart string literal, like gen-l10n's
/// `generateString`: `\ $ ' " \n \f \t \r \b` are escaped.
///
/// Difference: the other C0 control characters, DEL and lone surrogates
/// (which gen-l10n copies into the source verbatim) are written as
/// `\u{...}` escapes. The resulting string value is the same.
String dartString(String value) {
  final buffer = StringBuffer();
  for (final unit in value.runes) {
    switch (unit) {
      case 0x5C:
        buffer.write(r'\\');
      case 0x24:
        buffer.write(r'\$');
      case 0x27:
        buffer.write(r"\'");
      case 0x22:
        buffer.write(r'\"');
      case 0x0A:
        buffer.write(r'\n');
      case 0x0C:
        buffer.write(r'\f');
      case 0x09:
        buffer.write(r'\t');
      case 0x0D:
        buffer.write(r'\r');
      case 0x08:
        buffer.write(r'\b');
      case < 0x20 || 0x7F || (>= 0xD800 && <= 0xDFFF):
        buffer.write('\\u{${unit.toRadixString(16)}}');
      default:
        buffer.writeCharCode(unit);
    }
  }
  return buffer.toString();
}

/// [value] as a single-quoted Dart string literal.
String dartQuote(String value) => "'${dartString(value)}'";

final RegExp _alphanumeric = RegExp(r'^([0-9a-zA-Z]|_)+$');

/// gen-l10n's `generateReturnExpr`: concatenates escaped text pieces and
/// `$name` interpolations into one string literal, adding braces where the
/// next character would continue the identifier.
String returnExpression(List<String> expressions) {
  if (expressions.isEmpty) return "''";
  var string = '';
  for (final expression in expressions.reversed) {
    if (expression.isEmpty) continue;
    if (expression[0] != r'$') {
      string = expression + string;
      continue;
    }
    final name = expression.substring(1);
    if (_alphanumeric.hasMatch(name) &&
        !(string.isNotEmpty && _alphanumeric.hasMatch(string[0]))) {
      string = '$expression$string';
    } else {
      string = '\${$name}$string';
    }
  }
  return "'$string'";
}

/// The body of a generated method: temporary variables (plural and select
/// calls) and the returned string expression.
typedef MethodBody = ({List<(String, Code)> temps, String result});

/// Generates the body of a method for [message] exactly as gen-l10n's
/// `_generateMethod` does: a depth-first post-order walk where every plural
/// and select becomes a `String _tempN = intl.Intl.pluralLogic(...)` /
/// `selectLogic(...)` variable. Plural branches are visited in reverse
/// source order and the first one seen per category wins (so the later
/// branch in the source wins); select branches keep source order.
MethodBody methodBody(IcuMessage message) {
  final temps = <(String, Code)>[];
  var counter = 0;

  String visit(IcuMessage message) {
    final expressions = <String>[];
    for (final part in message.parts) {
      switch (part) {
        case IcuText(:final text):
          if (text.isNotEmpty) expressions.add(dartString(text));
        case IcuArgument(:final name):
          expressions.add('\$$name');
        case IcuPlural(:final argument, :final branches):
          final args = <Code>[];
          final seen = <String>{};
          for (final branch in branches.reversed) {
            final category = branch.category.name;
            if (!seen.add(category)) continue;
            args.add(Named(category, Atom(visit(branch.message))));
          }
          final name = '_temp${counter++}';
          temps.add((
            name,
            Group(
                'intl.Intl.pluralLogic(',
                [
                  Atom(argument),
                  const Named('locale', Atom('localeName')),
                  ...args,
                ],
                ')'),
          ));
          expressions.add('\$$name');
        case IcuSelect(:final argument, :final branches):
          final cases = <Code>[
            for (final branch in branches)
              Named("'${branch.value}'", Atom(visit(branch.message))),
          ];
          final name = '_temp${counter++}';
          temps.add((
            name,
            Group(
              'intl.Intl.selectLogic(',
              [Atom(argument), Group('{', cases, '}')],
              ')',
              hugLast: true,
            ),
          ));
          expressions.add('\$$name');
      }
    }
    return returnExpression(expressions);
  }

  final result = visit(message);
  return (temps: temps, result: result);
}

/// The expression of a getter for a plain-text [message]: one string
/// literal with the whole text.
String getterExpression(IcuMessage message) => dartQuote(message.plainText);
