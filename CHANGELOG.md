## 0.5.0

- **BREAKING**: `localize` now only writes to a sheet whose header matches `label | description | meta | en | <locale> ...`. A sheet whose fourth column is not the English source is skipped with a warning — reference tables kept in the same spreadsheet were previously "translated", overwriting their data.
- **FIX**: `localize` wrote nothing back to Google Sheets — the row stream introduced in 0.4.3 never emitted the localized rows.
- **FIX**: `localize` failed every request with `400 Unsupported parameter: 'temperature'` on the default `gpt-5-mini` model. Reasoning models (`gpt-5*`, `o*`) now get `reasoning: {effort: low}` instead of the sampling parameters, and a token budget with headroom for their reasoning tokens.
- **FIX**: Placeholder validation rejected every correctly translated ICU plural, and accepted translations that had flattened the directive away. Placeholders are now parsed by brace depth.
- **FIX**: A reasoning item carrying the model's thinking is no longer mistaken for the answer payload.
- **FIX**: A sheet title containing a space or an apostrophe produced an invalid A1 range, so the row could not be written.
- **FIX**: Two columns whose headers sanitize to the same locale (`pt-BR` and `pt_BR`) left the second one empty forever; the duplicate column is now skipped.
- **CHANGED**: Failed writes to Google Sheets are retried only when retrying can help (429, 5xx, network) — a malformed range or a missing scope no longer costs 60s of sleeping per row.
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
