/// Diagnostics of the `generate` pipeline: what is wrong with the sheet,
/// where, and how bad it is.
library;

/// How bad a [Diagnostic] is.
///
/// Declared from the most to the least severe, so `index` comparisons work.
enum Severity {
  /// Generation must not produce output.
  error,

  /// Output can be produced, but something is likely wrong. `--strict`
  /// turns warnings into errors.
  warning,

  /// Purely informative (fallbacks, synthetic locales, skipped sheets).
  info;

  /// Whether this severity is at least as severe as [other].
  bool isAtLeast(Severity other) => index <= other.index;
}

/// Stable identifiers of every diagnostic kind.
///
/// The [id] is part of the public contract (users filter on it, CI logs grep
/// for it): never rename one, only add new ones.
enum DiagnosticCode {
  /// A cell is not valid ICU MessageFormat (within the supported subset).
  icuSyntax('icu-syntax', Severity.error),

  /// A translation uses placeholders the base message does not, or misses
  /// placeholders it has.
  placeholderMismatch('placeholder-mismatch', Severity.error),

  /// A plural or select has no `other` branch.
  pluralMissingOther('plural-missing-other', Severity.error),

  /// A plural lacks a category CLDR requires for the locale.
  pluralMissingCategory('plural-missing-category', Severity.warning),

  /// A plural has two branches for the same category (`=1` and `one`); the
  /// later one wins, as in gen-l10n.
  pluralDuplicateCase('plural-duplicate-case', Severity.warning),

  /// A select has the same case twice.
  selectDuplicateCase('select-duplicate-case', Severity.error),

  /// A placeholder used as a plural count is not numeric (or as a select
  /// choice is not a String), or is used as both.
  placeholderType('placeholder-type', Severity.error),

  /// A placeholder is declared in meta but used by no translation.
  unusedPlaceholder('unused-placeholder', Severity.warning),

  /// Markup tags (`<b>`, `</b>`) differ from the base message or are not
  /// balanced.
  tagMismatch('tag-mismatch', Severity.warning),

  /// Two rows of a sheet have the same label after sanitizing.
  duplicateLabel('duplicate-label', Severity.error),

  /// Two sheets map to the same scope name after sanitizing.
  duplicateScope('duplicate-scope', Severity.error),

  /// A name is a reserved word of a target language.
  reservedWord('reserved-word', Severity.error),

  /// A name is not a valid identifier in a target language.
  invalidIdentifier('invalid-identifier', Severity.error),

  /// Two names collide after case conversion for a target.
  nameCollision('name-collision', Severity.error),

  /// The base-language cell of a row is empty (or whitespace only); the
  /// message is left out of every locale, as gen-l10n did.
  emptyBase('empty-base', Severity.warning),

  /// A header cell is not a usable locale code; the column is skipped.
  invalidLocale('invalid-locale', Severity.warning),

  /// A locale is syntactically valid but its language is unknown.
  unknownLocale('unknown-locale', Severity.warning),

  /// Two header cells denote the same locale; the later column is skipped.
  duplicateLocale('duplicate-locale', Severity.warning),

  /// The meta cell uses a feature `generate` does not support.
  unsupportedMeta('unsupported-meta', Severity.error),

  /// The meta cell is not a JSON object.
  invalidMetaJson('invalid-meta-json', Severity.error),

  /// A row has a value but no label; it is skipped.
  emptyLabel('empty-label', Severity.warning),

  /// A row is shorter than the header and was skipped (`includeEmpty` off,
  /// the behaviour of the previous generator).
  shortRow('short-row', Severity.warning),

  /// A row is entirely empty; it is skipped.
  emptyRow('empty-row', Severity.info),

  /// A translation is missing and a parent or the base text is used.
  fallback('fallback', Severity.info),

  /// A parent locale (`pt`) was synthesized from a regional one (`pt_BR`).
  syntheticLocale('synthetic-locale', Severity.info),

  /// A real parent-locale column (`ar`) was overwritten by a regional one
  /// (`ar_EG`), reproducing the previous generator.
  parentOverridden('parent-overridden', Severity.warning),

  /// A sheet is not a localization sheet (help, reference data) and is
  /// skipped.
  notLocalizationSheet('not-localization-sheet', Severity.info),

  /// A non-string cell (number, boolean) was converted to text.
  nonStringCell('non-string-cell', Severity.info),

  /// A cell (or the sheet title) contains a lone UTF-16 surrogate, i.e. is
  /// not valid Unicode text. String values keep it (escaped); comments and
  /// docstrings show U+FFFD instead.
  invalidUnicode('invalid-unicode', Severity.warning),

  /// A plural is rendered differently by the Dart target (package:intl has
  /// no rules for the locale) than by the TypeScript and Python targets
  /// (CLDR rules).
  pluralRulesMismatch('plural-rules-mismatch', Severity.warning),

  /// An exact plural case (`=0`, `=1`, `=2`) stands in for a category
  /// (`zero`, `one`, `two`) the message has no case for, and the locale's
  /// CLDR rule of that category matches other numbers too: Russian `=1{...}`
  /// without `one{...}` is also used for 21, 31, ... (gen-l10n semantics).
  pluralExactAsCategory('plural-exact-as-category', Severity.warning);

  const DiagnosticCode(this.id, this.defaultSeverity);

  /// Stable kebab-case identifier, e.g. `icu-syntax`.
  final String id;

  /// Severity used when the diagnostic is reported without an explicit one.
  final Severity defaultSeverity;

  /// Looks a code up by its [id].
  static DiagnosticCode? byId(String id) {
    for (final code in values) if (code.id == id) return code;
    return null;
  }
}

/// One finding about the sheet, with enough location for an editor to fix
/// it.
final class Diagnostic {
  /// Creates a diagnostic; [severity] defaults to the code's default.
  Diagnostic(
    this.code,
    this.message, {
    Severity? severity,
    this.scope,
    this.sheetTitle,
    this.row,
    this.column,
    this.locale,
    this.key,
    this.target,
    this.offset,
  }) : severity = severity ?? code.defaultSeverity;

  /// What kind of problem this is.
  final DiagnosticCode code;

  /// How bad it is.
  final Severity severity;

  /// Human-readable explanation.
  final String message;

  /// Sanitized scope name (`sign_up`), when the problem belongs to a scope.
  final String? scope;

  /// Original sheet title (`sign-up`).
  final String? sheetTitle;

  /// 1-based sheet row, as shown by Google Sheets.
  final int? row;

  /// Column letter, as shown by Google Sheets (`A`, `AB`).
  final String? column;

  /// Locale code (`pt_BR`).
  final String? locale;

  /// Message key (sanitized label).
  final String? key;

  /// Target the problem is specific to (`dart`, `ts`, `python`), if any.
  final String? target;

  /// 0-based offset inside the cell text (ICU syntax errors).
  final int? offset;

  /// Whether this is an error.
  bool get isError => severity == Severity.error;

  /// Copy with another [severity] (used by `--strict`).
  Diagnostic withSeverity(Severity severity) => Diagnostic(
        code,
        message,
        severity: severity,
        scope: scope,
        sheetTitle: sheetTitle,
        row: row,
        column: column,
        locale: locale,
        key: key,
        target: target,
        offset: offset,
      );

  /// Location as `sheet!B12`, `sheet!12` or `sheet`; empty when unknown.
  String get location {
    final sheet = sheetTitle ?? scope;
    final cell = switch ((column, row)) {
      (final String c, final int r) => '$c$r',
      (null, final int r) => 'row $r',
      (final String c, null) => 'column $c',
      (null, null) => null,
    };
    if (sheet == null) return cell ?? '';
    return cell == null ? sheet : '$sheet!$cell';
  }

  /// JSON representation (for machine-readable output).
  Map<String, Object?> toJson() => {
        'code': code.id,
        'severity': severity.name,
        'message': message,
        if (scope != null) 'scope': scope,
        if (sheetTitle != null) 'sheet': sheetTitle,
        if (row != null) 'row': row,
        if (column != null) 'column': column,
        if (locale != null) 'locale': locale,
        if (key != null) 'key': key,
        if (target != null) 'target': target,
        if (offset != null) 'offset': offset,
      };

  /// One-line form: `error[icu-syntax] app!E12 (ru) greeting: message`.
  @override
  String toString() {
    final buffer = StringBuffer('${severity.name}[${code.id}]');
    final where = location;
    if (where.isNotEmpty) buffer.write(' $where');
    final details = [
      if (target != null) target!,
      if (locale != null) locale!,
    ];
    if (details.isNotEmpty) buffer.write(' (${details.join(', ')})');
    if (key != null) buffer.write(' $key');
    buffer.write(': $message');
    return buffer.toString();
  }
}

/// Collects diagnostics while the pipeline runs.
final class DiagnosticSink {
  /// Creates an empty sink.
  DiagnosticSink();

  final List<Diagnostic> _diagnostics = [];

  /// Everything reported so far, in report order.
  List<Diagnostic> get diagnostics => List.unmodifiable(_diagnostics);

  /// Records [diagnostic].
  void add(Diagnostic diagnostic) => _diagnostics.add(diagnostic);

  /// Records every diagnostic of [diagnostics].
  void addAll(Iterable<Diagnostic> diagnostics) =>
      _diagnostics.addAll(diagnostics);

  /// Shorthand for [add] of a new [Diagnostic].
  void report(
    DiagnosticCode code,
    String message, {
    Severity? severity,
    String? scope,
    String? sheetTitle,
    int? row,
    String? column,
    String? locale,
    String? key,
    String? target,
    int? offset,
  }) =>
      add(Diagnostic(
        code,
        message,
        severity: severity,
        scope: scope,
        sheetTitle: sheetTitle,
        row: row,
        column: column,
        locale: locale,
        key: key,
        target: target,
        offset: offset,
      ));

  /// Whether any error was reported.
  bool get hasErrors => _diagnostics.any((d) => d.isError);

  /// Number of diagnostics with [severity].
  int count(Severity severity) =>
      _diagnostics.where((d) => d.severity == severity).length;

  /// Diagnostics with [code].
  Iterable<Diagnostic> withCode(DiagnosticCode code) =>
      _diagnostics.where((d) => d.code == code);
}

/// Promotes warnings to errors (the `--strict` mode).
List<Diagnostic> applyStrict(Iterable<Diagnostic> diagnostics) => [
      for (final d in diagnostics)
        d.severity == Severity.warning ? d.withSeverity(Severity.error) : d,
    ];

/// Human-readable report, grouped by scope (diagnostics without a scope come
/// first under "general"), ordered by severity, row and column within a
/// scope, and followed by a summary line.
///
/// [minimum] hides diagnostics less severe than it (e.g. infos).
String formatDiagnostics(
  Iterable<Diagnostic> diagnostics, {
  Severity minimum = Severity.info,
}) {
  final shown = diagnostics.where((d) => d.severity.isAtLeast(minimum));
  final groups = <String, List<Diagnostic>>{};
  for (final d in shown) {
    (groups[d.scope ?? ''] ??= []).add(d);
  }
  final keys = groups.keys.toList()
    ..sort((a, b) {
      if (a.isEmpty) return b.isEmpty ? 0 : -1;
      if (b.isEmpty) return 1;
      return a.compareTo(b);
    });
  final buffer = StringBuffer();
  for (final scope in keys) {
    final list = groups[scope]!
      ..sort((a, b) {
        final bySeverity = a.severity.index.compareTo(b.severity.index);
        if (bySeverity != 0) return bySeverity;
        final byRow = (a.row ?? 0).compareTo(b.row ?? 0);
        if (byRow != 0) return byRow;
        return _columnIndex(a.column).compareTo(_columnIndex(b.column));
      });
    final sheet = list.first.sheetTitle;
    final title = scope.isEmpty
        ? 'general'
        : sheet == null || sheet == scope
            ? scope
            : '$scope (sheet "$sheet")';
    final errors = list.where((d) => d.severity == Severity.error).length;
    final warnings = list.where((d) => d.severity == Severity.warning).length;
    buffer.writeln('$title: $errors error(s), $warnings warning(s)');
    for (final d in list) {
      buffer.writeln('  $d');
    }
  }
  final all = diagnostics.toList();
  buffer.write(
    '${all.where((d) => d.severity == Severity.error).length} error(s), '
    '${all.where((d) => d.severity == Severity.warning).length} warning(s), '
    '${all.where((d) => d.severity == Severity.info).length} info(s).',
  );
  return buffer.toString();
}

int _columnIndex(String? column) {
  if (column == null) return -1;
  var index = 0;
  for (final unit in column.codeUnits) {
    index = index * 26 + (unit - 64);
  }
  return index;
}
