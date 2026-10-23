import 'package:test/test.dart';

import '../sheety.dart';

void main() {
  group('case conversion', () {
    test('splitWords', () {
      expect(splitWords('drawerTooltipHelp'), ['drawer', 'Tooltip', 'Help']);
      expect(splitWords('HTTPServer'), ['HTTP', 'Server']);
      expect(splitWords('sign_up'), ['sign', 'up']);
      expect(splitWords('step2Title'), ['step2', 'Title']);
      expect(splitWords('backend-2026-09-23'), ['backend', '2026', '09', '23']);
      expect(splitWords('openAIKey'), ['open', 'AI', 'Key']);
    });

    test('snake, camel, Pascal', () {
      expect(toSnakeCase('drawerTooltipHelp'), 'drawer_tooltip_help');
      expect(toSnakeCase('openAIKey'), 'open_ai_key');
      expect(toSnakeCase('billing_help_message2'), 'billing_help_message2');
      expect(toSnakeCase('step2Title'), 'step2_title');
      expect(toCamelCase('sign_up'), 'signUp');
      expect(toCamelCase('HTTP_server'), 'httpServer');
      expect(toPascalCase('sign_up'), 'SignUp');
      expect(toPascalCase('drawerTooltipHelp'), 'DrawerTooltipHelp');
    });
  });

  group('gen-l10n compatible class names', () {
    test('scope classes reproduce the previous generator', () {
      expect(scopeClassName('chat'), 'ChatLocalization');
      expect(scopeClassName('sign_up'), 'SignUpLocalization');
      expect(scopeClassName('backend_2025_01_15_regions'),
          'Backend20250115RegionsLocalization');
      // The previous generator lower-cased the rest of every part.
      expect(legacyPascalCase('myAPI'), 'Myapi');
      expect(legacyPascalCase('a_b'), 'AB');
    });

    test('locale subclasses', () {
      expect(localeClassName('chat', LocaleTag.parse('pt_BR')),
          'ChatLocalizationPtBr');
      expect(localeClassName('sign_up', LocaleTag.parse('zh_Hant_TW')),
          'SignUpLocalizationZhHantTw');
    });
  });

  group('checkIdentifier', () {
    IdentifierProblem? check(
      String name,
      Target target, [
      IdentifierRole role = IdentifierRole.message,
    ]) =>
        checkIdentifier(name, target, role);

    test('valid names', () {
      for (final target in Target.values) {
        expect(check('drawerTooltipHelp', target), isNull);
        expect(check('count', target, IdentifierRole.parameter), isNull);
        expect(check('sign_up', target, IdentifierRole.scope), isNull);
      }
    });

    test('leading digit, empty, bad characters', () {
      for (final target in Target.values) {
        expect(check('2fa', target)?.reserved, isFalse);
        expect(check('', target)?.reason, 'is empty');
        expect(check('a-b', target), isNotNull);
        expect(check('ünicode', target), isNotNull);
      }
    });

    test('Dart', () {
      expect(check('class', Target.dart)?.reserved, isTrue);
      expect(check('get', Target.dart), isNull); // built-in identifier
      expect(check('localeName', Target.dart)?.reserved, isTrue);
      expect(check('Title', Target.dart), isNotNull);
      expect(check('_private', Target.dart), isNotNull);
      expect(check('Title', Target.dart, IdentifierRole.parameter), isNull);
      expect(check('switch', Target.dart, IdentifierRole.parameter)?.reserved,
          isTrue);
    });

    test('Dart scopes only name files and `<Stem>Localization` classes', () {
      // 0.6.0 generated these: `DefaultLocalization`, `NewLocalization`,
      // `lookupSwitchLocalization`, `FunctionLocalization`, `default/`.
      for (final name in [
        'default',
        'new',
        'switch',
        'Function',
        'function',
        'class',
        'get',
      ]) {
        expect(check(name, Target.dart, IdentifierRole.scope), isNull,
            reason: name);
      }
      expect(check('_1', Target.dart, IdentifierRole.scope)?.reason,
          contains('"1Localization"'));
    });

    test('TypeScript and Python scopes still reject their keywords', () {
      // `export * as <scope>` and the Python package name are identifiers.
      for (final name in ['default', 'new', 'switch', 'function']) {
        expect(check(name, Target.ts, IdentifierRole.scope)?.reserved, isTrue,
            reason: name);
      }
      for (final name in ['class', 'def', 'None', 'import']) {
        expect(
          check(name, Target.python, IdentifierRole.scope)?.reserved,
          isTrue,
          reason: name,
        );
      }
      expect(check('Function', Target.ts, IdentifierRole.scope), isNull);
      expect(check('default', Target.python, IdentifierRole.scope), isNull);
    });

    test('Dart: names the generated code needs', () {
      for (final key in [
        'intl',
        'override',
        'int',
        'num',
        'double',
        'dynamic'
      ]) {
        expect(check(key, Target.dart)?.reserved, isTrue, reason: key);
        // Fine as placeholders (except intl) and in the other targets.
        expect(check(key, Target.ts), isNull, reason: key);
      }
      expect(check('key', Target.dart), isNull); // format() uses this.key
      expect(check('args', Target.dart), isNull);
      for (final name in ['intl', 'localeName', '_temp0', '_temp12']) {
        expect(check(name, Target.dart, IdentifierRole.parameter)?.reserved,
            isTrue,
            reason: name);
      }
      expect(check('int', Target.dart, IdentifierRole.parameter), isNull);
      expect(check('_tempo', Target.dart, IdentifierRole.parameter), isNull);
    });

    test('TypeScript: `then` would make dictionaries thenables', () {
      expect(check('then', Target.ts)?.reserved, isTrue);
      expect(check('then', Target.ts)?.reason, contains('thenable'));
      expect(check('then', Target.ts, IdentifierRole.parameter), isNull);
      for (final key in [
        '__proto__',
        'constructor',
        'toString',
        'valueOf',
        'hasOwnProperty'
      ]) {
        expect(check(key, Target.ts)?.reserved, isTrue, reason: key);
      }
    });

    test('reserved names of one role only', () {
      IdentifierProblem? role(IdentifierRole r) => checkIdentifier(
            'format',
            Target.dart,
            r,
            reservedByRole: {
              IdentifierRole.message: {'format'},
            },
          );
      expect(role(IdentifierRole.message)?.reserved, isTrue);
      expect(role(IdentifierRole.parameter), isNull);
    });

    test('TypeScript', () {
      // Reserved words are fine as property names...
      expect(check('delete', Target.ts), isNull);
      expect(check('__proto__', Target.ts)?.reserved, isTrue);
      expect(check('constructor', Target.ts)?.reserved, isTrue);
      // ...but not as parameter names.
      expect(check('delete', Target.ts, IdentifierRole.parameter)?.reserved,
          isTrue);
    });

    test('Python', () {
      expect(check('continue', Target.python)?.reserved, isTrue);
      expect(check('None', Target.python, IdentifierRole.parameter)?.reserved,
          isTrue);
      expect(check('match', Target.python), isNull); // soft keyword
      expect(check('__init__', Target.python), isNotNull);
    });

    test('extra reserved names of an emitter', () {
      expect(
        checkIdentifier('entries', Target.dart, IdentifierRole.message,
            reserved: {'entries'})?.reserved,
        isTrue,
      );
    });
  });

  group('targetName and collisions', () {
    test('Python uses snake_case for messages and parameters', () {
      expect(targetName(Target.python, IdentifierRole.message, 'fooBar'),
          'foo_bar');
      expect(targetName(Target.python, IdentifierRole.parameter, 'n'), 'n');
      expect(
          targetName(Target.dart, IdentifierRole.message, 'fooBar'), 'fooBar');
      expect(targetName(Target.ts, IdentifierRole.scope, 'sign_up'), 'sign_up');
    });

    test('findCollisions', () {
      expect(
        findCollisions(['fooBar', 'foo_bar', 'baz', 'fooBar'], toSnakeCase),
        {
          'foo_bar': ['fooBar', 'foo_bar'],
        },
      );
      expect(findCollisions(['a', 'b'], toSnakeCase), isEmpty);
    });
  });
}
