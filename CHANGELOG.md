## 0.5.0

- **FIX**: `localize` wrote nothing back to Google Sheets — the row stream introduced in 0.4.3 never emitted the localized rows.
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
