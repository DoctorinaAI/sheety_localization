// Imports the executable directly (not the package) so its own top-level
// helpers such as `$log` do not clash with the library's.
import '../bin/generate.dart';
import 'package:test/test.dart';

void main() {
  group('selectTemplateArb', () {
    test('prefers the English ARB when present', () {
      expect(
        selectTemplateArb(
          const ['/l10n/app/app_ru.arb', '/l10n/app/app_en.arb'],
          prefix: 'app',
        ),
        'app_en.arb',
      );
    });

    test('falls back to the first ARB by name for a non-English base', () {
      // A bucket whose base language is Russian: there is no `app_en.arb`, so
      // the template must be one of the ARBs that actually exist.
      expect(
        selectTemplateArb(
          const ['/l10n/app/app_uk.arb', '/l10n/app/app_ru.arb'],
          prefix: 'app',
        ),
        'app_ru.arb',
      );
    });

    test('honours a custom prefix', () {
      expect(
        selectTemplateArb(
          const ['/l10n/app/errors_de.arb', '/l10n/app/errors_en.arb'],
          prefix: 'errors',
        ),
        'errors_en.arb',
      );
    });

    test('falls back to the conventional English name when there are no ARBs',
        () {
      expect(selectTemplateArb(const [], prefix: 'app'), 'app_en.arb');
    });
  });
}
