# CLAUDE.md

Guidance for Claude Code when working in this repository.

## What this package is

`sheety_localization` is a Dart CLI package that turns a Google Sheet into
localization files. It ships two executables (see `pubspec.yaml`):

- **`localize`** (`bin/localize.dart`, backed by `lib/src/localize/`) — fills in
  missing translations in the sheet via the OpenAI API and writes them back.
- **`generate`** (`bin/generate.dart`) — reads the sheet and generates ARB files
  and Flutter localization classes (`flutter gen-l10n`).

The two share the same sheet layout but are **separate code paths**. The column
layout is `label | description | meta | <source> | <locale> ...`: the fourth
column is the base/source language (not necessarily English) and every column
after it is a target locale. When you change how a sheet is interpreted, check
**both** `lib/src/localize/` **and** `bin/generate.dart`.

## Release hygiene — required for every task/issue

Every change that touches shippable code MUST leave the package publishable.
Before finishing a task (and before opening a PR), you must:

1. **Bump the version** in `pubspec.yaml` following semver
   (`fix` → patch, new feature/relaxed constraint → minor, breaking → major).
2. **Add a matching entry to `CHANGELOG.md`** under a new version heading, using
   the existing `**FIX** / **ADDED** / **CHANGED** / **BREAKING**` style.
3. **Verify the package still publishes** with:

   ```sh
   dart pub publish --dry-run
   ```

   It must report no errors (warnings that already existed on `master` are
   acceptable, but do not introduce new ones).

Skipping any of these makes the package impossible to publish, so treat them as
part of "done", not optional follow-up.

## Checks before opening a PR

```sh
dart analyze         # must be clean
dart test            # must be green
dart pub publish --dry-run
```
