import 'package:test/test.dart';

import '../sheety.dart';

void main() {
  test('codes are unique, stable kebab-case ids', () {
    final ids = [for (final c in DiagnosticCode.values) c.id];
    expect(ids.toSet(), hasLength(ids.length));
    for (final id in ids) {
      expect(id, matches(RegExp(r'^[a-z]+(-[a-z]+)*$')));
    }
    expect(DiagnosticCode.byId('icu-syntax'), DiagnosticCode.icuSyntax);
    expect(DiagnosticCode.byId('nope'), isNull);
  });

  test('default severities follow the design', () {
    expect(DiagnosticCode.icuSyntax.defaultSeverity, Severity.error);
    expect(DiagnosticCode.duplicateLabel.defaultSeverity, Severity.error);
    expect(
        DiagnosticCode.pluralMissingCategory.defaultSeverity, Severity.warning);
    expect(DiagnosticCode.invalidLocale.defaultSeverity, Severity.warning);
    expect(DiagnosticCode.fallback.defaultSeverity, Severity.info);
  });

  test('location and one-line form', () {
    final d = Diagnostic(
      DiagnosticCode.icuSyntax,
      'Unmatched "}"',
      scope: 'sign_up',
      sheetTitle: 'sign-up',
      row: 12,
      column: 'E',
      locale: 'ru',
      key: 'greeting',
    );
    expect(d.location, 'sign-up!E12');
    expect(d.toString(),
        'error[icu-syntax] sign-up!E12 (ru) greeting: Unmatched "}"');
    expect(d.toJson(), {
      'code': 'icu-syntax',
      'severity': 'error',
      'message': 'Unmatched "}"',
      'scope': 'sign_up',
      'sheet': 'sign-up',
      'row': 12,
      'column': 'E',
      'locale': 'ru',
      'key': 'greeting',
    });
    expect(Diagnostic(DiagnosticCode.fallback, 'x', scope: 's').location, 's');
    expect(Diagnostic(DiagnosticCode.fallback, 'x', row: 3).location, 'row 3');
  });

  test('sink and strict mode', () {
    final sink = DiagnosticSink()
      ..report(DiagnosticCode.tagMismatch, 'w')
      ..report(DiagnosticCode.fallback, 'i');
    expect(sink.hasErrors, isFalse);
    expect(sink.count(Severity.warning), 1);
    final strict = applyStrict(sink.diagnostics);
    expect(strict.map((d) => d.severity), [Severity.error, Severity.info]);
    expect(sink.withCode(DiagnosticCode.fallback), hasLength(1));
  });

  test('formatDiagnostics groups by scope and sorts by row', () {
    final text = formatDiagnostics([
      Diagnostic(DiagnosticCode.tagMismatch, 'b', scope: 'b', row: 3),
      Diagnostic(DiagnosticCode.icuSyntax, 'b2', scope: 'b', row: 9),
      Diagnostic(DiagnosticCode.fallback, 'a', scope: 'a', row: 1),
      Diagnostic(DiagnosticCode.duplicateScope, 'g'),
      Diagnostic(DiagnosticCode.emptyRow, 'c',
          scope: 'b', row: 1, column: 'AB'),
    ], minimum: Severity.warning);
    expect(
      text,
      'general: 1 error(s), 0 warning(s)\n'
      '  error[duplicate-scope]: g\n'
      'b: 1 error(s), 1 warning(s)\n'
      '  error[icu-syntax] b!row 9: b2\n'
      '  warning[tag-mismatch] b!row 3: b\n'
      '2 error(s), 1 warning(s), 2 info(s).',
    );
  });
}
