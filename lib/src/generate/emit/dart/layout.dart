/// A tiny subset of `dart format`'s (tall style) line splitting, enough for
/// the shapes the Dart emitter produces, so its output is already formatted
/// without running the formatter.
library;

/// A piece of Dart code that may be split over several lines.
sealed class Code {
  const Code();

  /// The code on one line.
  String get flat;
}

/// Code that is never split (an identifier, a string literal).
final class Atom extends Code {
  /// Creates an atom.
  const Atom(this.text);

  /// The text.
  final String text;

  @override
  String get flat => text;
}

/// A bracketed, comma separated list: an argument list, a collection
/// literal, a parameter list. Split as one item per line with a trailing
/// comma.
final class Group extends Code {
  /// Creates a group.
  const Group(this.open, this.items, this.close, {this.hugLast = false});

  /// Text up to and including the opening bracket (`foo(`, `<int>[`).
  final String open;

  /// The items.
  final List<Code> items;

  /// The closing bracket and whatever follows it (`)`, `].contains(x)`).
  final String close;

  /// Whether a trailing collection literal is "hugged" when splitting
  /// (`foo(a, {` ... `})`) if everything before it fits on the first line.
  final bool hugLast;

  @override
  String get flat => '$open${items.map((i) => i.flat).join(', ')}$close';
}

/// `name: value` (named argument, map entry).
final class Named extends Code {
  /// Creates a named item.
  const Named(this.name, this.value);

  /// Text before the colon.
  final String name;

  /// The value.
  final Code value;

  @override
  String get flat => '$name: ${value.flat}';
}

/// Lays out [Code] for a page width.
final class Layout {
  /// Creates a layout for [width] columns.
  const Layout(this.width);

  /// The page width.
  final int width;

  String _spaces(int n) => ' ' * n;

  /// Whether [text] starting at [column] fits.
  bool fits(int column, String text) => column + text.length <= width;

  /// Renders [code] starting at [column]; continuation lines are indented
  /// relative to [indent]; [suffix] follows the code on its last line.
  String render(
    Code code, {
    required int indent,
    required int column,
    String suffix = '',
  }) {
    final flat = code.flat;
    if (fits(column, '$flat$suffix')) return '$flat$suffix';
    switch (code) {
      case Atom():
        return '$flat$suffix';
      case Group():
        return split(code, indent: indent, column: column, suffix: suffix);
      case Named(:final name, :final value):
        if (value is Group && value.items.isNotEmpty) {
          return '$name: ${split(
            value,
            indent: indent,
            column: column + name.length + 2,
            suffix: suffix,
          )}';
        }
        // Broken after the colon only when that makes the value fit.
        if (!fits(indent + 4, '${value.flat}$suffix')) return '$flat$suffix';
        return '$name:\n${_spaces(indent + 4)}${value.flat}$suffix';
    }
  }

  /// Renders [group] split over several lines.
  String split(
    Group group, {
    required int indent,
    required int column,
    String suffix = '',
  }) {
    if (group.items.isEmpty) return '${group.flat}$suffix';
    final last = group.items.last;
    if (group.hugLast && last is Group && last.items.isNotEmpty) {
      final leading = [
        for (final item in group.items.take(group.items.length - 1)) item.flat,
      ].join(', ');
      final head = '${group.open}$leading${leading.isEmpty ? '' : ', '}'
          '${last.open}';
      if (fits(column, head)) {
        return '$head\n${_items(last.items, indent)}'
            '${_spaces(indent)}${last.close}${group.close}$suffix';
      }
    }
    return '${group.open}\n${_items(group.items, indent)}'
        '${_spaces(indent)}${group.close}$suffix';
  }

  String _item(Code item, int indent) =>
      render(item, indent: indent, column: indent, suffix: ',');

  String _items(List<Code> items, int indent) => [
        for (final item in items)
          '${_spaces(indent + 2)}${_item(item, indent + 2)}\n',
      ].join();

  /// `lhs = rhs;` at [indent] (a variable declaration or assignment).
  String assignment(String lhs, Code rhs, {required int indent}) {
    final flat = '$lhs = ${rhs.flat};';
    if (fits(indent, flat)) return '${_spaces(indent)}$flat';
    if (rhs is Group && rhs.items.isNotEmpty) {
      if (fits(indent, '$lhs = ${rhs.open}')) {
        final column = indent + lhs.length + 3;
        final value = split(rhs, indent: indent, column: column, suffix: ';');
        return '${_spaces(indent)}$lhs = $value';
      }
      final next = indent + 4;
      final value = render(rhs, indent: next, column: next, suffix: ';');
      return '${_spaces(indent)}$lhs =\n${_spaces(next)}$value';
    }
    return '${_spaces(indent)}$lhs =\n${_spaces(indent + 4)}${rhs.flat};';
  }

  /// `head => body;` at [indent] (an expression-bodied member); [end] is
  /// `;` for a member and `,` for a switch-expression case, whose broken
  /// body is indented by [continuation] 2 instead of 4.
  String arrow(
    String head,
    Code body, {
    required int indent,
    String end = ';',
    int continuation = 4,
  }) {
    final pad = _spaces(indent);
    final flat = '$head => ${body.flat}$end';
    if (fits(indent, flat)) return '$pad$flat';
    final next = indent + continuation;
    if (body is Group && body.items.isNotEmpty) {
      final isCase = continuation != 4;
      String hug() {
        final column = indent + head.length + 4;
        return '$pad$head => '
            '${split(body, indent: indent, column: column, suffix: end)}';
      }

      String broken() => '$pad$head =>\n${_spaces(next)}'
          '${render(body, indent: next, column: next, suffix: end)}';
      // A switch case and a plain collection literal hug the body when its
      // opening fits; other members prefer the whole body on the next line.
      if (isCase || body.close.length == 1) {
        return fits(indent, '$head => ${body.open}') ? hug() : broken();
      }
      if (fits(next, '${body.flat}$end')) return broken();
      return hug();
    }
    return '$pad$head =>\n${_spaces(next)}${body.flat}$end';
  }

  /// A statement or declaration that is a single [Code] followed by
  /// [suffix], at [indent] (`return foo(a, b);`, `String name(a, b) {`).
  String statement(Code code, {required int indent, String suffix = ''}) =>
      '${_spaces(indent)}'
      '${render(code, indent: indent, column: indent, suffix: suffix)}';
}
