/// Language metadata used to disambiguate ISO codes for the LLM.
library;

/// Comprehensive mapping of ISO 639-1 language codes (and common extended
/// locale codes) to their English language names.
/// Keys are lowercase with `_` as separator.
const Map<String, String> kLanguageNames = <String, String>{
  // A
  'aa': 'Afar',
  'ab': 'Abkhazian',
  'af': 'Afrikaans',
  'ak': 'Akan',
  'am': 'Amharic',
  'an': 'Aragonese',
  'ar': 'Arabic',
  'as': 'Assamese',
  'av': 'Avaric',
  'ay': 'Aymara',
  'az': 'Azerbaijani',
  // B
  'ba': 'Bashkir',
  'be': 'Belarusian',
  'bg': 'Bulgarian',
  'bh': 'Bihari',
  'bi': 'Bislama',
  'bm': 'Bambara',
  'bn': 'Bengali',
  'bo': 'Tibetan',
  'br': 'Breton',
  'bs': 'Bosnian',
  // C
  'ca': 'Catalan',
  'ce': 'Chechen',
  'ch': 'Chamorro',
  'co': 'Corsican',
  'cr': 'Cree',
  'cs': 'Czech',
  'cu': 'Church Slavic',
  'cv': 'Chuvash',
  'cy': 'Welsh',
  // D
  'da': 'Danish',
  'de': 'German',
  'dv': 'Divehi',
  'dz': 'Dzongkha',
  // E
  'ee': 'Ewe',
  'el': 'Greek',
  'en': 'English',
  'eo': 'Esperanto',
  'es': 'Spanish',
  'et': 'Estonian',
  'eu': 'Basque',
  // F
  'fa': 'Persian',
  'ff': 'Fulah',
  'fi': 'Finnish',
  'fj': 'Fijian',
  'fo': 'Faroese',
  'fr': 'French',
  'fy': 'Western Frisian',
  // G
  'ga': 'Irish',
  'gd': 'Scottish Gaelic',
  'gl': 'Galician',
  'gn': 'Guarani',
  'gu': 'Gujarati',
  'gv': 'Manx',
  // H
  'ha': 'Hausa',
  'he': 'Hebrew',
  'hi': 'Hindi',
  'ho': 'Hiri Motu',
  'hr': 'Croatian',
  'ht': 'Haitian Creole',
  'hu': 'Hungarian',
  'hy': 'Armenian',
  'hz': 'Herero',
  // I
  'ia': 'Interlingua',
  'id': 'Indonesian',
  'ie': 'Interlingue',
  'ig': 'Igbo',
  'ii': 'Sichuan Yi',
  'ik': 'Inupiaq',
  'io': 'Ido',
  'is': 'Icelandic',
  'it': 'Italian',
  'iu': 'Inuktitut',
  // J
  'ja': 'Japanese',
  'jv': 'Javanese',
  // K
  'ka': 'Georgian',
  'kg': 'Kongo',
  'ki': 'Kikuyu',
  'kj': 'Kuanyama',
  'kk': 'Kazakh',
  'kl': 'Kalaallisut',
  'km': 'Khmer',
  'kn': 'Kannada',
  'ko': 'Korean',
  'kr': 'Kanuri',
  'ks': 'Kashmiri',
  'ku': 'Kurdish',
  'kv': 'Komi',
  'kw': 'Cornish',
  'ky': 'Kyrgyz',
  // L
  'la': 'Latin',
  'lb': 'Luxembourgish',
  'lg': 'Ganda',
  'li': 'Limburgish',
  'ln': 'Lingala',
  'lo': 'Lao',
  'lt': 'Lithuanian',
  'lu': 'Luba-Katanga',
  'lv': 'Latvian',
  // M
  'mg': 'Malagasy',
  'mh': 'Marshallese',
  'mi': 'Maori',
  'mk': 'Macedonian',
  'ml': 'Malayalam',
  'mn': 'Mongolian',
  'mr': 'Marathi',
  'ms': 'Malay',
  'mt': 'Maltese',
  'my': 'Burmese',
  // N
  'na': 'Nauru',
  'nb': 'Norwegian Bokmal',
  'nd': 'North Ndebele',
  'ne': 'Nepali',
  'ng': 'Ndonga',
  'nl': 'Dutch',
  'nn': 'Norwegian Nynorsk',
  'no': 'Norwegian',
  'nr': 'South Ndebele',
  'nv': 'Navajo',
  'ny': 'Chichewa',
  // O
  'oc': 'Occitan',
  'oj': 'Ojibwe',
  'om': 'Oromo',
  'or': 'Odia',
  'os': 'Ossetian',
  // P
  'pa': 'Punjabi',
  'pi': 'Pali',
  'pl': 'Polish',
  'ps': 'Pashto',
  'pt': 'Portuguese',
  // Q
  'qu': 'Quechua',
  // R
  'rm': 'Romansh',
  'rn': 'Kirundi',
  'ro': 'Romanian',
  'ru': 'Russian',
  'rw': 'Kinyarwanda',
  // S
  'sa': 'Sanskrit',
  'sc': 'Sardinian',
  'sd': 'Sindhi',
  'se': 'Northern Sami',
  'sg': 'Sango',
  'si': 'Sinhala',
  'sk': 'Slovak',
  'sl': 'Slovenian',
  'sm': 'Samoan',
  'sn': 'Shona',
  'so': 'Somali',
  'sq': 'Albanian',
  'sr': 'Serbian',
  'ss': 'Swati',
  'st': 'Southern Sotho',
  'su': 'Sundanese',
  'sv': 'Swedish',
  'sw': 'Swahili',
  // T
  'ta': 'Tamil',
  'te': 'Telugu',
  'tg': 'Tajik',
  'th': 'Thai',
  'ti': 'Tigrinya',
  'tk': 'Turkmen',
  'tl': 'Tagalog',
  'tn': 'Tswana',
  'to': 'Tongan',
  'tr': 'Turkish',
  'ts': 'Tsonga',
  'tt': 'Tatar',
  'tw': 'Twi',
  'ty': 'Tahitian',
  // U
  'ug': 'Uyghur',
  'uk': 'Ukrainian',
  'ur': 'Urdu',
  'uz': 'Uzbek',
  // V
  've': 'Venda',
  'vi': 'Vietnamese',
  'vo': 'Volapuk',
  // W
  'wa': 'Walloon',
  'wo': 'Wolof',
  // X
  'xh': 'Xhosa',
  // Y
  'yi': 'Yiddish',
  'yo': 'Yoruba',
  // Z
  'za': 'Zhuang',
  'zh': 'Chinese',
  'zu': 'Zulu',

  // --- Legacy / alternative ISO 639-1 codes still seen in the wild ---
  'in': 'Indonesian', // legacy code for `id`
  'iw': 'Hebrew', // legacy code for `he`
  'ji': 'Yiddish', // legacy code for `yi`
  'fil': 'Filipino',
  'nb_no': 'Norwegian Bokmal',
  'nn_no': 'Norwegian Nynorsk',

  // --- Extended locale codes (language + region) ---
  'zh_cn': 'Chinese Simplified',
  'zh_tw': 'Chinese Traditional',
  'zh_hk': 'Chinese Traditional (Hong Kong)',
  'zh_hans': 'Chinese Simplified',
  'zh_hant': 'Chinese Traditional',
  'pt_br': 'Brazilian Portuguese',
  'pt_pt': 'European Portuguese',
  'en_us': 'American English',
  'en_gb': 'British English',
  'en_au': 'Australian English',
  'es_mx': 'Mexican Spanish',
  'es_ar': 'Argentinian Spanish',
  'es_es': 'European Spanish',
  'fr_ca': 'Canadian French',
  'fr_fr': 'European French',
  'fr_be': 'Belgian French',
  'fr_ch': 'Swiss French',
  'de_at': 'Austrian German',
  'de_ch': 'Swiss German',
  'de_de': 'German',
  'nl_be': 'Flemish',
  'sr_latn': 'Serbian (Latin)',
  'sr_cyrl': 'Serbian (Cyrillic)',
  'ro_md': 'Moldavian',
  'ar_sa': 'Saudi Arabic',
  'ar_eg': 'Egyptian Arabic',
  'ar_ma': 'Moroccan Arabic',
  'ms_my': 'Malay (Malaysia)',
  'ms_bn': 'Malay (Brunei)',
  'sw_ke': 'Swahili (Kenya)',
  'sw_tz': 'Swahili (Tanzania)',
  'ta_lk': 'Tamil (Sri Lanka)',
  'ur_pk': 'Urdu (Pakistan)',
  'ur_in': 'Urdu (India)',
  'bn_bd': 'Bengali (Bangladesh)',
  'bn_in': 'Bengali (India)',
  'pa_guru': 'Punjabi (Gurmukhi)',
  'pa_arab': 'Punjabi (Shahmukhi)',
  'az_latn': 'Azerbaijani (Latin)',
  'az_cyrl': 'Azerbaijani (Cyrillic)',
  'uz_latn': 'Uzbek (Latin)',
  'uz_cyrl': 'Uzbek (Cyrillic)',
};

/// Endonyms (native self-names) for the most frequently used languages.
///
/// The endonym is written into the prompt next to the English name — it is a
/// much stronger signal for the model than the bare ISO code, because it is
/// already expressed in the target language and script.
const Map<String, String> kLanguageEndonyms = <String, String>{
  'ar': 'العربية',
  'az': 'Azərbaycan dili',
  'be': 'беларуская',
  'bg': 'български',
  'bn': 'বাংলা',
  'bs': 'bosanski',
  'ca': 'català',
  'cs': 'čeština',
  'cy': 'Cymraeg',
  'da': 'dansk',
  'de': 'Deutsch',
  'el': 'Ελληνικά',
  'en': 'English',
  'es': 'español',
  'et': 'eesti',
  'eu': 'euskara',
  'fa': 'فارسی',
  'fi': 'suomi',
  'fr': 'français',
  'ga': 'Gaeilge',
  'gl': 'galego',
  'gu': 'ગુજરાતી',
  'he': 'עברית',
  'hi': 'हिन्दी',
  'hr': 'hrvatski',
  'hu': 'magyar',
  'hy': 'հայերեն',
  'id': 'Bahasa Indonesia',
  'is': 'íslenska',
  'it': 'italiano',
  'ja': '日本語',
  'ka': 'ქართული',
  'kk': 'қазақ тілі',
  'km': 'ភាសាខ្មែរ',
  'kn': 'ಕನ್ನಡ',
  'ko': '한국어',
  'ky': 'кыргызча',
  'lt': 'lietuvių',
  'lv': 'latviešu',
  'mk': 'македонски',
  'ml': 'മലയാളം',
  'mn': 'монгол',
  'mr': 'मराठी',
  'ms': 'Bahasa Melayu',
  'my': 'မြန်မာ',
  'nb': 'norsk bokmål',
  'ne': 'नेपाली',
  'nl': 'Nederlands',
  'nn': 'norsk nynorsk',
  'no': 'norsk',
  'pa': 'ਪੰਜਾਬੀ',
  'pl': 'polski',
  'ps': 'پښتو',
  'pt': 'português',
  'ro': 'română',
  'ru': 'русский',
  'si': 'සිංහල',
  'sk': 'slovenčina',
  'sl': 'slovenščina',
  'sq': 'shqip',
  'sr': 'српски',
  'sv': 'svenska',
  'sw': 'Kiswahili',
  'ta': 'தமிழ்',
  'te': 'తెలుగు',
  'th': 'ไทย',
  'tl': 'Tagalog',
  'tr': 'Türkçe',
  'uk': 'українська',
  'ur': 'اردو',
  'uz': 'oʻzbekcha',
  'vi': 'Tiếng Việt',
  'zh': '中文',
  'zh_cn': '简体中文',
  'zh_tw': '繁體中文',
  'pt_br': 'português brasileiro',
};

/// Codes that language models routinely confuse with something else.
///
/// The note is injected into the prompt verbatim, as an explicit warning, so
/// the model cannot fall back on its own (wrong) guess. `uk` is the canonical
/// offender: it is Ukrainian, but it is frequently read as "United Kingdom"
/// and answered in English.
const Map<String, String> kAmbiguousLanguageNotes = <String, String>{
  'uk': 'Ukrainian (Cyrillic script). NOT English and NOT '
      '"United Kingdom" — British English would be "en_GB".',
  'cs': 'Czech. NOT Chechen ("ce").',
  'ce': 'Chechen. NOT Czech ("cs").',
  'sl': 'Slovenian. NOT Slovak ("sk").',
  'sk': 'Slovak. NOT Slovenian ("sl").',
  'da': 'Danish. NOT Dari/Persian ("fa" / "prs").',
  'de': 'German (Deutsch). NOT Danish ("da") and NOT Dutch ("nl").',
  'nl': 'Dutch (Netherlands). NOT German ("de").',
  'se': 'Northern Sami. NOT Swedish ("sv").',
  'sv': 'Swedish. NOT Northern Sami ("se").',
  'et': 'Estonian. NOT Amharic/Ethiopian ("am").',
  'eu': 'Basque (Euskara). It is a language, not "Europe/EU".',
  'el': 'Greek. NOT Elvish or any English variant.',
  'ja': 'Japanese. NOT Javanese ("jv").',
  'jv': 'Javanese (Indonesia). NOT Japanese ("ja").',
  'ka': 'Georgian (Kartuli). NOT Kannada ("kn").',
  'kn': 'Kannada (India). NOT Georgian ("ka").',
  'ms': 'Malay. NOT Malayalam ("ml").',
  'ml': 'Malayalam (India). NOT Malay ("ms").',
  'hy': 'Armenian. NOT Hindi ("hi").',
  'fa': 'Persian/Farsi. NOT Pashto ("ps").',
  'sq': 'Albanian (Shqip).',
  'zh': 'Chinese, Simplified script by default.',
  'iw': 'Hebrew (legacy code for "he").',
  'in': 'Indonesian (legacy code for "id").',
};

/// Returns human-readable language name for the given locale [code],
/// or `null` if no match is found.
///
/// Lookup order:
/// 1. Exact match after normalization (lowercase, `_` separator).
/// 2. If the code contains `_`, try the language-only prefix (part before `_`).
String? resolveLanguageName(String code) {
  final normalized = normalizeLanguageCode(code);
  final name = kLanguageNames[normalized];
  if (name != null) return name;
  final underscore = normalized.indexOf('_');
  if (underscore > 0) {
    return kLanguageNames[normalized.substring(0, underscore)];
  }
  return null;
}

/// Returns the endonym (native self-name) for [code], or `null` when unknown.
String? resolveLanguageEndonym(String code) {
  final normalized = normalizeLanguageCode(code);
  final endonym = kLanguageEndonyms[normalized];
  if (endonym != null) return endonym;
  final underscore = normalized.indexOf('_');
  if (underscore > 0) {
    return kLanguageEndonyms[normalized.substring(0, underscore)];
  }
  return null;
}

/// Returns the disambiguation note for [code], or `null` when the code is not
/// known to be confusable.
String? resolveLanguageNote(String code) {
  final normalized = normalizeLanguageCode(code);
  final note = kAmbiguousLanguageNotes[normalized];
  if (note != null) return note;
  final underscore = normalized.indexOf('_');
  if (underscore > 0) {
    return kAmbiguousLanguageNotes[normalized.substring(0, underscore)];
  }
  return null;
}

/// Normalize a locale [code] to the lookup form: lowercase, `_` separated.
String normalizeLanguageCode(String code) =>
    code.trim().toLowerCase().replaceAll('-', '_');

/// Human-readable, prompt-ready description of the locale [code].
///
/// Examples:
/// * `uk` -> `uk — Ukrainian (українська)`
/// * `xx` -> `xx` (unknown code, passed through untouched)
String describeLanguage(String code) {
  final name = resolveLanguageName(code);
  if (name == null) return code;
  final endonym = resolveLanguageEndonym(code);
  return endonym == null ? '$code — $name' : '$code — $name ($endonym)';
}
