import 'package:test/test.dart';

import 'sheety.dart';

void main() => group('buildLocalizationPrompt', () {
      test('spells out every language by name and endonym', () {
        final (:prompt, schema: _) = buildLocalizationPrompt(
          label: 'greeting',
          source: 'Hello',
          languages: const ['uk', 'de'],
        );
        expect(prompt, contains('uk — Ukrainian (українська)'));
        expect(prompt, contains('de — German (Deutsch)'));
      });

      test('warns the model that uk is not United Kingdom', () {
        final (:prompt, schema: _) = buildLocalizationPrompt(
          label: 'greeting',
          source: 'Hello',
          languages: const ['uk'],
        );
        expect(prompt, contains('NOT English'));
        expect(prompt, contains('en_GB'));
        expect(prompt, contains('LANGUAGE codes, never country codes'));
        expect(prompt, contains('Never answer in English'));
      });

      test('carries context and placeholders into the prompt', () {
        final (:prompt, schema: _) = buildLocalizationPrompt(
          label: 'welcome',
          source: 'Hello, {name}!',
          description: 'Greeting on the main screen',
          meta: '{name}: String',
          languages: const ['ru'],
        );
        expect(prompt, contains('label: welcome'));
        expect(prompt, contains('source_text: Hello, {name}!'));
        expect(prompt, contains('source_language: en — English'));
        expect(prompt, contains('Greeting on the main screen'));
        expect(prompt, contains('{name}: String'));
      });

      test('names a non-English source language in the prompt and schema', () {
        final (:prompt, :schema) = buildLocalizationPrompt(
          label: 'greeting',
          source: 'Привет',
          sourceCode: 'ru',
          languages: const ['de'],
        );
        // The source language is spelled out for the model...
        expect(prompt, contains('source_language: ru — Russian (русский)'));
        expect(prompt, contains('source_text: Привет'));
        // ...and the English-specific instructions now follow the source.
        expect(prompt, contains('Never answer in Russian for a non-Russian'));
        expect(prompt, isNot(contains('Never answer in English')));
        // The target-language schema describes a translation of the source.
        final localization = (schema['properties']!
            as Map<String, Object?>)['localization']! as Map<String, Object?>;
        final props = localization['properties']! as Map<String, Object?>;
        final de = props['de']! as Map<String, Object?>;
        final text =
            (de['properties']! as Map<String, Object?>)['text']! as Map;
        expect(text['description'], contains('source_text into German'));
      });

      test('defaults the source language to English', () {
        final (:prompt, schema: _) = buildLocalizationPrompt(
          label: 'greeting',
          source: 'Hello',
          languages: const ['uk'],
        );
        expect(prompt, contains('source_language: en — English'));
        expect(prompt, contains('Never answer in English for a non-English'));
      });

      test('schema requires exactly the requested languages', () {
        final (prompt: _, :schema) = buildLocalizationPrompt(
          label: 'greeting',
          source: 'Hello',
          languages: const ['uk', 'ru'],
        );
        final localization = (schema['properties']!
            as Map<String, Object?>)['localization']! as Map<String, Object?>;
        expect(localization['required'], <String>['uk', 'ru']);
        expect(localization['additionalProperties'], isFalse);
        final props = localization['properties']! as Map<String, Object?>;
        expect(props.keys, <String>['uk', 'ru']);

        // The language name is repeated inside the schema itself, where the
        // model cannot miss it.
        final uk = props['uk']! as Map<String, Object?>;
        final text =
            (uk['properties']! as Map<String, Object?>)['text']! as Map;
        expect(text['description'], contains('Ukrainian'));
      });

      test('deduplicates languages, preserving order', () {
        final (:prompt, :schema) = buildLocalizationPrompt(
          label: 'greeting',
          source: 'Hello',
          languages: const ['uk', 'ru', 'uk', ' ', 'de'],
        );
        final localization = (schema['properties']!
            as Map<String, Object?>)['localization']! as Map<String, Object?>;
        expect(localization['required'], <String>['uk', 'ru', 'de']);
        expect(prompt, isNot(contains('  — ')));
      });

      test('rejects incomplete input', () {
        expect(
          () => buildLocalizationPrompt(
            label: '  ',
            source: 'Hello',
            languages: const ['uk'],
          ),
          throwsArgumentError,
        );
        expect(
          () => buildLocalizationPrompt(
            label: 'greeting',
            source: '',
            languages: const ['uk'],
          ),
          throwsArgumentError,
        );
        expect(
          () => buildLocalizationPrompt(
            label: 'greeting',
            source: 'Hello',
            languages: const [],
          ),
          throwsArgumentError,
        );
      });
    });
