/// Identifier helpers: case conversion, gen-l10n compatible class names,
/// reserved words and identifier validation per target.
library;

import 'emitter.dart';
import 'model.dart';

final RegExp _wordPattern = RegExp(
  // An upper-case run not followed by lower case (acronym: `HTTP` in
  // `HTTPServer`), a capitalized or lower-case word, or a digit run; digits
  // stick to the preceding word (`step2`).
  '[A-Z]+(?![a-z])[0-9]*|[A-Z]?[a-z]+[0-9]*|[0-9]+',
);

/// Splits [input] into words at non-alphanumeric characters and at case
/// changes: `drawerTooltipHelp` -> `[drawer, Tooltip, Help]`, `HTTPServer`
/// -> `[HTTP, Server]`, `sign_up` -> `[sign, up]`, `step2Title` ->
/// `[step2, Title]`.
List<String> splitWords(String input) => [
      for (final m in _wordPattern.allMatches(input)) m.group(0)!,
    ];

String _capitalize(String word) => word.isEmpty
    ? word
    : word[0].toUpperCase() + word.substring(1).toLowerCase();

/// `lowerCamelCase`: `sign_up` -> `signUp`, `HTTP_server` -> `httpServer`.
String toCamelCase(String input) {
  final words = splitWords(input);
  if (words.isEmpty) return '';
  return words.first.toLowerCase() + words.skip(1).map(_capitalize).join();
}

/// `UpperCamelCase`: `sign_up` -> `SignUp`.
String toPascalCase(String input) => splitWords(input).map(_capitalize).join();

/// `snake_case`: `drawerTooltipHelp` -> `drawer_tooltip_help`,
/// `openAIKey` -> `open_ai_key`, `step2Title` -> `step2_title`.
String toSnakeCase(String input) =>
    splitWords(input).map((w) => w.toLowerCase()).join('_');

/// The class-name stem the previous generator passed to gen-l10n as
/// `--output-class` (without the `Localization` suffix): the scope split at
/// `_`, every part capitalized with the rest lower-cased
/// (`sign_up` -> `SignUp`, `myAPI` -> `Myapi`, `backend_2026` ->
/// `Backend2026`). Reproduced exactly so class names do not change.
String legacyPascalCase(String scope) => scope
    .split('_')
    .map(
      (word) => word.length < 2
          ? word.toUpperCase()
          : word[0].toUpperCase() + word.substring(1).toLowerCase(),
    )
    .join();

/// The Dart class of a scope: `chat` -> `ChatLocalization`, `sign_up` ->
/// `SignUpLocalization` (see [legacyPascalCase]).
String scopeClassName(String scope) => '${legacyPascalCase(scope)}Localization';

/// The Dart class of a scope for one locale, as gen-l10n names it:
/// `ChatLocalizationPtBr` (see [LocaleTag.camelCase]).
String localeClassName(String scope, LocaleTag locale) =>
    '${scopeClassName(scope)}${locale.camelCase}';

/// Dart reserved words: never usable as identifiers.
const Set<String> dartReservedWords = {
  'assert', 'break', 'case', 'catch', 'class', 'const', 'continue', //
  'default', 'do', 'else', 'enum', 'extends', 'false', 'final', 'finally',
  'for', 'if', 'in', 'is', 'new', 'null', 'rethrow', 'return', 'super',
  'switch', 'this', 'throw', 'true', 'try', 'var', 'void', 'while', 'with',
};

/// Dart built-in identifiers: usable as member and parameter names, but not
/// as type (class) names.
const Set<String> dartBuiltInIdentifiers = {
  'abstract', 'as', 'covariant', 'deferred', 'dynamic', 'export', //
  'extension', 'external', 'factory', 'Function', 'get', 'implements',
  'import', 'interface', 'late', 'library', 'mixin', 'operator', 'part',
  'required', 'set', 'static', 'typedef',
};

/// Members every generated Dart localization class already has (gen-l10n's
/// API and `Object`'s): a message key must not collide with them.
const Set<String> dartClassMembers = {
  'localeName', 'of', 'delegate', 'localizationsDelegates', //
  'supportedLocales', 'hashCode', 'runtimeType', 'toString', 'noSuchMethod',
};

/// Message keys the generated Dart classes cannot have, whatever the options,
/// and why: the key would become a member of the localization class and hide
/// a name its code uses (`@override`, the `intl` import prefix, the types of
/// placeholders and of `localizationsDelegates`).
const Map<String, String> dartReservedMessageNames = {
  'intl': 'would hide the `intl` import prefix the generated code uses',
  'override': 'would hide the `@override` annotation',
  'int': 'would hide the type `int` of numeric placeholders',
  'num': 'would hide the type `num` of numeric placeholders',
  'double': 'would hide the type `double` of numeric placeholders',
  'dynamic': 'would hide the type `dynamic` of `localizationsDelegates`',
};

/// Placeholder names the generated Dart methods cannot have, and why: the
/// parameter would hide a name the method body uses.
const Map<String, String> dartReservedPlaceholderNames = {
  'intl': 'would hide the `intl` import prefix used by plurals and selects',
  'localeName': 'would hide the `localeName` member that plurals pass to '
      'intl',
};

/// gen-l10n's temporaries of plurals and selects (`_temp0`): a placeholder
/// of that name would be shadowed by them.
final RegExp dartTemporaryName = RegExp(r'^_temp[0-9]+$');

/// Message keys that break a TypeScript dictionary although they are valid
/// property names, and why.
const Map<String, String> tsReservedMessageNames = {
  'then': 'would make every dictionary a "thenable": the Promise of a lazy '
      'loader would never resolve to it',
};

/// JavaScript / TypeScript reserved words (ECMAScript 2023 reserved and
/// strict-mode reserved words, plus `arguments` and `eval`, which cannot be
/// bound in strict code). Invalid as variable or parameter names.
const Set<String> jsReservedWords = {
  'await', 'break', 'case', 'catch', 'class', 'const', 'continue', //
  'debugger', 'default', 'delete', 'do', 'else', 'enum', 'export',
  'extends', 'false', 'finally', 'for', 'function', 'if', 'import', 'in',
  'instanceof', 'new', 'null', 'return', 'super', 'switch', 'this', 'throw',
  'true', 'try', 'typeof', 'var', 'void', 'while', 'with', 'yield', 'let',
  'static', 'implements', 'interface', 'package', 'private', 'protected',
  'public', 'arguments', 'eval',
};

/// Property names that misbehave on plain JavaScript objects (prototype
/// pollution, shadowing of `Object.prototype`). Invalid as message keys.
const Set<String> jsObjectMembers = {
  '__proto__', 'constructor', 'prototype', 'hasOwnProperty', //
  'isPrototypeOf', 'propertyIsEnumerable', 'toLocaleString', 'toString',
  'valueOf', '__defineGetter__', '__defineSetter__', '__lookupGetter__',
  '__lookupSetter__',
};

/// Python keywords (3.9 - 3.13). Soft keywords (`match`, `case`, `type`,
/// `_`) are valid identifiers and not listed.
const Set<String> pythonKeywords = {
  'False', 'None', 'True', 'and', 'as', 'assert', 'async', 'await', //
  'break', 'class', 'continue', 'def', 'del', 'elif', 'else', 'except',
  'finally', 'for', 'from', 'global', 'if', 'import', 'in', 'is', 'lambda',
  'nonlocal', 'not', 'or', 'pass', 'raise', 'return', 'try', 'while',
  'with', 'yield',
};

/// What a name is used for in generated code.
enum IdentifierRole {
  /// A message: Dart getter/method, TS property, Python method/property.
  message,

  /// A placeholder: a function parameter in every target.
  parameter,

  /// A scope: Dart class stem and directory, TS directory, Python package.
  scope,
}

/// The name [source] gets in [target] code for [role].
///
/// * Dart and TypeScript keep message keys and placeholder names as they are
///   in the sheet (camelCase).
/// * Python uses snake_case for messages and placeholders.
/// * Scopes keep their sanitized (snake) name everywhere; the Dart class is
///   [scopeClassName].
String targetName(Target target, IdentifierRole role, String source) =>
    switch ((target, role)) {
      (Target.python, IdentifierRole.message) => toSnakeCase(source),
      (Target.python, IdentifierRole.parameter) => toSnakeCase(source),
      _ => source,
    };

/// Why a name is not usable.
typedef IdentifierProblem = ({bool reserved, String reason});

final RegExp _asciiIdentifier = RegExp(r'^[A-Za-z_][A-Za-z0-9_]*$');

/// Checks the target-side [name] (already converted with [targetName]) for
/// [role] in [target]; `null` when it is fine.
///
/// [reserved] adds target names that the emitter itself uses (e.g. members
/// of its metadata API) and therefore must not be taken by the sheet;
/// [reservedByRole] adds names reserved for one role only.
IdentifierProblem? checkIdentifier(
  String name,
  Target target,
  IdentifierRole role, {
  Set<String> reserved = const {},
  Map<IdentifierRole, Set<String>> reservedByRole = const {},
}) {
  if (name.isEmpty) return (reserved: false, reason: 'is empty');
  if (RegExp('^[0-9]').hasMatch(name)) {
    return (reserved: false, reason: 'starts with a digit');
  }
  if (!_asciiIdentifier.hasMatch(name)) {
    return (
      reserved: false,
      reason: 'contains characters other than A-Z, '
          'a-z, 0-9 and _'
    );
  }
  if (reserved.contains(name) ||
      (reservedByRole[role]?.contains(name) ?? false)) {
    return (
      reserved: true,
      reason: 'is used by the generated ${target.id} '
          'code'
    );
  }
  switch (target) {
    case Target.dart:
      if (dartReservedWords.contains(name)) {
        return (reserved: true, reason: 'is a Dart reserved word');
      }
      switch (role) {
        case IdentifierRole.message:
          // gen-l10n's _isValidGetterAndMethodName.
          if (name.startsWith('_')) {
            return (
              reserved: false,
              reason: 'starts with "_" (private in '
                  'Dart)'
            );
          }
          if (RegExp('^[A-Z]').hasMatch(name)) {
            return (
              reserved: false,
              reason: 'starts with an upper-case '
                  'letter (gen-l10n requires lower camelCase keys)'
            );
          }
          if (dartClassMembers.contains(name)) {
            return (
              reserved: true,
              reason: 'collides with a member of the '
                  'generated localization class'
            );
          }
          if (dartReservedMessageNames[name] case final String reason) {
            return (reserved: true, reason: reason);
          }
        case IdentifierRole.parameter:
          if (dartReservedPlaceholderNames[name] case final String reason) {
            return (reserved: true, reason: reason);
          }
          if (dartTemporaryName.hasMatch(name)) {
            return (
              reserved: true,
              reason: 'is the name of a temporary variable of the generated '
                  'methods'
            );
          }
        case IdentifierRole.scope:
          final stem = legacyPascalCase(name);
          if (dartBuiltInIdentifiers.contains(stem)) {
            return (
              reserved: true,
              reason: 'gives the class name "$stem", '
                  'a Dart built-in identifier'
            );
          }
      }
    case Target.ts:
      switch (role) {
        case IdentifierRole.message:
          if (jsObjectMembers.contains(name)) {
            return (reserved: true, reason: 'is a JavaScript Object member');
          }
          if (tsReservedMessageNames[name] case final String reason) {
            return (reserved: true, reason: reason);
          }
        case IdentifierRole.parameter || IdentifierRole.scope:
          if (jsReservedWords.contains(name)) {
            return (reserved: true, reason: 'is a JavaScript reserved word');
          }
      }
    case Target.python:
      if (pythonKeywords.contains(name)) {
        return (reserved: true, reason: 'is a Python keyword');
      }
      if (role == IdentifierRole.message && name.startsWith('__')) {
        return (
          reserved: false,
          reason: 'starts with "__" (name mangling '
              'in Python)'
        );
      }
  }
  return null;
}

/// Groups [names] by [convert]ed form and returns the groups with more than
/// one distinct source name: `{'foo_bar': ['fooBar', 'foo_bar']}`.
Map<String, List<String>> findCollisions(
  Iterable<String> names,
  String Function(String name) convert,
) {
  final groups = <String, List<String>>{};
  for (final name in names) {
    final list = groups[convert(name)] ??= [];
    if (!list.contains(name)) list.add(name);
  }
  return {
    for (final MapEntry(:key, :value) in groups.entries)
      if (value.length > 1) key: value,
  };
}
