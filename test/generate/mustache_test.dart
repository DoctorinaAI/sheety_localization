import 'package:test/test.dart';

import '../sheety.dart';

String dump(IcuMessage m) => [
      for (final p in m.parts)
        switch (p) {
          IcuText(:final text) => 'T($text)',
          IcuArgument(:final name) => 'A($name)',
          _ => '?',
        },
    ].join();

void main() {
  test('placeholders and literal text', () {
    final cases = {
      '': '',
      'Hello': 'T(Hello)',
      'Hi {{name}}!': 'T(Hi )A(name)T(!)',
      '{{ name }}': 'A(name)',
      '{{a}}{{_b2}}': 'A(a)A(_b2)',
      'a {single} b }} c': 'T(a {single} b }} c)',
      "It's {x, plural, other{y}} #": "T(It's {x, plural, other{y}} #)",
      '{ {x} }': 'T({ {x} })',
      'multi\nline {{x}}': 'T(multi\nline )A(x)',
    };
    for (final MapEntry(key: source, value: expected) in cases.entries) {
      expect(dump(parseMustache(source)), expected, reason: source);
    }
  });

  test('offsets', () {
    final m = parseMustache('ab {{ x }} cd');
    expect([for (final p in m.parts) '${p.start}-${p.end}'],
        ['0-3', '3-10', '10-13']);
    expect(m.placeholderNames, ['x']);
  });

  test('errors', () {
    final cases = <String, (int, IcuErrorKind)>{
      'Hi {{name': (3, IcuErrorKind.syntax),
      '{{}}': (0, IcuErrorKind.syntax),
      '{{  }}': (0, IcuErrorKind.syntax),
      'a {{user.name}}': (4, IcuErrorKind.unsupported),
      '{{ 2fa }}': (3, IcuErrorKind.syntax),
      '{{a-b}}': (2, IcuErrorKind.syntax),
      '{{{x}}}': (0, IcuErrorKind.unsupported),
      'a {{{ x }}}': (2, IcuErrorKind.unsupported),
    };
    for (final MapEntry(key: source, value: (offset, kind)) in cases.entries) {
      try {
        parseMustache(source);
        fail('"$source" parsed');
      } on IcuSyntaxException catch (e) {
        expect((e.offset, e.kind), (offset, kind), reason: source);
      }
    }
  });

  test('triple braces get a clear error', () {
    expect(
      () => parseMustache('Hi {{{name}}}'),
      throwsA(isA<IcuSyntaxException>().having(
        (e) => e.message,
        'message',
        contains('Triple braces'),
      )),
    );
  });

  test('parseMessage dispatches; looksLikeMustache', () {
    expect(dump(parseMessage('{x}', MessageSyntax.icu)), 'A(x)');
    expect(dump(parseMessage('{x}', MessageSyntax.mustache)), 'T({x})');
    expect(MessageSyntax.byName('mustache'), MessageSyntax.mustache);
    expect(looksLikeMustache('costs {{unit_price}}'), isTrue);
    expect(looksLikeMustache('costs {unit_price}'), isFalse);
  });
}
