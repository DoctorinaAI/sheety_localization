/// The Python target: a zero-dependency package (Python >= 3.9, typed,
/// `mypy --strict` clean) meant to live inside the user's own package.
///
/// Layout under the output directory (all imports are relative):
///
/// ```text
/// __init__.py          SCOPES, SUPPORTED_LOCALES, BASE_LOCALE, get(),
///                      resolve_locale(), re-exports
/// py.typed             PEP 561 marker
/// _runtime.py          plural rules + selection, to_str(), locale
///                      negotiation, Message / Placeholder, Localization
/// <scope>/__init__.py  abstract <Scope>Localization, LOCALES, BASE_LOCALE,
///                      MESSAGES, get(), resolve_locale()
/// <scope>/_<locale>.py one concrete class per locale (lazily imported)
/// ```
library;

import '../../cldr/plural_rules.dart';
import '../../diagnostics.dart';
import '../../emitter.dart';
import '../../icu/ast.dart';
import '../../model.dart';
import '../../naming.dart';
import '../../validate.dart';
import 'python_code.dart';
import 'python_runtime.dart';

/// Generates the Python package.
final class PythonEmitter implements Emitter {
  /// Creates the emitter.
  const PythonEmitter();

  /// Names the generated Python code itself uses and the sheet therefore
  /// cannot take (pass them to `validateIdentifiers` as `reserved`).
  ///
  /// * `format` is the dynamic method of every localization class; `self`
  ///   is the receiver of every method.
  /// * The rest are the public names of the root `__init__.py`: a scope
  ///   (sub-package) of that name would replace them when imported.
  ///
  /// Class-level metadata (`LOCALE`, `TEMPLATES`, ...) is upper case and
  /// cannot collide with the snake_case message names.
  static const Set<String> reservedNames = {
    'format', 'self', 'annotations', 'get', 'resolve_locale', //
    'negotiate_locale', 'parse_accept_language', 'plural_category',
    'SCOPES', 'SUPPORTED_LOCALES', 'BASE_LOCALE', 'CLDR_VERSION',
    'Localization', 'Message', 'Placeholder',
  };

  /// Builtins the generated class bodies use (decorators, calls and
  /// annotations), which a message of the same name would hide: such a
  /// scope refers to them as `_builtins.<name>` instead.
  static const Set<String> classBuiltins = {
    'property',
    'frozenset',
    'str',
    'int',
    'float',
    'object',
  };

  @override
  Target get target => Target.python;

  @override
  List<GeneratedFile> emit(Catalog catalog, EmitOptions options) {
    final problems = validateIdentifiers(
      catalog,
      Target.python,
      reserved: reservedNames,
    ).where((d) => d.isError).toList();
    if (problems.isNotEmpty) {
      throw StateError(
        'The catalog has names that are not valid in Python:\n'
        '${formatDiagnostics(problems)}',
      );
    }
    final header = options.headerComment('#');
    return [
      GeneratedFile('__init__.py', _root(catalog, header)),
      GeneratedFile('py.typed', ''),
      GeneratedFile('_runtime.py', pythonRuntime(header, catalog.locales)),
      for (final scope in catalog.scopes) ...[
        GeneratedFile('${scope.name}/__init__.py', _scope(scope, header)),
        for (final locale in scope.localeTags)
          GeneratedFile(
            '${scope.name}/${pyLocaleModule(locale)}.py',
            _locale(scope, locale, header),
          ),
      ],
    ];
  }

  // --- root ---------------------------------------------------------------

  String _root(Catalog catalog, String header) {
    final scopes = catalog.scopes;
    final base = catalog.baseLocale?.code ??
        (scopes.isEmpty ? 'en' : scopes.first.baseLocale.code);
    final classes = [for (final s in scopes) scopeClassName(s.name)];
    final exports = <String>{
      'BASE_LOCALE', 'CLDR_VERSION', 'Localization', 'Message', //
      'Placeholder', 'SCOPES', 'SUPPORTED_LOCALES', 'get',
      'negotiate_locale', 'parse_accept_language', 'plural_category',
      'resolve_locale',
      ...classes,
      for (final s in scopes) s.name,
    }.toList()
      ..sort();
    final scopeList =
        scopes.isEmpty ? '(none)' : scopes.map((s) => s.name).join(', ');
    final example = scopes.isEmpty ? 'chat' : scopes.first.name;
    final out = StringBuffer(header)
      ..writeln('# ruff: noqa')
      ..writeln('"""Generated localization package.')
      ..writeln()
      ..writeln('Scopes (one sub-package per sheet): $scopeList.')
      ..writeln()
      ..writeln('Use a scope directly (``from .$example import get``) or '
          'by name')
      ..writeln('(``get("$example", "pt-BR")``).')
      ..writeln('"""')
      ..writeln()
      ..writeln('from __future__ import annotations')
      ..writeln()
      ..writeln('import typing as _typing')
      ..writeln()
      ..writeln('from ._runtime import (')
      ..writeln('    CLDR_VERSION,')
      ..writeln('    Localization,')
      ..writeln('    Message,')
      ..writeln('    Placeholder,')
      ..writeln('    negotiate_locale,')
      ..writeln('    parse_accept_language,')
      ..writeln('    plural_category,')
      ..writeln('    sanitize_key as _sanitize_key,')
      ..writeln(')');
    for (final scope in scopes) {
      out.writeln('from . import ${scope.name}');
    }
    for (final scope in scopes) {
      out.writeln('from .${scope.name} import ${scopeClassName(scope.name)}');
    }
    out
      ..writeln()
      ..writeln('__all__ = [')
      ..writeAll([for (final e in exports) '    ${pyString(e)},\n'])
      ..writeln(']')
      ..writeln()
      ..writeln('#: Every scope (sheet), in sheet order.')
      ..writeln('SCOPES: _typing.Tuple[str, ...] = '
          '${pyStringTuple(scopes.map((s) => s.name))}')
      ..writeln('#: Every locale of any scope, in order of first appearance.')
      ..writeln('SUPPORTED_LOCALES: _typing.Tuple[str, ...] = '
          '${pyStringTuple(catalog.locales.map((l) => l.code))}')
      ..writeln('#: The base locale shared by the scopes (that of the first '
          'scope if they differ).')
      ..writeln('BASE_LOCALE = ${pyString(base)}')
      ..writeln()
      ..writeln('_GETTERS: _typing.Mapping[')
      ..writeln('    str, _typing.Callable[[_typing.Union[str, '
          '_typing.Sequence[str]]], Localization]')
      ..writeln('] = {');
    for (final scope in scopes) {
      out.writeln('    ${pyString(scope.name)}: ${scope.name}.get,');
    }
    out
      ..writeln('}')
      ..writeln()
      ..writeln()
      ..writeln('def resolve_locale(requested: _typing.Union[str, '
          '_typing.Sequence[str]]) -> str:')
      ..writeln('    """The best of ``SUPPORTED_LOCALES`` for a tag, a list of '
          'tags or an')
      ..writeln('    ``Accept-Language`` header; ``BASE_LOCALE`` when none '
          'matches."""')
      ..writeln('    return negotiate_locale(requested, SUPPORTED_LOCALES, '
          'BASE_LOCALE)')
      ..writeln()
      ..writeln()
      ..writeln('def get(')
      ..writeln('    scope: str, locale: _typing.Union[str, '
          '_typing.Sequence[str]] = BASE_LOCALE')
      ..writeln(') -> Localization:')
      ..writeln('    """The localization of ``scope`` (name or sheet title) '
          'for ``locale``')
      ..writeln('    (negotiated within the scope\'s own locales)."""')
      ..writeln('    getter = _GETTERS.get(scope) or '
          '_GETTERS.get(_sanitize_key(scope))')
      ..writeln('    if getter is None:')
      ..writeln('        raise KeyError(f"Unknown localization scope '
          '{scope!r}")')
      ..writeln('    return getter(locale)');
    return out.toString();
  }

  // --- scope --------------------------------------------------------------

  String _scope(Scope scope, String header) {
    final names = _Builtins(scope);
    final className = scopeClassName(scope.name);
    final usesPlaceholders = scope.messages.any((m) => m.hasPlaceholders);
    final out = StringBuffer(header)
      ..writeln('# ruff: noqa')
      ..writeln('"""Messages of the sheet ${pyDocText(
        '"${scope.sheetTitle}"',
        '',
      )}.')
      ..writeln()
      ..writeln('Base locale: ${scope.baseLocale.code}. Locales: '
          '${scope.localeTags.map((l) => l.code).join(', ')}.')
      ..writeln('"""')
      ..writeln()
      ..writeln('from __future__ import annotations')
      ..writeln()
      ..write(scope.messages.isEmpty ? '' : 'import abc as _abc\n')
      ..write(names.import)
      ..writeln('import importlib as _importlib')
      ..writeln('import typing as _typing')
      ..writeln('from types import MappingProxyType as _MappingProxyType')
      ..writeln()
      ..writeln('from .._runtime import Localization, Message, '
          '${usesPlaceholders ? 'Placeholder, ' : ''}negotiate_locale')
      ..writeln()
      ..writeln('__all__ = [')
      ..writeln('    "BASE_LOCALE",')
      ..writeln('    "LOCALES",')
      ..writeln('    "MESSAGES",')
      ..writeln('    "SCOPE",')
      ..writeln('    "SHEET_TITLE",')
      ..writeln('    "SYNTAX",')
      ..writeln('    ${pyString(className)},')
      ..writeln('    "get",')
      ..writeln('    "resolve_locale",')
      ..writeln(']')
      ..writeln()
      ..writeln('#: Scope name (sanitized sheet title).')
      ..writeln('SCOPE = ${pyString(scope.name)}')
      ..writeln('#: Title of the sheet.')
      ..writeln('SHEET_TITLE = ${pyString(scope.sheetTitle)}')
      ..writeln('#: Message syntax of the sheet: ``icu`` or ``mustache``.')
      ..writeln('SYNTAX = ${pyString(scope.syntax.name)}')
      ..writeln('#: Base locale (the fourth column of the sheet).')
      ..writeln('BASE_LOCALE = ${pyString(scope.baseLocale.code)}')
      ..writeln('#: Locales, in sheet order (synthetic parents last).')
      ..writeln('LOCALES: _typing.Tuple[str, ...] = '
          '${pyStringTuple(scope.localeTags.map((l) => l.code))}')
      ..writeln()
      ..writeln()
      ..writeln('class $className(Localization):')
      ..writeln(
          '    """Messages of the sheet "${pyDocText(scope.sheetTitle, '')}"'
          ' (base locale ${scope.baseLocale.code})."""')
      ..writeln()
      ..writeln('    __slots__ = ()')
      ..writeln()
      ..writeln('    SCOPE = ${pyString(scope.name)}')
      ..writeln('    BASE_LOCALE = ${pyString(scope.baseLocale.code)}');
    if (scope.messages.isEmpty) {
      out.writeln(
          '    MESSAGES: _typing.ClassVar[_typing.Tuple[Message, ...]] = ()');
    } else {
      out.writeln(
          '    MESSAGES: _typing.ClassVar[_typing.Tuple[Message, ...]] = (');
      for (final message in scope.messages) {
        _writeMessageMeta(out, message);
      }
      out.writeln('    )');
    }
    out
      ..writeln('    _MESSAGES_BY_KEY = _MappingProxyType({m.key: m for m in '
          'MESSAGES})')
      ..writeln();
    for (final message in scope.messages) {
      _writeAbstract(out, scope, message, names);
    }
    out
      ..writeln()
      ..writeln('#: Message metadata, in sheet order.')
      ..writeln('MESSAGES = $className.MESSAGES')
      ..writeln()
      ..writeln('_INSTANCES: _typing.Dict[str, $className] = {}')
      ..writeln()
      ..writeln()
      ..writeln('def resolve_locale(requested: _typing.Union[str, '
          '_typing.Sequence[str]]) -> str:')
      ..writeln('    """The best of ``LOCALES`` for a tag (``pt-BR``), a list '
          'of tags or an')
      ..writeln('    ``Accept-Language`` header; ``BASE_LOCALE`` when none '
          'matches."""')
      ..writeln('    return negotiate_locale(requested, LOCALES, BASE_LOCALE)')
      ..writeln()
      ..writeln()
      ..writeln('def get(locale: _typing.Union[str, _typing.Sequence[str]] = '
          'BASE_LOCALE) -> $className:')
      ..writeln('    """The localization for ``locale`` (negotiated with '
          ':func:`resolve_locale`).')
      ..writeln()
      ..writeln('    Locale modules are imported on first use; instances are '
          'cached.')
      ..writeln('    """')
      ..writeln('    code = resolve_locale(locale)')
      ..writeln('    instance = _INSTANCES.get(code)')
      ..writeln('    if instance is None:')
      ..writeln('        module = _importlib.import_module("._" + code, '
          '__name__)')
      ..writeln('        instance = _typing.cast($className, '
          'getattr(module, "LOCALIZATION"))')
      ..writeln('        _INSTANCES[code] = instance')
      ..writeln('    return instance');
    return out.toString();
  }

  void _writeMessageMeta(StringBuffer out, Message message) {
    out
      ..writeln('        Message(')
      ..writeln('            key=${pyString(message.key)},')
      ..writeln(
          '            attribute=${pyString(pyMessageName(message.key))},')
      ..writeln('            description=${_optional(message.description)},');
    if (message.placeholders.isEmpty) {
      out.writeln('            placeholders=(),');
    } else {
      out.writeln('            placeholders=(');
      for (final p in message.placeholders) {
        out
          ..writeln('                Placeholder(')
          ..writeln('                    name=${pyString(p.name)},')
          ..writeln('                    parameter='
              '${pyString(pyParameterName(p.name))},')
          ..writeln('                    type=${pyString(p.type.arbName)},')
          ..writeln('                    example=${_optional(p.example)},')
          ..writeln('                    description='
              '${_optional(p.description)},')
          ..writeln('                ),');
      }
      out.writeln('            ),');
    }
    out.writeln('        ),');
  }

  void _writeAbstract(
    StringBuffer out,
    Scope scope,
    Message message,
    _Builtins names,
  ) {
    final name = pyMessageName(message.key);
    final str = names('str');
    if (message.hasPlaceholders) {
      out
        ..writeln('    @_abc.abstractmethod')
        ..writeln('    def $name(self, *, ${_parameters(message, names)}) '
            '-> $str:');
    } else {
      out
        ..writeln('    @${names('property')}')
        ..writeln('    @_abc.abstractmethod')
        ..writeln('    def $name(self) -> $str:');
    }
    final description = message.description?.trim() ?? '';
    final doc = StringBuffer()
      ..writeln(description.isEmpty ? '``${message.key}``' : description);
    if (description.isNotEmpty) {
      doc
        ..writeln()
        ..writeln('Key: ``${message.key}``.');
    }
    if (message.hasPlaceholders) {
      doc
        ..writeln()
        ..writeln('Arguments:');
      for (final p in message.placeholders) {
        final details = [
          if (p.description?.trim() case final String d when d.isNotEmpty)
            d.endsWith('.') ? d : '$d.',
          if (p.example case final String e) 'Example: ``$e``.',
        ].join(' ');
        final parameter = pyParameterName(p.name);
        final source = p.name == parameter ? '' : ', {${p.name}}';
        doc.writeln('    $parameter (${p.type.arbName}$source)'
            '${details.isEmpty ? '' : ': $details'}');
      }
    }
    doc
      ..writeln()
      ..write('In ${scope.baseLocale.code}: ${message.base.raw}');
    out
      ..writeln('        """${pyDocText(doc.toString(), '        ')}')
      ..writeln('        """')
      ..writeln();
  }

  String _parameters(Message message, _Builtins names) => [
        for (final p in message.placeholders)
          '${pyParameterName(p.name)}: ${names(pyType(p.type))}',
      ].join(', ');

  String _optional(String? value) => value == null ? 'None' : pyString(value);

  // --- locale -------------------------------------------------------------

  String _locale(Scope scope, LocaleTag locale, String header) {
    final names = _Builtins(scope);
    final base = scopeClassName(scope.name);
    final className = localeClassName(scope.name, locale);
    final rule = pyPluralFunctionFor(locale);
    final translations = {
      for (final m in scope.messages) m: m.translationFor(locale),
    };
    final fallbacks = [
      for (final MapEntry(:key, :value) in translations.entries)
        if (value.isFallback) key.key,
    ];
    final used = <String>{};
    final methods = StringBuffer();
    for (final MapEntry(key: message, value: translation)
        in translations.entries) {
      methods.writeln();
      _writeImplementation(methods, message, translation, used, names);
    }
    final imports = [
      if (used.contains('_rule')) '$rule as _rule',
      for (final helper in ['plural_case', 'select_case', 'to_str'])
        if (used.contains('_$helper')) '$helper as _$helper',
    ];
    final from = scope.locale(locale)?.syntheticFrom;
    final synthetic =
        from == null ? '' : ' (no column of its own, copied from ${from.code})';
    final out = StringBuffer(header)
      ..writeln('# ruff: noqa')
      ..writeln('"""Messages of the sheet "${pyDocText(scope.sheetTitle, '')}"'
          ' in ${locale.code}$synthetic.')
      ..writeln()
      ..writeln('${fallbacks.length} of ${scope.messages.length} messages '
          'use a fallback text.')
      ..writeln('"""')
      ..writeln()
      ..writeln('from __future__ import annotations')
      ..writeln()
      ..write(names.import)
      ..writeln('from types import MappingProxyType as _MappingProxyType')
      ..writeln();
    if (imports.isNotEmpty) {
      out.writeln('from .._runtime import ${imports.join(', ')}');
    }
    out
      ..writeln('from . import $base')
      ..writeln()
      ..writeln('__all__ = [${pyString(className)}, "LOCALIZATION"]')
      ..writeln()
      ..writeln()
      ..writeln('class $className($base):')
      ..writeln('    """${pyDocText(scope.sheetTitle, '')} in '
          '${locale.code}."""')
      ..writeln()
      ..writeln('    __slots__ = ()')
      ..writeln()
      ..writeln('    LOCALE = ${pyString(locale.code)}');
    if (translations.isEmpty) {
      out.writeln('    TEMPLATES = _MappingProxyType({})');
    } else {
      out.writeln('    TEMPLATES = _MappingProxyType(');
      out.writeln('        {');
      for (final MapEntry(:key, :value) in translations.entries) {
        out.writeln(
            '            ${pyString(key.key)}: ${pyString(value.raw)},');
      }
      out
        ..writeln('        }')
        ..writeln('    )');
    }
    out.writeln('    FALLBACK_KEYS = ${names('frozenset')}('
        '${fallbacks.isEmpty ? '' : pyStringTuple(fallbacks)})');
    out
      ..write(methods)
      ..writeln()
      ..writeln()
      ..writeln('#: The (stateless) instance returned by ``get()``.')
      ..writeln('LOCALIZATION = $className()');
    return out.toString();
  }

  void _writeImplementation(
    StringBuffer out,
    Message message,
    Translation translation,
    Set<String> used,
    _Builtins names,
  ) {
    final name = pyMessageName(message.key);
    final str = names('str');
    if (message.hasPlaceholders) {
      out.writeln('    def $name(self, *, ${_parameters(message, names)}) '
          '-> $str:');
    } else {
      out
        ..writeln('    @${names('property')}')
        ..writeln('    def $name(self) -> $str:');
    }
    final body = _Body(message, used);
    final result = body.expression(translation.ast, 2);
    for (final line in body.lines) {
      out.writeln(line);
    }
    out.writeln('        return $result');
  }
}

/// How the classes of a scope refer to [PythonEmitter.classBuiltins]: by
/// name, or as `_builtins.<name>` when a message of the scope has that name
/// (it would hide the builtin in the class body and, for type checkers, in
/// the annotations of every method).
final class _Builtins {
  _Builtins(Scope scope)
      : shadowed = {
          for (final m in scope.messages) pyMessageName(m.key),
        }.intersection(PythonEmitter.classBuiltins);

  final Set<String> shadowed;

  String call(String builtin) =>
      shadowed.contains(builtin) ? '_builtins.$builtin' : builtin;

  /// The import the aliases need ('' when there are none).
  String get import => shadowed.isEmpty ? '' : 'import builtins as _builtins\n';
}

/// Generates the statements and the result expression of one method.
///
/// Plurals and selects become `if` / `elif` chains assigning a temporary
/// (`_t0`), so only the chosen branch is rendered; everything else is an
/// f-string.
final class _Body {
  _Body(this.message, this.used);

  final Message message;

  /// Runtime names the code uses (`_to_str`, `_plural_case`,
  /// `_select_case`, `_rule` = the plural function of the locale).
  final Set<String> used;

  final List<String> lines = [];
  int _cases = 0;
  int _temps = 0;

  String _parameter(String placeholder) => pyParameterName(placeholder);

  /// Appends the statements [message] needs at [depth] (4 spaces each) and
  /// returns its value as an expression.
  String expression(IcuMessage icu, int depth) {
    final segments = <Object>[]; // String text | _Expr
    for (final part in icu.parts) {
      switch (part) {
        case IcuText(:final text):
          if (segments.isNotEmpty && segments.last is String) {
            segments.last = '${segments.last}$text';
          } else {
            segments.add(text);
          }
        case IcuArgument(:final name):
          used.add('_to_str');
          segments.add(_Expr('_to_str(${_parameter(name)})'));
        case IcuPlural():
          segments.add(_Expr(_plural(part, depth)));
        case IcuSelect():
          segments.add(_Expr(_select(part, depth)));
      }
    }
    if (segments.isEmpty) return '""';
    if (segments.length == 1) {
      return switch (segments.single) {
        final String text => pyString(text),
        final _Expr e => e.code,
        _ => throw StateError('unreachable'),
      };
    }
    final f = StringBuffer('f"');
    for (final segment in segments) {
      switch (segment) {
        case final String text:
          f.write(pyFStringText(text));
        case final _Expr e:
          f.write('{${e.code}}');
      }
    }
    f.write('"');
    return f.toString();
  }

  String _plural(IcuPlural plural, int depth) {
    final cases = plural.cases;
    final other = cases[PluralCategory.other];
    if (other == null) {
      throw StateError('${message.key}: plural without "other"');
    }
    final selector = '_c${_cases++}';
    final temp = '_t${_temps++}';
    final ind = '    ' * depth;
    if (cases.length == 1) {
      lines.add('$ind$temp = ${expression(other, depth)}');
      return temp;
    }
    used.addAll(['_plural_case', '_rule']);
    lines.add('$ind$selector = _plural_case('
        '${_parameter(plural.argument)}, _rule, '
        '${pyStringTuple(cases.keys.map((c) => c.name))})');
    _branches(
      [
        for (final MapEntry(:key, :value) in cases.entries)
          if (key != PluralCategory.other) (key.name, value),
      ],
      other,
      selector,
      temp,
      depth,
    );
    return temp;
  }

  String _select(IcuSelect select, int depth) {
    // Like a Dart map literal: a later duplicate case wins, source order of
    // first appearance is kept.
    final cases = <String, IcuMessage>{};
    for (final branch in select.branches) {
      cases[branch.value] = branch.message;
    }
    final other = cases['other'];
    if (other == null) {
      throw StateError('${message.key}: select without "other"');
    }
    final selector = '_c${_cases++}';
    final temp = '_t${_temps++}';
    final ind = '    ' * depth;
    if (cases.length == 1) {
      lines.add('$ind$temp = ${expression(other, depth)}');
      return temp;
    }
    used.add('_select_case');
    lines.add('$ind$selector = _select_case('
        '${_parameter(select.argument)}, ${pyStringTuple(cases.keys)})');
    _branches(
      [
        for (final MapEntry(:key, :value) in cases.entries)
          if (key != 'other') (key, value),
      ],
      other,
      selector,
      temp,
      depth,
    );
    return temp;
  }

  void _branches(
    List<(String, IcuMessage)> branches,
    IcuMessage other,
    String selector,
    String temp,
    int depth,
  ) {
    final ind = '    ' * depth;
    var first = true;
    for (final (value, branch) in branches) {
      lines.add('$ind${first ? 'if' : 'elif'} $selector == '
          '${pyString(value)}:');
      first = false;
      final result = expression(branch, depth + 1);
      lines.add('$ind    $temp = $result');
    }
    lines.add('${ind}else:');
    final result = expression(other, depth + 1);
    lines.add('$ind    $temp = $result');
  }
}

final class _Expr {
  const _Expr(this.code);
  final String code;
}
