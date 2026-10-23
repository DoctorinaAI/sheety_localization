import 'package:test/test.dart';

import '../sheety.dart';

/// Compact structural dump of a message.
String dump(IcuMessage message) => message.parts.map(_node).join();

String _node(IcuNode node) => switch (node) {
      IcuText(:final text) => 'T($text)',
      IcuArgument(:final name) => 'A($name)',
      IcuPlural(:final argument, :final branches) =>
        'P($argument;${branches.map(_plural).join()})',
      IcuSelect(:final argument, :final branches) =>
        'S($argument;${branches.map(_select).join()})',
    };

String _plural(IcuPluralBranch b) => '${b.selector}[${dump(b.message)}]';

String _select(IcuSelectBranch b) => '${b.value}[${dump(b.message)}]';

IcuSyntaxException error(String source) {
  try {
    parseIcu(source);
  } on IcuSyntaxException catch (e) {
    return e;
  }
  fail('"$source" parsed');
}

void main() {
  group('accepts what gen-l10n accepts', () {
    final cases = {
      '': '',
      'Hello': 'T(Hello)',
      'a {b} c': 'T(a )A(b)T( c)',
      '{ x }': 'A(x)',
      '{_x}': 'A(_x)',
      '{x}{y}': 'A(x)A(y)',
      // use-escaping is off: apostrophes are literal.
      "it's {x}": "T(it's )A(x)",
      "'{x}'": "T(')A(x)T(')",
      "''": "T('')",
      // `#` is not substituted by gen-l10n.
      '{n, plural, =0{z} one{o} other{# x}}': 'P(n;=0[T(z)]one[T(o)]'
          'other[T(# x)])',
      '{ n , plural , other { a } }': 'P(n;other[T( a )])',
      '{n, plural,other{}}': 'P(n;other[])',
      '{n, plural, = 1 {a} other{b}}': 'P(n;=1[T(a)]other[T(b)])',
      '{n, plural, few {a} many{b} other{c}}':
          'P(n;few[T(a)]many[T(b)]other[T(c)])',
      '{n,select,a{x} 1{y} other{z}}': 'S(n;a[T(x)]1[T(y)]other[T(z)])',
      '{n, select, other{{m, plural, one{x} other{{m} y}}}}':
          'S(n;other[P(m;one[T(x)]other[A(m)T( y)])])',
      '{plural}': 'A(plural)',
      '{other}': 'A(other)',
      '{select, select, other{a}}': 'S(select;other[T(a)])',
      '<b>{x}</b>': 'T(<b>)A(x)T(</b>)',
      'a\nb {x}\n c': 'T(a\nb )A(x)T(\n c)',
      '{n, plural, other{a}}{n, select, other{b}}':
          'P(n;other[T(a)])S(n;other[T(b)])',
    };
    for (final MapEntry(key: source, value: expected) in cases.entries) {
      test(source.isEmpty ? '(empty)' : source, () {
        expect(dump(parseIcu(source)), expected);
      });
    }
  });

  group('rejects', () {
    final cases = <String, (int offset, IcuErrorKind kind)>{
      // gen-l10n rejects these too.
      '{0}': (1, IcuErrorKind.syntax),
      '{}': (1, IcuErrorKind.syntax),
      '{': (1, IcuErrorKind.syntax),
      'a { b': (5, IcuErrorKind.syntax),
      '{n, plural, other{a}': (20, IcuErrorKind.syntax),
      '{n, plural, one{a}}': (0, IcuErrorKind.missingOther),
      '{n, select, a{x}}': (0, IcuErrorKind.missingOther),
      '{n, plural, ONE{a} other{b}}': (12, IcuErrorKind.syntax),
      '{n, plural, 1{a} other{b}}': (12, IcuErrorKind.syntax),
      '{n, plural, other{a} xyz{b}}': (21, IcuErrorKind.syntax),
      '{n, select, plural{a} other{b}}': (12, IcuErrorKind.syntax),
      '{n, select, a b{x} other{y}}': (14, IcuErrorKind.syntax),
      '{x , }': (3, IcuErrorKind.syntax),
      '{x\$}': (2, IcuErrorKind.syntax),
      '{n, plural, offset:1 other{y}}': (12, IcuErrorKind.unsupported),
      '{n, selectordinal, one{x} other{y}}': (4, IcuErrorKind.unsupported),
      '{x, number}': (4, IcuErrorKind.unsupported),
      '{x, date, ::yMd}': (4, IcuErrorKind.unsupported),
      '{x, time, ::Hm}': (4, IcuErrorKind.unsupported),
      // gen-l10n's code generator rejects exact cases other than =0/=1/=2.
      '{n, plural, =3{x} other{y}}': (12, IcuErrorKind.unsupported),
      '{n, plural, =00{x} other{y}}': (12, IcuErrorKind.unsupported),
      // Deliberate deviations: gen-l10n silently drops the text after a
      // stray "}" and generates uncompilable Dart for "a|b".
      'abc } def': (4, IcuErrorKind.syntax),
      '}': (0, IcuErrorKind.syntax),
      '{n, plural, other{a}} tail}': (26, IcuErrorKind.syntax),
      '{a|b}': (1, IcuErrorKind.syntax),
    };
    for (final MapEntry(key: source, value: (offset, kind)) in cases.entries) {
      test(source, () {
        final e = error(source);
        expect(e.offset, offset, reason: e.message);
        expect(e.kind, kind, reason: e.message);
        expect(e.source, source);
      });
    }

    test('excerpt points at the offset', () {
      final e = error('line one\nab {0} cd');
      expect(e.excerpt, 'ab {0} cd\n    ^');
      expect(tryParseIcu('{0}'), isNull);
    });
  });

  group('AST helpers', () {
    final message = parseIcu(
      '<b>{name}</b>: {count, plural, =1{one <i>item</i>} one{1 item} '
      'other{{count} items of {kind, select, a{A} other{{kind}}}}}',
    );

    test('placeholder uses in depth-first order', () {
      expect(message.placeholderNames, ['name', 'count', 'kind']);
      expect(
        [for (final u in message.placeholderUses) u.usage.name],
        ['argument', 'plural', 'argument', 'select', 'argument'],
      );
    });

    test('plural cases follow gen-l10n: =1 maps to one, the later wins', () {
      final plural = message.plurals.single;
      expect(
          plural.branches.map((b) => b.category.name), ['one', 'one', 'other']);
      expect(plural.cases.keys.map((c) => c.name), ['one', 'other']);
      expect(dump(plural.cases[PluralCategory.one]!), 'T(1 item)');
      expect(plural.overriddenBranches.single.selector, '=1');
    });

    test('tags', () {
      expect(
        [for (final t in message.ownTags) '${t.closing}${t.name}'],
        ['falseb', 'trueb'],
      );
      expect(message.allTags, hasLength(4));
      expect(scanTags('<br/> a < b <x-y>')[0].selfClosing, isTrue);
      expect(scanTags('a < b > c'), isEmpty);
      expect(scanTags('a <1>'), isEmpty);
    });

    test('plain text', () {
      expect(parseIcu("It's #1").plainText, "It's #1");
      expect(parseIcu('{x}').isPlainText, isFalse);
      expect(() => parseIcu('{x}').plainText, throwsStateError);
    });

    test('node offsets', () {
      final m = parseIcu('ab {x} {n, plural, other{y}}');
      expect([for (final p in m.parts) '${p.start}-${p.end}'],
          ['0-3', '3-6', '6-7', '7-28']);
      final plural = m.parts.last as IcuPlural;
      expect(plural.branches.single.start, 19);
    });
  });
}
