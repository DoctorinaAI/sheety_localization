/// Prompt & JSON schema builder for the localization request.
library;

import 'dart:collection';
import 'dart:convert';

import 'language_names.dart';

/// Builds a strict prompt for a localization task.
/// - Comments are in English.
/// - Uses jsonEncode for safe inline JSON embedding.
/// - Uses StringBuffer with cascade operators for clarity and speed.
/// - Keeps soft-ish validation with explicit errors (same as original intent).
///
/// Every target language is spelled out by name, endonym and — for codes that
/// models routinely misread, such as `uk` — an explicit disambiguation note.
({String prompt, Map<String, Object?> schema}) buildLocalizationPrompt({
  required String label,
  required String en,
  required List<String> languages,
  String? description,
  String? meta, // keep as String? to avoid breaking callers; embed as-is
}) {
  // -- helpers ---------------------------------------------------------------

  /// Return trimmed string or null if empty.
  String? safeStr(String? v) => v == null || v.trim().isEmpty ? null : v.trim();

  /// Unique, order-preserving list of non-empty language codes.
  List<String> uniqLangs(Iterable<String> arr) => List<String>.unmodifiable(
        LinkedHashSet<String>.from(
          arr.map(safeStr).whereType<String>().where((s) => s.isNotEmpty),
        ),
      );

  // -- unpack & normalize ----------------------------------------------------
  final normLabel = safeStr(label);
  final normDesc = safeStr(description);
  final normEn = safeStr(en);
  final langs = uniqLangs(languages);
  final String? metaInline = safeStr(meta); // already a string; embed as-is

  // -- validation (explicit) -------------------------------------------------
  if (normLabel == null) throw ArgumentError('Missing label');
  if (normEn == null) throw ArgumentError('Missing source English text');
  if (langs.isEmpty) throw ArgumentError('No target languages provided');

  // -- output skeleton (built once; used in prompt to fix structure) ---------
  final skeleton = StringBuffer()
    ..writeln('{')
    ..writeln('  "label": ${jsonEncode(normLabel)},')
    ..writeln('  "localization": {');
  for (var i = 0; i < langs.length; i++) {
    final key = jsonEncode(langs[i]); // safe quoted JSON key
    final comma = i == langs.length - 1 ? '' : ',';
    skeleton.writeln('    $key: {"text": ""}$comma');
  }
  skeleton
    ..writeln('  }')
    ..writeln('}');

  // -- prompt assembly (tight, explicit, production-safe) --------------------
  final p = StringBuffer()
    ..writeln('You are a professional localization engine '
        'for a medical symptom-based advice chatbot.')
    ..writeln('Localize the item below into the target languages.')
    ..writeln('--- CONTEXT INPUT ---')
    ..writeln('label: $normLabel');
  if (normDesc != null) p.writeln('description: $normDesc');
  if (metaInline != null) {
    // meta is already string; if caller wants JSON,
    // they should pass it as a JSON string.
    p.writeln('meta_placeholders (ICU / intl format): $metaInline');
  }
  p
    ..writeln('en_source: $normEn')
    ..writeln('--- TARGET LANGUAGES ---')
    ..writeln('The JSON keys below are ISO 639-1 / BCP-47 LANGUAGE codes, '
        'never country codes. Translate into the named language, '
        'and keep the key exactly as given:');
  for (final code in langs) {
    final note = resolveLanguageNote(code);
    p.writeln(note == null
        ? '- ${describeLanguage(code)}'
        : '- ${describeLanguage(code)} — $note');
  }
  p
    ..writeln('Write each translation in the natural script of that language '
        '(e.g. Cyrillic for uk/ru/bg, Devanagari for hi, Arabic for ar).')
    ..writeln('Never answer in English for a non-English language code.')
    ..writeln('--- OUTPUT REQUIREMENTS ---')
    ..writeln(
        'Return ONLY valid minified JSON (no comments, no markdown fences).')
    ..writeln('Do NOT add explanatory text before or after JSON.')
    ..writeln('All requested languages MUST be present, no additional keys.')
    ..writeln('Preserve ICU/intl placeholders exactly '
        '(e.g., {name}, {version}, {count}).')
    ..writeln('Preserve HTML-like or XML-like tags verbatim if present.')
    ..writeln('Do not introduce new placeholders or variables.')
    ..writeln('If translation would be identical to English, '
        'repeat the English text.')
    ..writeln('If a translation is infeasible or unclear, '
        'copy the English text as fallback.')
    ..writeln('Avoid adding periods if original does not have one; '
        'keep stylistic equivalence.')
    ..writeln('No leading/trailing spaces in values.')
    ..writeln('Each value MUST be culturally and medically appropriate, '
        'neutral and concise.')
    ..writeln('Keep each translation roughly as long as the English source; '
        'never pad, repeat or explain.')
    ..writeln('No quotes escaping beyond standard JSON string escaping.')
    ..writeln('--- JSON SCHEMA (informal) ---')
    ..writeln('{')
    ..writeln('  "label": string,')
    ..writeln('  "localization": {')
    ..writeln('    <language_code>: {"text": string (non-empty)} '
        '// exactly the requested languages')
    ..writeln('  }')
    ..writeln('}')
    ..writeln('--- OUTPUT SKELETON (structure to follow) ---')
    ..writeln(skeleton.toString())
    ..writeln('--- RULES SUMMARY ---')
    ..writeln('1. Output only JSON.')
    ..writeln('2. Keys: label, localization.')
    ..writeln('3. localization contains exactly the target languages.')
    ..writeln('4. Each language object: {"text": "<translation>"}.')
    ..writeln('5. Do not include description, meta, or extra metadata fields.')
    ..writeln('6. Do not translate placeholders or modify their braces.')
    ..writeln('7. Keep punctuation style consistent with source.')
    ..writeln('8. Avoid hallucinating additional medical '
        'advice beyond the source meaning.')
    ..writeln('9. Keep resulting JSON compact (no unnecessary whitespace).')
    ..writeln('10. Use UTF-8 characters directly (no HTML entities).');

  // -- strict JSON Schema for Responses API ----------------------------------
  // This object can be used directly under response_format.json_schema
  // { "name": "...", "strict": true, "schema": { ... } }
  Map<String, Object?> langObjectSchema(String code) {
    final name = resolveLanguageName(code);
    return <String, Object?>{
      'type': 'object',
      'additionalProperties': false,
      'required': ['text'],
      'properties': {
        'text': <String, Object?>{
          'type': 'string',
          'minLength': 1,
          if (name != null)
            'description': 'Translation of en_source into $name '
                '($code), written in the native script of that language.',
        },
      },
    };
  }

  final Map<String, Object?> langProps = {
    for (final code in langs) code: langObjectSchema(code)
  };

  final schemaMap = <String, Object?>{
    'type': 'object',
    'additionalProperties': false,
    'required': ['label', 'localization'],
    'properties': {
      'label': {'type': 'string', 'minLength': 1},
      'localization': {
        'type': 'object',
        'additionalProperties': false,
        'required': langs, // exactly these languages must be present
        'properties': langProps,
      }
    }
  };

  return (prompt: p.toString(), schema: schemaMap);
}
