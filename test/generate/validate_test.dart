import 'package:sheety_localization/sheety_localization.dart';
import 'package:test/test.dart';

import 'helpers.dart';

const _header = ['label', 'description', 'meta', 'en', 'ru'];

List<Diagnostic> validate(
  List<List<Object?>> rows, {
  List<Object?> header = _header,
  Iterable<Target> targets = const [],
  String title = 'app',
}) {
  final result = readCatalog(sheet(title, [header, ...rows]));
  expect(result.diagnostics.where((d) => d.isError), isEmpty);
  return validateCatalog(result.catalog, targets: targets);
}

Iterable<Diagnostic> only(List<Diagnostic> d, DiagnosticCode code) =>
    d.where((x) => x.code == code);

void main() {
  test('the fixture has no errors', () {
    final read = readCatalog(loadSnapshot('test/fixtures/basic_snapshot.json'));
    final diagnostics = validateCatalog(read.catalog, targets: Target.values);
    expect(diagnostics.where((d) => d.isError), isEmpty,
        reason: diagnostics.join('\n'));
    expect(codes(diagnostics).toSet(), {'fallback'});
  });

  group('placeholder-mismatch', () {
    test('missing and extra placeholders', () {
      final d = validate([
        ['a', '', '', 'Hi {name}', 'Привет'],
        ['b', '', '', 'Hi', 'Привет {name}'],
        ['c', '', '', 'Hi {name}', 'Привет {name}'],
      ]);
      final mismatch = only(d, DiagnosticCode.placeholderMismatch).toList();
      expect(mismatch.map((x) => (x.key, x.row, x.column, x.locale)), [
        ('a', 2, 'E', 'ru'),
        ('b', 3, 'E', 'ru'),
      ]);
      expect(mismatch.first.message, contains('misses "name"'));
      expect(mismatch.last.message, contains('uses "name"'));
      expect(mismatch.first.isError, isTrue);
    });
  });

  group('plurals', () {
    test('missing CLDR categories (=1 counts as one)', () {
      final d = validate([
        [
          'a',
          '',
          '',
          '{n, plural, =1{one} other{many}}',
          '{n, plural, one{x} other{y}}',
        ],
      ]);
      final missing = only(d, DiagnosticCode.pluralMissingCategory).single;
      expect(missing.locale, 'ru');
      expect(missing.message, contains('"few", "many"'));
      expect(missing.severity, Severity.warning);
    });

    test('duplicate cases', () {
      final d = validate([
        [
          'a',
          '',
          '',
          '{n, plural, =1{a} one{b} other{c}}',
          '{n, plural, one{x} few{x} many{x} other{y}}',
        ],
        [
          'b',
          '',
          '',
          '{g, select, a{x} a{y} other{z}}',
          '{g, select, a{x} other{z}}',
        ],
      ]);
      expect(only(d, DiagnosticCode.pluralDuplicateCase).single.locale, 'en');
      final select = only(d, DiagnosticCode.selectDuplicateCase).single;
      expect((select.key, select.isError), ('b', true));
    });
  });

  group('tags', () {
    test('different and unbalanced tags', () {
      final d = validate([
        ['a', '', '', 'Read <b>this</b>', 'Читай <i>это</i>'],
        ['b', '', '', 'Read <b>this</b>', 'Читай <b>это'],
        ['c', '', '', 'Read <b>this</b>', 'Читай <b>это</b>'],
        ['d', '', '', 'A <br/> B', 'А <br/> Б'],
      ]);
      final tags = only(d, DiagnosticCode.tagMismatch).toList();
      expect(tags.map((t) => t.key), ['a', 'b', 'b']);
      expect(tags[2].message, 'Tag <b> is never closed');
    });

    test('branches are balanced separately', () {
      final d = validate([
        [
          'a',
          '',
          '',
          '{n, plural, one{<b>1</b>} other{<b>{n}</b>}}',
          '{n, plural, one{<b>1} few{x} many{x} other{<b>{n}</b>}}',
        ],
      ]);
      expect(only(d, DiagnosticCode.tagMismatch).single.message,
          'Tag <b> is never closed');
    });
  });

  test('unused declared placeholders', () {
    final d = validate([
      ['a', '', '{"placeholders": {"x": {}}}', 'Hi', 'Привет'],
    ]);
    final unused = only(d, DiagnosticCode.unusedPlaceholder).single;
    expect((unused.key, unused.column), ('a', 'C'));
  });

  test('fallback counts per locale', () {
    final read = readCatalog(
      sheet('app', [
        ['label', 'description', 'meta', 'en', 'ru', 'pt_BR'],
        ['a', '', '', 'A', '', 'A-br'],
        ['b', '', '', 'B', '', ''],
        ['c', '', '', 'C', 'Ц', 'C-br'],
      ]),
    );
    final d = only(validateCatalog(read.catalog), DiagnosticCode.fallback)
        .map((x) => (x.locale, x.message.split(' ').first))
        .toList();
    expect(d, [('ru', '2'), ('pt_BR', '1'), ('pt', '1')]);
  });

  group('identifiers per target', () {
    test('reserved words and invalid keys', () {
      final d = validate(
        [
          ['class', '', '', 'A', 'А'],
          ['continue', '', '', 'A', 'А'],
          ['Title', '', '', 'A', 'А'],
          ['constructor', '', '', 'A', 'А'],
          ['ok', '', '', 'Hi {delete}', 'Привет {delete}'],
        ],
        targets: Target.values,
      );
      String summary(Diagnostic x) => '${x.target} ${x.code.id} ${x.key}';
      expect(
        d.where((x) => x.target != null).map(summary).toList(),
        [
          'dart reserved-word class',
          'dart reserved-word continue',
          'dart invalid-identifier Title',
          'ts reserved-word constructor',
          'ts reserved-word ok',
          'python reserved-word class',
          'python reserved-word continue',
        ],
      );
    });

    test('collisions after snake_case conversion', () {
      final d = validate(
        [
          ['fooBar', '', '', 'A {userId}', 'А {userId}'],
          ['foo_bar', '', '', 'B {userId} {user_id}', 'Б {userId} {user_id}'],
        ],
        targets: [Target.python, Target.dart],
      );
      final collisions = only(d, DiagnosticCode.nameCollision).toList();
      expect(collisions.map((c) => (c.target, c.key)), [
        ('python', 'foo_bar'),
        ('python', 'foo_bar'),
      ]);
      expect(collisions.first.message, contains('"user_id"'));
    });

    test('scope names', () {
      final read = readCatalog([
        (
          title: '2fa',
          values: [
            _header,
            ['a', '', '', 'A', 'А'],
          ],
        ),
        (
          title: 'import',
          values: [
            _header,
            ['a', '', '', 'A', 'А'],
          ],
        ),
      ]);
      final d = validateIdentifiers(read.catalog, Target.python);
      expect(d.map((x) => (x.scope, x.code.id)), [
        ('2fa', 'invalid-identifier'),
        ('import', 'reserved-word'),
      ]);
      expect(
          validateIdentifiers(read.catalog, Target.dart).single.scope, '2fa');
    });

    test('scopes collide by every identifier a target derives', () {
      final read = readCatalog([
        for (final title in ['rate-us-2', 'rate_us2'])
          (
            title: title,
            values: [
              _header,
              ['a', '', '', 'A', 'А'],
            ],
          ),
      ]);
      expect([for (final s in read.catalog.scopes) s.name],
          ['rate_us_2', 'rate_us2']);
      // Python: the packages differ, the classes do not.
      final python = validateIdentifiers(read.catalog, Target.python);
      expect(python.single.code, DiagnosticCode.nameCollision);
      expect(
          python.single.message, contains('the class "RateUs2Localization"'));
      final dart = validateIdentifiers(read.catalog, Target.dart);
      expect(dart.single.message, contains('RateUs2Localization'));
      // TypeScript: directories and namespaces differ; the types live in the
      // scope's own module.
      expect(validateIdentifiers(read.catalog, Target.ts), isEmpty);
    });

    test('scopes differing only in case collide as directories', () {
      final read = readCatalog([
        for (final title in ['Chat', 'chat'])
          (
            title: title,
            values: [
              _header,
              ['a', '', '', 'A', 'А'],
            ],
          ),
      ]);
      for (final target in Target.values) {
        final d = validateIdentifiers(read.catalog, target);
        expect(d, hasLength(1), reason: target.id);
        expect(d.single.code, DiagnosticCode.nameCollision);
      }
    });
  });
}
