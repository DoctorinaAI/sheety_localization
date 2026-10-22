import 'package:flutter_test/flutter_test.dart';
import 'package:sheety_notes_localization/localization.dart';

void main() {
  // Every scope x every locale x every message, rendered with the examples
  // from the sheet's meta column.
  for (final scope in localizationScopes) {
    group(scope.name, () {
      for (final locale in scope.supportedLocales) {
        test('$locale', () {
          final l10n = scope.lookup(locale);
          for (final message in scope.messages) {
            final text = l10n.format(message.key, message.exampleArguments);
            expect(text, isNotEmpty, reason: '${scope.name}.${message.key}');
            // No placeholder left unrendered.
            for (final p in message.placeholders) {
              expect(text, isNot(contains('{${p.name}}')),
                  reason: '${scope.name}.${message.key} ($locale)');
            }
          }
          // Every message has a template in every locale (fallbacks too).
          expect(l10n.templates.keys,
              containsAll(scope.messages.map((m) => m.key)));
        });
      }
    });
  }

  test('typed API', () {
    final de = lookupAppLocalization(Locales.de);
    expect(de.notes(3), '3 Notizen');
    expect(de.format('greeting', {'name': 'Alice'}), 'Hallo, Alice!');
    // ar_EG has its own greeting only; the rest comes from ar, then en.
    final arEg = lookupAppLocalization(Locales.ar$EG);
    expect(arEg.fallbackKeys, contains('title'));
  });
}
