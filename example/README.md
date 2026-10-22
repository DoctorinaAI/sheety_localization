# sheety_localization example

A small, synthetic spreadsheet ("Sheety Notes") turned into Flutter, TypeScript
and Python code. No Google account is needed: the sheet is read from
[`snapshot.json`](snapshot.json), an offline copy in the format
`--dump-snapshot` writes.

| File | What it is |
|---|---|
| [`sheety.yaml`](sheety.yaml) | The configuration: input, sheet filters, three targets |
| [`snapshot.json`](snapshot.json) | The sheets `help`, `app`, `sign-up` (base language `de`) and `backend-mail` (mustache syntax) |
| `dart/` | A Flutter package: `pubspec.yaml` and `test/` are hand-written, `lib/` is generated |
| `ts/` | An npm package: `package.json` and `tsconfig.json` are hand-written, `src/i18n/` is generated |
| `python/` | A Python distribution: `pyproject.toml` is hand-written, `src/sheety_notes_l10n/` is generated |

The generated directories, and the hand-written packaging files next to them,
are in the
[repository](https://github.com/DoctorinaAI/sheety_localization/tree/master/example).
They are not in the pub.dev archive.

## Regenerate

From the repository root:

```sh
dart run sheety_localization:generate --config=example/sheety.yaml
```

```text
Using example/sheety.yaml
Reading snapshot example/snapshot.json...
Read 3 sheets, 3 used by dart, ts, python
dart: 2 scope(s) -> example/dart/lib (13 added, 0 changed, 0 removed, 0 unchanged)
ts: 2 scope(s) -> example/ts/src/i18n (21 added, 0 changed, 0 removed, 0 unchanged)
python: 2 scope(s) -> example/python/src/sheety_notes_l10n (16 added, 0 changed, 0 removed, 0 unchanged)
Done.
```

(The real output prints absolute paths. Add `-v` to also list every file and
the info diagnostics: the synthetic `pt` locale and the fallbacks.)

Run it with `--check` to see whether the committed output is still up to
date. That is the command to use in CI. It exits with `1` when a file would
change.

## What the sheet shows

- `app`: a declared `String` placeholder, an `int` plural (`=0`, `one`, CLDR
  categories per language), a `select`, markup tags, and an undeclared
  placeholder, which is typed `Object`.
- Regional columns: `pt_BR` has no `pt` column, so a `pt` locale is
  synthesized from it. `ar` has a column of its own and keeps its own texts.
  `ar_EG` overrides only the cell it fills (`greeting`); every other message
  falls back to `ar`, and then to `en`.
- A short row: `lastSync` has no `ar` / `ar_EG` cells, so those locales fall
  back.
- `sign-up`: the base (fourth) column is `de`, not `en`.
- `backend-mail`: `{{name}}` placeholders (listed under `syntax.mustache`),
  where single braces are plain text. Only the Python target takes it.

## Use the output

Flutter (see [`dart/test/localization_test.dart`](dart/test/localization_test.dart)):

```dart
import 'package:sheety_notes_localization/localization.dart';

MaterialApp(
  localizationsDelegates: [
    ...AppLocalization.localizationsDelegates,
    SignUpLocalization.delegate,
  ],
  supportedLocales: AppLocalization.supportedLocales,
  home: Builder(
    builder: (context) => Text(AppLocalization.of(context).notes(3)),
  ),
);
```

TypeScript:

```ts
import { app } from '@acme/sheety-notes-l10n';

const t = await app.loadMessages(navigator.languages);
t.notes({ count: 3 }); // "3 Notizen" for de-AT
```

Python:

```python
from sheety_notes_l10n import backend_mail

backend_mail.get("de-CH, de;q=0.9, en;q=0.5").welcome_subject(name="Alice")
# 'Willkommen bei Sheety Notes, Alice!'
```

The package [README](../README.md) documents every option.
