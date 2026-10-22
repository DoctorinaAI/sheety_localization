## 1.0.0

- **BREAKING**: `generate` no longer writes ARB files and no longer runs `flutter gen-l10n` — it parses the sheet itself and emits the code directly. Generation needs only the Dart SDK; CI no longer has to download Flutter.
- **BREAKING**: Removed `--arb`, `--prefix`, `--author`, `--comment`, `--context`, `--modified` and `--[no-]last-modified` (they only shaped ARB files); using one fails with a migration hint. `--lib` / `--gen` keep working as a shortcut for the Dart target.
- **BREAKING**: A real parent locale column now wins over its regional variant: `ar` keeps its own texts instead of being overwritten by `ar_EG` when the regional column comes later in the header, and an empty cell of a real parent column falls back to the base language instead of borrowing the regional text (e.g. `pa` no longer takes `pa_PK` texts). A synthetic parent (`pt` from `pt_BR`) is still created when the parent column is missing. `--legacy-regional-override` restores the 0.6.0 behaviour.
- **BREAKING**: Duplicate labels in a sheet (after sanitizing) are now an error instead of the later row silently overwriting the earlier one.
- **BREAKING**: A row whose trailing cells are empty is no longer dropped from every locale — the missing translations fall back to the parent locale, then to the base language. An empty base text is an error.
- **ADDED**: Flutter Dart target (`--dart`), a drop-in replacement for the gen-l10n output: same files, classes, `of(context)`, delegates, `supportedLocales`, lookup and `intl` plural/select behaviour (verified byte for byte against gen-l10n output of a real 59-locale sheet).
- **ADDED**: Metadata API in the Dart output for tests: `localizationScopes`, `XLocalization.messages` (key, description, placeholders with type and example), per-locale `templates` and `fallbackKeys`, and a dynamic `format(key, args)`. Turn it off with the `metadata: false` target option for a gen-l10n-identical output.
- **ADDED**: TypeScript target (`--ts`) for Astro / SolidJS: zero-dependency ESM, strict types, one module per locale with lazy `loaders`, `resolveLocale`, an eager bundle for SSR and a separate `meta` module.
- **ADDED**: Python target (`--python`) for backends: zero-dependency package (Python ≥ 3.9, `mypy --strict` clean), snake_case typed accessors, lazy per-locale modules, `get(locale)` with `Accept-Language` negotiation, a dynamic `format(key, **args)` and metadata.
- **ADDED**: Plurals behave identically in all three targets: TypeScript and Python embed CLDR 48 plural rules and reproduce `intl`'s selection (exact `=0`/`=1`/`=2` matches first, `two → few → other` fallback).
- **ADDED**: `{{name}}` (mustache) placeholders for chosen sheets (`syntax: { mustache: [...] }` / `--mustache`), emitted as typed parameters like ICU `{name}`.
- **ADDED**: Validation with sheet/cell locations: ICU syntax, placeholder mismatches against the base text, missing `other` or CLDR plural categories, markup tag mismatches, duplicate labels, reserved words and identifier collisions per target, unsupported meta, invalid locale columns. Errors stop generation before anything is written; `--strict` also fails on warnings; `--diagnostics-format=json|github` for CI.
- **ADDED**: `sheety.yaml` configuration with per-target `output`, `include` / `ignore` sheet filters and emitter options; command-line flags override it.
- **ADDED**: Generated output is tracked by a deterministic `sheety_manifest.json`: only changed files are rewritten, stale generated files are removed, files the generator does not own are never touched. `--check` reports outdated output without writing (exit code 1).
- **ADDED**: `--dump-snapshot` / `--snapshot` to save the sheet to a JSON file and generate from it offline.
- **ADDED**: `invalid-unicode` warning for cells with lone UTF-16 surrogates (values keep them, comments and docstrings show U+FFFD in every target) and `plural-rules-mismatch` warning when the Dart target (intl has no rules for e.g. `gd`, `gv`, `kw`) and the TypeScript/Python targets (CLDR) would render a plural differently.
- **ADDED**: The TypeScript and Python runtimes negotiate locales with one documented algorithm (Accept-Language q-values, POSIX forms, script/region candidates, deprecated codes such as `iw` → `he`, then any locale of the language), checked by a shared test table.
- **CHANGED**: Dart output is formatted at the page width of the nearest `analysis_options.yaml` (or the `page_width` target option) and in the style of the language version of the nearest `pubspec.yaml` (short style below Dart 3.7), as `dart format` would in place.
- **CHANGED**: Writing is staged: every target's new files are written to a staging directory first and moved into place only when all of them could be written; a failure reports exactly which targets were written. Renaming a sheet by case only works on case-insensitive file systems.
- **CHANGED**: Stricter configuration: the output directories of two targets must not be nested; `--sheet` replaces a `snapshot:` of `sheety.yaml` (and `--snapshot` a `sheet:`), both in one place is an error; target options are type-checked and the TypeScript and Python targets reject unknown options; command-line RegExp lists split only at commas outside `{}`, `[]` and `()`; `--check` does not write the `--dump-snapshot` file.
- **CHANGED**: A manifest of another target in an output directory is an error (`foreign-manifest`) instead of being trusted; scope names that give the same class or directory in a target (`rate-us-2` / `rate_us2`) are reported; names that would break the generated code are reserved (Dart keys `intl`, `override`, `int`, `num`, `double`, `dynamic`, placeholders `intl`, `localeName`; TypeScript key `then`) while Dart keys `key` / `args`, Python keys named like builtins (`property`, `str`, …) and Dart locales that are reserved words (`Locales.is$`) now work.
- **CHANGED**: The generator moved to `lib/src/generate/` behind interfaces (sheet source, emitters, writer) and is covered by unit, golden and integration tests (`flutter analyze`, `tsc --strict`, `mypy --strict`, cross-target rendering parity).

## 0.6.0

- **FIX**: `localize` skipped any sheet whose base language was not English — a `label | description | meta | ru | ...` header was rejected as "not a localization sheet". The fourth column is now accepted as the source language whenever it is a recognized language code (`ru`, `de`, `pt_BR`, …); non-language data columns (e.g. a `Family` reference table) are still skipped. The source language is carried through into the model prompt and JSON schema, so rows are translated *from* the actual base language instead of always "from English".
- **FIX**: `generate` hard-coded the `flutter gen-l10n` template to `<prefix>_en.arb`, so a bucket without an English column failed to generate. The template is now chosen per bucket — English when present (unchanged behaviour), otherwise the first available ARB — so a non-English base language generates too.

## 0.5.0

- **BREAKING**: `localize` now only writes to a sheet whose header matches `label | description | meta | en | <locale> ...`. A sheet whose fourth column is not the English source is skipped with a warning — reference tables kept in the same spreadsheet were previously "translated", overwriting their data.
- **FIX**: `localize` wrote nothing back to Google Sheets — the row stream introduced in 0.4.3 never emitted the localized rows.
- **FIX**: `localize` failed every request with `400 Unsupported parameter: 'temperature'` on the default `gpt-5-mini` model. Reasoning models (`gpt-5*`, `o*`) now get `reasoning: {effort: low}` instead of the sampling parameters, and a token budget with headroom for their reasoning tokens.
- **FIX**: Placeholder validation rejected every correctly translated ICU plural, and accepted translations that had flattened the directive away. Placeholders are now parsed by brace depth.
- **FIX**: A reasoning item carrying the model's thinking is no longer mistaken for the answer payload.
- **FIX**: A sheet title containing a space or an apostrophe produced an invalid A1 range, so the row could not be written.
- **FIX**: Two columns whose headers sanitize to the same locale (`pt-BR` and `pt_BR`) left the second one empty forever; the duplicate column is now skipped.
- **CHANGED**: Failed writes to Google Sheets are retried only when retrying can help (429, 5xx, network) — a malformed range or a missing scope no longer costs 60s of sleeping per row.
- **CHANGED**: A single OpenAI request now has a hard timeout (`--timeout`, default 120s), and retries are limited to transient failures; an unusable payload is answered by splitting the batch instead of re-sending the same prompt.
- **CHANGED**: An invalid numeric option (`--workers=abc`, `--batch=99`) is reported instead of being silently replaced by the default.
- **CHANGED**: The pipeline moved to `lib/`, behind interfaces for both the model (`LocalizationClient`) and the spreadsheet (`SheetsGateway`), and is covered by unit tests — including the sheet-write path that used to be reachable only through a live Google account.
- **ADDED**: Per-language fallback: a failed batch of languages is split and each language is retried on its own instead of being re-sent as a whole, so one rare language the model chokes on no longer breaks its neighbours.
- **ADDED**: Translation validation before writing: ICU placeholders and markup tags must survive, no empty values, no leaked markdown fences, no runaway output. A rejected translation is retried alone.
- **ADDED**: Language hints in the prompt and in the JSON schema — English name, native endonym and an explicit disambiguation note for codes models misread (`uk` is Ukrainian, not "United Kingdom").
- **ADDED**: `--timeout` option (default `120s`) — a request the model never finishes is aborted instead of stalling a worker.
- **CHANGED**: Retries are limited to transient failures (network, timeout, 429, 5xx). Unusable payloads are never re-sent with the same prompt.
- **CHANGED**: `max_output_tokens` scales with the number of requested languages, so a large batch is no longer truncated into invalid JSON.
- **CHANGED**: A row that cannot be written to the sheet is skipped instead of aborting the whole run.
- **CHANGED**: The localization pipeline moved to `lib/` and is covered by unit tests.

## 0.4.3

- **CHANGED**: `localize` now writes translated cells to Google Sheets via batch updates per row instead of one request per cell.
- **CHANGED**: `--workers` now controls real concurrent OpenAI requests during localization.

## 0.4.2

- **ADDED**: Configurable language batch size via `--batch` (`-b`) CLI parameter to control how many languages are translated per single API call (default: 3).
- **CHANGED**: Default OpenAI model updated from `gpt-4o-mini` to `gpt-5-mini`.

## 0.4.1

- **ADDED**: Language name hints in localization prompts to prevent AI misinterpretation of ambiguous ISO codes (e.g. `uk` as Ukrainian, not United Kingdom).

## 0.4.0

- **FIX**: Fix aggressive caching of translations that caused outdated translations to be used.

## 0.3.0

- **FIX**: Resolved issue with `--no-last-modified` flag not functioning as intended.
- **ADDED**: Introduced localization with ChatGPT for improved translation quality.

## 0.2.3

- **ADDED**: Optional handling of rows with missing locale columns via `--include-empty`.
- **CHANGED**: Default behavior now skips rows with incomplete localization data.
- **ADDED**: Ability to disable generation of `@@last_modified` metadata using `--no-last-modified`.

## 0.2.2

- **ADDED**: Optional support for ignoring specific sheets by title with RegExp patterns.

## 0.2.1

- **FIX**: Fix locales import to `dart:ui`

## 0.2.0

- **ADDED**: Support for generating Flutter locales file.
- **ADDED**: Gen missing base locales.

## 0.1.3

- **ADDED**: `ignore_for_file: directives_ordering` for generated files to prevent linting issues.

## 0.1.2

- Add usage examples to the documentation.

## 0.1.1

- Updated documentation to clarify usage.
- Convert README.md to UTF-8 encoding.

## 0.1.0

- Initial release with basic functionality.
