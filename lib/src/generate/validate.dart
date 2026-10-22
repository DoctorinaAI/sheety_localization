/// Cross-locale and per-target checks over a [Catalog].
library;

import 'cldr/plural_rules.dart';
import 'diagnostics.dart';
import 'emitter.dart';
import 'icu/ast.dart';
import 'model.dart';
import 'naming.dart';

/// Checks every scope of [catalog] and returns the findings.
///
/// Cross-locale checks (always):
/// * `placeholder-mismatch` — a translation uses a placeholder the base text
///   does not, or misses one it uses;
/// * `plural-missing-category` — a plural lacks a category CLDR requires for
///   the locale (`=0`/`=1`/`=2` count as `zero`/`one`/`two`, as gen-l10n
///   maps them);
/// * `plural-duplicate-case`, `select-duplicate-case`;
/// * `tag-mismatch` — markup tags differ from the base text or are
///   unbalanced;
/// * `unused-placeholder` — declared in meta, used by no text;
/// * `fallback` — per locale, how many messages use a fallback text.
///
/// Identifier checks for every target of [targets]:
/// `invalid-identifier`, `reserved-word` and `name-collision` for scope
/// names, message keys and placeholder names, using [targetName] and
/// [checkIdentifier]. [reserved] adds names a target's emitter uses itself.
List<Diagnostic> validateCatalog(
  Catalog catalog, {
  Iterable<Target> targets = const [],
  Map<Target, Set<String>> reserved = const {},
  Map<Target, Map<IdentifierRole, Set<String>>> reservedByRole = const {},
}) {
  final sink = DiagnosticSink();
  for (final scope in catalog.scopes) {
    _validateScope(scope, sink);
  }
  for (final target in targets) {
    validateIdentifiers(
      catalog,
      target,
      sink: sink,
      reserved: reserved[target] ?? const {},
      reservedByRole: reservedByRole[target] ?? const {},
    );
  }
  return sink.diagnostics;
}

void _validateScope(Scope scope, DiagnosticSink sink) {
  for (final message in scope.messages) {
    final base = message.base;
    final baseNames = base.ast.placeholderNames.toSet();
    final baseTags = _tagNames(base.ast);

    void report(
      DiagnosticCode code,
      String text,
      Translation translation, {
      Severity? severity,
    }) =>
        sink.report(
          code,
          text,
          severity: severity,
          scope: scope.name,
          sheetTitle: scope.sheetTitle,
          row: translation.row ?? message.row,
          column: translation.column,
          locale: translation.locale.code,
          key: message.key,
        );

    // Distinct cells only: a synthetic `pt` shares its cell with `pt_BR`.
    final checkedCells = <String>{};
    for (final translation in message.translations.values) {
      final ast = translation.ast;
      final cell = '${translation.column}${translation.row}';
      final firstTime = checkedCells.add(cell);

      if (firstTime && translation.locale != message.baseLocale) {
        final names = ast.placeholderNames.toSet();
        final missing = baseNames.difference(names);
        final extra = names.difference(baseNames);
        if (missing.isNotEmpty || extra.isNotEmpty) {
          report(
            DiagnosticCode.placeholderMismatch,
            [
              if (missing.isNotEmpty)
                'misses ${_list(missing)} of the base text',
              if (extra.isNotEmpty)
                'uses ${_list(extra)}, which the base text does not',
            ].join(' and '),
            translation,
          );
        }
        final tags = _tagNames(ast);
        if (tags.length != baseTags.length || !tags.containsAll(baseTags)) {
          report(
            DiagnosticCode.tagMismatch,
            'Markup tags ${_list(tags, quote: false)} differ from the base '
            'text ${_list(baseTags, quote: false)}',
            translation,
          );
        }
      }
      if (firstTime) {
        final unbalanced = _unbalancedTags(ast);
        if (unbalanced != null) {
          report(DiagnosticCode.tagMismatch, unbalanced, translation);
        }
        for (final select in ast.selects) {
          final duplicates = select.duplicateValues.toSet();
          if (duplicates.isNotEmpty) {
            report(
              DiagnosticCode.selectDuplicateCase,
              'Select "${select.argument}" has the case(s) '
              '${_list(duplicates)} more than once',
              translation,
            );
          }
        }
        for (final plural in ast.plurals) {
          final overridden = plural.overriddenBranches;
          if (overridden.isNotEmpty) {
            report(
              DiagnosticCode.pluralDuplicateCase,
              'Plural "${plural.argument}": '
              '${_list(overridden.map((b) => b.selector))} '
              '${overridden.length == 1 ? 'is' : 'are'} overridden by a '
              'later case of the same category (gen-l10n uses the later one)',
              translation,
            );
          }
        }
      }
      // Per locale (a synthetic `pt` has other rules than `pt_BR` may have).
      final required = requiredCategories(translation.locale.code);
      for (final plural in ast.plurals) {
        final provided = plural.cases.keys.toSet();
        final missing = required.where((c) => !provided.contains(c)).toList();
        if (missing.isEmpty) continue;
        report(
          DiagnosticCode.pluralMissingCategory,
          'Plural "${plural.argument}" has no '
          '${_list(missing.map((c) => c.name))} case; CLDR $cldrVersion '
          'requires ${required.map((c) => c.name).join(' ')} for '
          '"${translation.locale.code}" (the "other" text is used instead)',
          translation,
        );
      }
    }

    final used = {
      for (final t in message.translations.values) ...t.ast.placeholderNames,
    };
    for (final placeholder in message.placeholders) {
      if (!placeholder.declared || used.contains(placeholder.name)) continue;
      sink.report(
        DiagnosticCode.unusedPlaceholder,
        'Placeholder "${placeholder.name}" is declared in meta but no text '
        'uses it (it still becomes a parameter)',
        scope: scope.name,
        sheetTitle: scope.sheetTitle,
        row: message.row,
        column: 'C',
        key: message.key,
      );
    }
  }

  for (final locale in scope.locales) {
    if (locale.tag == scope.baseLocale) continue;
    final keys = [
      for (final m in scope.messages)
        if (m.translationFor(locale.tag).isFallback) m.key,
    ];
    if (keys.isEmpty) continue;
    final shown = keys.take(5).join(', ');
    sink.report(
      DiagnosticCode.fallback,
      '${keys.length} of ${scope.messages.length} message(s) have no '
      '"${locale.tag.code}" text and use the '
      '${locale.tag.parent == null ? 'base' : 'parent or base'} text: '
      '$shown${keys.length > 5 ? ', ...' : ''}',
      scope: scope.name,
      sheetTitle: scope.sheetTitle,
      column: locale.column,
      locale: locale.tag.code,
    );
  }
}

/// Checks scope names, message keys and placeholder names of [catalog] for
/// [target]: valid identifiers, no reserved words, no collisions after case
/// conversion. Findings are added to [sink] (a new one when omitted) and
/// returned.
///
/// Scopes collide when any identifier the target derives from them is the
/// same (compared case-insensitively where it names a file or directory):
/// the Dart class, the TypeScript directory and namespace, the Python
/// package and class.
List<Diagnostic> validateIdentifiers(
  Catalog catalog,
  Target target, {
  DiagnosticSink? sink,
  Set<String> reserved = const {},
  Map<IdentifierRole, Set<String>> reservedByRole = const {},
}) {
  final out = sink ?? DiagnosticSink();
  final before = out.diagnostics.length;

  void check(
    String source,
    IdentifierRole role, {
    required Scope scope,
    Message? message,
    String what = '',
  }) {
    final name = targetName(target, role, source);
    final problem = checkIdentifier(
      name,
      target,
      role,
      reserved: reserved,
      reservedByRole: reservedByRole,
    );
    if (problem == null) return;
    final shown = name == source ? '"$name"' : '"$source" ("$name")';
    out.report(
      problem.reserved
          ? DiagnosticCode.reservedWord
          : DiagnosticCode.invalidIdentifier,
      '$what $shown ${problem.reason}',
      scope: scope.name,
      sheetTitle: scope.sheetTitle,
      row: message?.row ?? (role == IdentifierRole.scope ? null : 1),
      column: switch (role) {
        IdentifierRole.message => 'A',
        IdentifierRole.parameter => 'C',
        IdentifierRole.scope => null,
      },
      key: message?.key,
      target: target.id,
    );
  }

  for (final scope in catalog.scopes) {
    check(scope.name, IdentifierRole.scope, scope: scope, what: 'Scope');
    for (final message in scope.messages) {
      check(
        message.key,
        IdentifierRole.message,
        scope: scope,
        message: message,
        what: 'Key',
      );
      for (final p in message.placeholders) {
        check(
          p.name,
          IdentifierRole.parameter,
          scope: scope,
          message: message,
          what: 'Placeholder',
        );
      }
      final params = findCollisions(
        message.placeholders.map((p) => p.name),
        (n) => targetName(target, IdentifierRole.parameter, n),
      );
      for (final MapEntry(key: name, value: sources) in params.entries) {
        out.report(
          DiagnosticCode.nameCollision,
          'Placeholders ${_list(sources)} all become "$name" in '
          '${target.id}',
          scope: scope.name,
          sheetTitle: scope.sheetTitle,
          row: message.row,
          column: 'C',
          key: message.key,
          target: target.id,
        );
      }
    }
    final keys = findCollisions(
      scope.messages.map((m) => m.key),
      (k) => targetName(target, IdentifierRole.message, k),
    );
    for (final MapEntry(key: name, value: sources) in keys.entries) {
      final rows = [
        for (final key in sources) scope.message(key)?.row,
      ].nonNulls;
      out.report(
        DiagnosticCode.nameCollision,
        'Keys ${_list(sources)} (rows ${rows.join(', ')}) all become '
        '"$name" in ${target.id}',
        scope: scope.name,
        sheetTitle: scope.sheetTitle,
        row: rows.isEmpty ? null : rows.last,
        column: 'A',
        key: sources.last,
        target: target.id,
      );
    }
  }
  final reported = <String>{};
  for (final (what, convert) in scopeIdentifiers(target)) {
    final scopes = findCollisions(catalog.scopes.map((s) => s.name), convert);
    for (final MapEntry(key: name, value: sources) in scopes.entries) {
      // One report per group of scopes, by the first identifier colliding.
      if (!reported.add((sources.toList()..sort()).join('\u0000'))) continue;
      out.report(
        DiagnosticCode.nameCollision,
        'Scopes ${_list(sources)} all become the $what "$name" in '
        '${target.id}',
        scope: sources.last,
        target: target.id,
      );
    }
  }
  return out.diagnostics.sublist(before);
}

/// The identifiers [target] derives from a scope name, each with what it
/// names and how it is computed; two scopes must differ in every one.
/// Names of files and directories are compared lower-cased (they collide on
/// case-insensitive file systems).
List<(String, String Function(String scope))> scopeIdentifiers(
  Target target,
) =>
    switch (target) {
      Target.dart => [
          ('class', scopeClassName),
          ('directory', (s) => s.toLowerCase()),
        ],
      // The `<Scope>Messages` types live in the scope's own module.
      Target.ts => [('directory', (s) => s.toLowerCase())],
      Target.python => [
          ('package', (s) => s.toLowerCase()),
          ('class', scopeClassName),
        ],
    };

Set<String> _tagNames(IcuMessage ast) => {
      for (final tag in ast.allTags)
        '<${tag.closing ? '/' : ''}${tag.name}${tag.selfClosing ? '/' : ''}>',
    };

/// A description of the first unbalanced tag of [message] or of any nested
/// branch, `null` when all are balanced.
String? _unbalancedTags(IcuMessage message) {
  final stack = <String>[];
  for (final tag in message.ownTags) {
    if (tag.selfClosing) continue;
    if (!tag.closing) {
      stack.add(tag.name);
    } else if (stack.isEmpty || stack.last != tag.name) {
      return 'Closing tag </${tag.name}> at offset ${tag.offset} has no '
          'matching opening tag';
    } else {
      stack.removeLast();
    }
  }
  if (stack.isNotEmpty) return 'Tag <${stack.last}> is never closed';
  for (final part in message.parts) {
    final branches = switch (part) {
      IcuPlural(:final branches) => [for (final b in branches) b.message],
      IcuSelect(:final branches) => [for (final b in branches) b.message],
      IcuText() || IcuArgument() => const <IcuMessage>[],
    };
    for (final branch in branches) {
      final problem = _unbalancedTags(branch);
      if (problem != null) return problem;
    }
  }
  return null;
}

String _list(Iterable<String> items, {bool quote = true}) {
  final list = items.toList();
  if (list.isEmpty) return 'none';
  return list.map((i) => quote ? '"$i"' : i).join(', ');
}
