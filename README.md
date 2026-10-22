# Sheety Localization

[![Checkout](https://github.com/DoctorinaAI/sheety_localization/actions/workflows/checkout.yml/badge.svg)](https://github.com/DoctorinaAI/sheety_localization/actions/workflows/checkout.yml)
[![Pub Package](https://img.shields.io/pub/v/sheety_localization.svg)](https://pub.dev/packages/sheety_localization)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Dart](https://img.shields.io/badge/Dart-%230175C2.svg?style=flat&logo=dart&logoColor=white)](https://dart.dev)
[![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=flat&logo=Flutter&logoColor=white)](https://flutter.dev)
[![TypeScript](https://img.shields.io/badge/TypeScript-%233178C6.svg?style=flat&logo=typescript&logoColor=white)](https://www.typescriptlang.org)
[![Python](https://img.shields.io/badge/Python-%233776AB.svg?style=flat&logo=python&logoColor=white)](https://www.python.org)

**Sheety Localization** turns a Google Sheet into localization code. Translators
and product people edit one spreadsheet, and a single command generates:

- **Flutter (Dart)**: a drop-in replacement for the `flutter gen-l10n` output.
  It has the same classes, `of(context)`, delegates and lookup, plus a
  metadata API for tests.
- **TypeScript**: zero-dependency ES modules for Astro, SolidJS or any bundler,
  with one lazily loaded module per locale.
- **Python**: a zero-dependency typed package for a backend (FastAPI, Django,
  workers), with `Accept-Language` negotiation.

The package ships two executables:

| Executable | What it does |
|---|---|
| [`generate`](#quick-start) | Reads the sheet, validates every cell and writes the code for the configured targets |
| [`localize`](#ai-powered-localization-localize) | Fills in missing translations in the sheet with the OpenAI API and writes them back |

Both read the same [sheet layout](#sheet-layout).

---

## Contents

- [Features](#features)
- [Sheet layout](#sheet-layout)
- [Installation](#installation)
- [Google credentials](#google-credentials)
- [Quick start](#quick-start)
- [Configuration: `sheety.yaml`](#configuration-sheetyyaml)
- [Command line](#command-line)
- [Flutter (Dart) target](#flutter-dart-target)
- [TypeScript target (Astro, SolidJS)](#typescript-target-astro-solidjs)
- [Python target (FastAPI)](#python-target-fastapi)
- [Locale negotiation (TypeScript and Python)](#locale-negotiation-typescript-and-python)
- [Packaging the output for a registry](#packaging-the-output-for-a-registry)
- [CI](#ci)
- [Diagnostics](#diagnostics)
- [Migrating from 0.6.x](#migrating-from-06x)
- [AI-powered localization (`localize`)](#ai-powered-localization-localize)
- [Docker](#docker)
- [Tips](#tips)

A complete, runnable example (sheet snapshot, configuration and the generated
output of all three targets) is in [`example/`](example/).

---

## Features

- **One sheet, three languages.** Each sheet (tab) becomes a *scope*: a class
  in Dart, a module directory in TypeScript and a sub-package in Python.
- **Per-target sheet selection.** For example, the Flutter app gets
  `app`/`chat`/`settings` and the backend gets the `backend-*` sheets.
- **ICU messages**: placeholders, `plural` and `select` (nested too), with the
  semantics of `package:intl` in every target. A plural picks the same branch
  in Dart, TypeScript and Python. (JavaScript has one number type, so a `num`
  placeholder holding `1.0` prints `1` in TypeScript and `1.0` in Dart and
  Python; declare it `double` to get `1.0` everywhere, or pass integers.)
- **`{{name}}` (mustache) placeholders** for sheets that use them, typically
  backend or e-mail texts.
- **Validation before anything is written.** Each error and warning names the
  sheet, the cell (`app!E12`), the locale and the key, so an editor can fix
  the sheet. `--strict` also fails on warnings, and
  `--diagnostics-format=github` annotates the CI run.
- **Fallbacks**: an empty cell uses the parent locale (`pt_BR` → `pt`), then
  the base language. The generated metadata records every fallback.
- **Safe, deterministic output**: no timestamps, and only changed files are
  rewritten. A `sheety_manifest.json` records which files the generator owns:
  it deletes its own stale files and never touches anything else, so a
  `pubspec.yaml`, `package.json` or `pyproject.toml` can live next to the
  generated code.
- **`--check`** reports outdated output without writing anything (exit code 1).
- **Offline runs**: `--dump-snapshot` saves the sheet to JSON, and
  `--snapshot` generates from it with no Google access.
- **No Flutter needed to generate**: only the Dart SDK. The generated Dart
  code still uses `flutter_localizations` and `intl` in your app.

---

## Sheet layout

Every localization sheet has the same layout. Row 1 is the header:

| A: `label` | B: `description` | C: `meta` | D: base locale | E… : locales |
|---|---|---|---|---|
| `title` | Application title | | Sheety Notes | Sheety Notizen |
| `greeting` | Greets the user | `{"placeholders": {"name": {"type": "String", "example": "Alice"}}}` | Hello, {name}! | Hallo, {name}! |
| `notes` | Number of notes | `{"placeholders": {"count": {"type": "int", "example": "3"}}}` | `{count, plural, =0{No notes} one{One note} other{{count} notes}}` | `{count, plural, =0{Keine Notizen} one{Eine Notiz} other{{count} Notizen}}` |

- **`label`** is the message key. It is sanitized: every character outside
  `[a-zA-Z0-9_]` becomes `_`, repeated `_` are merged and leading and trailing
  `_` are trimmed, so `chat.welcome.1` becomes `chat_welcome_1`. Dart and
  TypeScript use the key as is (`chatWelcome`). Python uses the snake_case form
  (`chat_welcome`) as the attribute name and keeps the key for `format()`.
- **`description`** becomes the doc comment of the generated getter or method.
  A `description` in `meta` overrides it.
- **`meta`** is empty or a JSON object in the ARB `@key` format:

  ```json
  {
    "description": "Number of notes in the list",
    "placeholders": {
      "count": { "type": "int", "example": "3", "description": "How many" }
    }
  }
  ```

  The placeholder `type` is one of `String`, `int`, `num`, `double` or
  `Object`. `example` is used by the generated metadata (see the test examples
  below). A placeholder that is used in a text but not declared is inferred, as
  gen-l10n does: a plural count is `num`, a select choice is `String`, anything
  else is `Object`. Placeholders are ordered as declared, then the undeclared
  ones alphabetically. The generated parameters follow this order.

  Not supported (error `unsupported-meta`): the type `DateTime`, an unknown
  type, `format`, `optionalParameters`, `isCustomDateFormat`. Pass a
  preformatted `String` instead.
- **Column D** is the **base language**, the source every other column is
  translated from and the final fallback. It does not have to be `en`; each
  sheet can have its own base.
- **Columns E onwards** are locales: `de`, `pt_BR`, `pt-BR`, `zh_Hant`,
  `zh_Hant_TW`, `es_419`… They are normalized to `ll`, `ll_CC`, `ll_Ssss` or
  `ll_Ssss_CC`. A header cell is sanitized first (`pt BR` → `pt_BR`), exactly
  as for column D. A header that is not a locale code is skipped with a
  warning. A duplicate locale (`pt-BR` next to `pt_BR`) keeps the first
  column. `localize` reads the header the same way, so it never fills a
  column that `generate` skips (a `Notes` column, a second `pt_br`).
- A cell that holds only whitespace counts as **empty** in both executables.
- A sheet whose fourth header cell is not a language code (a `help` tab, a
  reference table) is **not a localization sheet**. It is skipped
  (`not-localization-sheet`, info). Use `ignore` to skip a sheet that matches
  the layout but should not be generated.
- The **sheet title** becomes the scope name, sanitized by the same rule
  (case is kept): `sign-up` becomes `sign_up` (`SignUpLocalization` in Dart
  and Python, `sign_up` in TypeScript), `Sign-Up` becomes `Sign_Up`. A title
  that is a Dart keyword (`default`, `new`) is fine for Dart, whose class is
  always `<Name>Localization`; TypeScript and Python reject their own
  keywords as scope names.

### Messages (ICU subset)

Texts are ICU MessageFormat with the exact semantics of Flutter's gen-l10n and
`package:intl`:

| Supported | Example |
|---|---|
| Literal text; apostrophes and `#` are literal (no escaping, gen-l10n's default) | `It's #1` |
| Argument | `Hello, {name}!` |
| Plural with `=0`, `=1`, `=2` and `zero one two few many other` | `{count, plural, =0{No notes} one{One note} other{{count} notes}}` |
| Select | `{gender, select, male{he} female{she} other{they}}` |
| Nesting (a placeholder or a select inside a plural branch, and so on) | `{n, plural, one{{name} has one} other{{name} has {n}}}` |
| Markup tags, kept as text but checked across locales | `I accept the <b>terms</b>` |

How a plural branch is chosen, identically in all three targets: an exact
`=0` / `=1` / `=2` (or `zero` / `one` / `two`) match first, then the CLDR
category of the locale (Unicode CLDR 48). A missing `two` falls back to `few`,
then to `other`, and any other missing category falls back to `other`.
Fractional counts are handled as `package:intl` does.

One exception: `package:intl`, which the Dart target uses at runtime, has no
plural rules for some languages CLDR covers (Scottish Gaelic `gd`, Manx `gv`,
Cornish `kw`, Norwegian Nynorsk `nn`, Yiddish `yi` and about a hundred more).
For them intl renders every count without an exact `=0`/`=1`/`=2` match as
`other`, while the TypeScript and Python targets use the CLDR rules (`gd`: 3 is
`few`). When the Dart target and another target generate a scope with such a
locale and a plural, a `plural-rules-mismatch` warning names the locale and
the messages that can differ.

A cell that is not valid Unicode text (a lone UTF-16 surrogate, e.g. from a
broken copy-paste) gets an `invalid-unicode` warning. String values keep it,
escaped, identically in every target; comments and docstrings show U+FFFD
instead, so the files are valid UTF-8.

Rejected with an error (`icu-syntax`, `plural-missing-other`):
`selectordinal`, `offset:`, `{x, number}` / `date` / `time`, exact cases
other than `=0`/`=1`/`=2`, plural or select without `other`, unbalanced
braces. gen-l10n silently accepts some of these (a stray `}` truncates the
message there), but this generator does not.

### Mustache sheets (`{{name}}`)

Some sheets, typically backend and e-mail texts, use `{{name}}` placeholders.
List them under `syntax.mustache` (or pass `--mustache`). In those sheets:

- `{{name}}` and `{{ name }}` are placeholders, typed and validated exactly
  like ICU `{name}` (declare their type in `meta` as usual).
- Everything else is literal text: single braces (`{see plans}`), `#` and `'`.
- There is no plural or select. `{{a.b}}`, empty `{{}}` and an unterminated
  `{{` are errors.

If an ICU sheet contains `{{name}}`, the `icu-syntax` error says that the
sheet looks like a mustache sheet.

### Regional columns and fallbacks

- **A real parent column wins.** If a sheet has both `ar` and `ar_EG`, `ar`
  keeps its own texts, and `ar_EG` overrides only the cells it fills. An empty
  `ar` cell falls back to the base language, never to `ar_EG`.
- **A synthetic parent is created only when the parent column is missing.**
  With `pt_BR` but no `pt`, a `pt` locale is generated from the `pt_BR` texts
  (`synthetic-locale`, info), as the previous generator and gen-l10n's class
  hierarchy (`AppLocalizationPtBr extends AppLocalizationPt`) require.
- **Empty cells fall back** to the parent locale, then to the base language:
  `pt_BR` → `pt` → base. This includes the trailing cells that the Sheets API
  omits from short rows. Each fallback is recorded in the metadata
  (`fallbackKeys`, `isFallback`) and reported as a `fallback` info with
  counts.
- **An empty base cell leaves the message out** (`empty-base`, warning). The
  message cannot exist without its source text; the rest is generated, and
  `localize` skips such a row instead of translating its label.
- **Duplicate labels are an error** (`duplicate-label`). Two rows of a sheet
  whose labels sanitize to the same key (`chat.title` and `chat_title`) must be
  merged in the sheet.

---

## Installation

As a global tool:

```sh
dart pub global activate sheety_localization
dart pub global run sheety_localization:generate --help
```

Or as a dev dependency of the project that holds the generated code (pins the
version, so every machine and CI generates the same output):

```sh
dart pub add --dev sheety_localization
dart run sheety_localization:generate --help
```

Requires the Dart SDK ≥ 3.6. Flutter is not required to generate.
`dart format` (part of the Dart SDK) formats the Dart output; turn it off with
`--no-format`.

A [Docker image](#docker) with AOT-compiled binaries is also available.

---

## Google credentials

1. Create a project in the [Google Cloud Console](https://console.cloud.google.com/)
   and enable the **Google Sheets API**.
2. Create a **Service Account** and download its JSON key, for example as
   `credentials.json`. Never commit it. In CI, write it from a secret.
3. Share the spreadsheet with the service account's e-mail (the
   `client_email` in the key). **Viewer** is enough for `generate`; `localize`
   writes, so it needs **Editor**.
4. The spreadsheet ID is the part of the URL between `/d/` and `/edit`.

---

## Quick start

Generate all three targets from the command line:

```sh
dart run sheety_localization:generate \
  --sheet=<SPREADSHEET_ID> --credentials=credentials.json \
  --ignore='^help$' \
  --dart=lib \
  --ts=web/src/i18n \
  --python=backend/src/myapp/l10n
```

Or describe the setup once in a `sheety.yaml` next to it:

```yaml
sheet: <SPREADSHEET_ID>
credentials: credentials.json
ignore: ['^help$']
syntax:
  mustache: ['^backend-']
targets:
  dart:
    output: app/lib
    ignore: ['^backend-']
  ts:
    output: web/src/i18n
    ignore: ['^backend-']
  python:
    output: backend/src/myapp/l10n
    include: ['^backend-']
```

```sh
dart run sheety_localization:generate            # reads ./sheety.yaml
dart run sheety_localization:generate --check    # CI: is the committed output up to date?
```

With the [example](example/) configuration and snapshot, the output is:

```text
Using example/sheety.yaml
Reading snapshot example/snapshot.json...
Read 3 sheets, 3 used by dart, ts, python
dart: 2 scope(s) -> example/dart/lib (13 added, 0 changed, 0 removed, 0 unchanged)
ts: 2 scope(s) -> example/ts/src/i18n (21 added, 0 changed, 0 removed, 0 unchanged)
python: 2 scope(s) -> example/python/src/sheety_notes_l10n (16 added, 0 changed, 0 removed, 0 unchanged)
Done.
```

Errors and warnings in the sheet are printed above that summary, grouped by
scope. If there is any error, nothing is written.

---

## Configuration: `sheety.yaml`

`generate` reads `sheety.yaml` from the current directory when it exists, or
the file given with `--config`. Every key is optional except
`targets.<target>.output`. Paths are relative to the YAML file. Unknown keys
are errors, with a "did you mean" hint. Command-line options override the
file.

The input is either the spreadsheet (`sheet`) or a snapshot (`snapshot`),
never both in the same place: setting both in the file is an error, and on the
command line `--sheet` replaces a `snapshot:` of the file (and `--snapshot` a
`sheet:`), while giving both flags is an error.

```yaml
# Input ------------------------------------------------------------------------

# Google spreadsheet ID (the part of the URL between /d/ and /edit).
sheet: 1AbC...

# Service account key. Default: credentials.json in the CURRENT directory.
credentials: credentials.json

# Read the sheets from this snapshot instead of Google (offline / CI).
# Format: {"sheets": [{"title": "app", "values": [["label", ...], ...]}]}
snapshot: sheets.json

# Also save every sheet that was read to this file (not with --check, which
# writes nothing).
dump_snapshot: sheets.json

# Sheets skipped by every target: RegExps over sheet titles, unanchored
# ("backend" also matches "backend-mail"; use ^ and $ for exact titles).
# A single string is accepted too.
ignore: ['^help$', '^locales$']

# Message syntax per sheet: these sheets use {{name}} instead of ICU.
syntax:
  mustache: ['^backend-']

# Output -----------------------------------------------------------------------

# Header comment of every generated file, without comment markers ("// " or
# "# " is added per language; a leading "//" is stripped). "" for none.
header: This file is generated, do not edit it manually!

# Treat warnings as errors.
strict: false

# Format the Dart output with `dart format`, at the page width of the nearest
# analysis_options.yaml (formatter: page_width), else 80, and in the style of
# the language version of the nearest pubspec.yaml (the lower bound of
# environment: sdk:, e.g. the short pre-3.7 style for sdk: ^3.6.0), else the
# latest. That is what `dart format` itself does in the package.
format: true

# Reader ------------------------------------------------------------------------

# Missing trailing cells of a short row are empty translations, so they fall
# back. false: skip such rows entirely, like 0.6.x did (warning short-row).
include_empty: true

# 0.6.x behaviour: the first regional column of a language (ar_EG) overwrites
# the language's own column (ar). Only for bit-identical migrations.
legacy_regional_override: false

# Targets ----------------------------------------------------------------------
# At least one. Each target needs its own output directory, and the
# directories must not be nested in each other (each target keeps a manifest
# of the files it owns there). Directories are compared through symlinks and,
# on a case-insensitive file system, ignoring case. Per target:
#   output   (required) directory to generate into
#   include  only sheets matching one of these RegExps (applied first)
#   ignore   then skip sheets matching one of these (after the global ignore)
#   header   overrides the global header for this target
#   options  emitter options (below)
targets:
  dart:
    output: app/lib
    ignore: ['^backend', '^bot']
    options:
      directory: src/generated   # per-scope files, locales.dart, localization_meta.dart
      barrel: localization.dart  # library exporting everything; "" for none
      metadata: true             # false: no metadata API (gen-l10n-identical output)
      page_width: 80             # positive integer; overrides analysis_options.yaml
  ts:
    output: web/src/i18n
    ignore: ['^backend']
  python:
    output: backend/src/myapp/l10n
    include: ['^backend']
    header: Generated from the localization sheet.
```

The TypeScript and Python targets have no options yet. An unknown option
(`unknown-option`) and a value of the wrong type (`invalid-option`, e.g.
`metadata: "false"` or `page_width: "100"`) are errors.

---

## Command line

```text
dart run sheety_localization:generate [options]
```

| Option | Meaning |
|---|---|
| `--config=<file>` | Configuration file (default: `./sheety.yaml` when it exists) |
| `-s, --sheet=<id>` | Google spreadsheet ID |
| `-c, --credentials=<file>` | Service account key (default `credentials.json`) |
| `--snapshot=<file>` | Read the sheets from a snapshot instead of Google |
| `--dump-snapshot=<file>` | Save the sheets that were read. Works without any target; not with `--check` |
| `-i, --ignore=<re>` | Sheets skipped by every target (repeat, or separate with commas) |
| `--mustache=<re>` | Sheets using `{{name}}` placeholders |
| `--[no-]include-empty` | See `include_empty` (default on) |
| `--[no-]legacy-regional-override` | See `legacy_regional_override` (default off) |
| `--dart=<dir>`, `--ts=<dir>`, `--python=<dir>` | Enable a target, or override its `output` |
| `--<target>-include=<re>`, `--<target>-ignore=<re>` | Per-target sheet filters (replace the YAML lists) |
| `--only=dart,ts,python` | Generate only these of the configured targets |
| `--header=<text>` | Header comment of every generated file |
| `-f, --[no-]format` | `dart format` the Dart output (default on) |
| `--check` | Write nothing (not even `--dump-snapshot`); list what would change, exit 1 if anything would |
| `--[no-]strict` | Warnings are errors |
| `-v, --verbose` | List every written file and print info diagnostics |
| `--diagnostics-format=text\|json\|github` | How diagnostics are printed (see [CI](#ci)) |

RegExps passed on the command line (`--ignore`, `--mustache`,
`--<target>-include`, `--<target>-ignore`) may be repeated or separated with
commas. A comma inside `{}`, `[]` or `()` does not split (`--ignore=^a{1,2}$`
is one pattern), and `\,` is a literal comma. In `sheety.yaml`, use a list.

Exit codes: `0` success, or up to date with `--check`; `1` `--check` found
differences; `2` errors (sheet diagnostics, unreadable source, output
conflicts); `64` invalid usage (unknown or removed option, bad config).

---

## Flutter (Dart) target

### Output

With the default options and `output: lib`:

```text
lib/
├── localization.dart                        barrel: exports flutter_localizations and everything below
├── sheety_manifest.json                     files owned by the generator (see Packaging)
└── src/generated/
    ├── locales.dart                         class Locales { static const Locale en, pt$BR, ...; values }
    ├── localization_meta.dart               metadata API (LocalizationScope, localizationScopes, ...)
    ├── app/
    │   ├── app_localization.dart            abstract class AppLocalization, delegate, lookupAppLocalization
    │   ├── app_localization_en.dart         one file per language...
    │   └── app_localization_pt.dart         ...with its regional subclasses (AppLocalizationPtBr)
    └── sign_up/
        └── ...
```

These are the same files, classes and signatures that `flutter gen-l10n`
produced with 0.6.x (`--no-nullable-getter`, output class
`<Scope>Localization`). Existing call sites keep compiling. The generated code
imports `package:flutter`, `package:flutter_localizations` and
`package:intl`, so the package that contains it needs:

```yaml
dependencies:
  flutter:
    sdk: flutter
  flutter_localizations:
    sdk: flutter
  intl: any # the version pinned by flutter_localizations
```

`flutter: generate: true` and `l10n.yaml` are not needed.

### Usage

```dart
import 'package:my_localization/localization.dart';

MaterialApp(
  localizationsDelegates: const [
    ...AppLocalization.localizationsDelegates, // includes the Global* delegates
    SignUpLocalization.delegate,
  ],
  supportedLocales: AppLocalization.supportedLocales,
  home: Builder(
    builder: (context) {
      final l10n = AppLocalization.of(context);
      return Text('${l10n.title}: ${l10n.notes(3)}');
    },
  ),
);

// Outside the widget tree:
final de = lookupAppLocalization(Locales.de);
de.greeting('Alice'); // Hallo, Alice!
```

`Locales` names a field after the locale (`en`, `pt$BR`, `zh$Hant$TW`); a
locale code that is a Dart reserved word gets a trailing `$` (`Locales.is$`
for Icelandic). Which class a `Locale` gets is decided by
`lookup<Scope>Localization` exactly like gen-l10n: language + script +
country, then language + script, then language + country, then the
language; which `Locale` the app runs in is Flutter's locale resolution over
`supportedLocales`.

Some names cannot be keys or placeholders because the generated code needs
them (`reserved-word`): the keys `intl`, `override`, `int`, `num`, `double`
and `dynamic` (they would hide the `intl` import prefix, `@override` and
types the class uses), gen-l10n's own members (`localeName`, `of`,
`delegate`, ...), and the placeholders `intl`, `localeName` and `_temp0`,
`_temp1`, ... (names the method bodies use).

### Metadata API (for tests)

Unless `metadata: false` is set, the output also has a small reflection layer,
generated into `localization_meta.dart`, so no runtime package is needed:

| API | What it gives |
|---|---|
| `localizationScopes` | Every scope: `name`, `baseLocale`, `supportedLocales`, `messages`, `delegate`, `lookup(Locale)` |
| `AppLocalization.messages` | Every message in sheet order: `key`, `description`, `placeholders` (`name`, `type`, `example`, `description`, `exampleValue`), `isGetter`, `exampleArguments` |
| `l10n.templates` | The source text of every message in this locale as written in the sheet: ICU, or mustache for a mustache sheet (fallbacks resolved) |
| `l10n.fallbackKeys` | Keys that this locale has no text of its own for |
| `l10n.format(key, args)` | Renders a message by key with named arguments, like calling the getter or method. Throws `ArgumentError` for an unknown key or a missing or mistyped argument. Numbers are checked by value, the same on the VM and the web: a `double` placeholder accepts any number, an `int` one a whole number (`2.0`, not `2.5`) |

Every generated class implements `LocalizationBundle` (`localeName`,
`templates`, `fallbackKeys`, `format`). Because of that, `messages`,
`templates`, `fallbackKeys`, `format` and `localizationArgument` (the helper
`format` calls) cannot be used as keys in the sheet (`reserved-word`); with
`metadata: false` they can. The keys `key` and `args` are fine: `format`
calls them as `this.key` / `this.args(...)`.

This test renders every message of every locale of every scope with the
examples from the `meta` column. It catches a broken plural, a missing
argument or a text that would throw, for every locale:

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:my_localization/localization.dart';

void main() {
  for (final scope in localizationScopes) {
    group(scope.name, () {
      for (final locale in scope.supportedLocales) {
        test('$locale', () {
          final l10n = scope.lookup(locale);
          for (final message in scope.messages) {
            final text = l10n.format(message.key, message.exampleArguments);
            expect(text, isNotEmpty, reason: '${scope.name}.${message.key}');
            for (final p in message.placeholders) {
              expect(text, isNot(contains('{${p.name}}')),
                  reason: '${scope.name}.${message.key} ($locale)');
            }
          }
          expect(l10n.templates.keys,
              containsAll(scope.messages.map((m) => m.key)));
        });
      }
    });
  }
}
```

`exampleValue` parses `example` for `int`/`num`/`double` placeholders (`1`
when it is missing). For the other types it uses `example`, or the
placeholder name when there is none.

---

## TypeScript target (Astro, SolidJS)

### Output

```text
web/src/i18n/
├── index.ts               export * as app ...; scopes, supportedLocales, baseLocale, resolveLocale()
├── meta.ts                metadata of every scope (tests, tooling)
├── runtime.ts             plural/select helpers, CLDR rules, negotiateLocale(), formatMessage(), types
├── sheety_manifest.json
└── app/
    ├── index.ts           scope, baseLocale, locales, type Locale, loaders, resolveLocale(), loadMessages()
    ├── types.ts           type AppMessages, type AppKey
    ├── en.ts              export const messages: AppMessages (frozen), one module per locale
    ├── pt-BR.ts
    ├── eager.ts           every locale statically imported, for SSR and static sites
    └── meta.ts            entries (raw templates, placeholders, fallbacks), format()
```

The output is ESM with explicit `.js` import suffixes. It compiles cleanly
under `strict`, `noUncheckedIndexedAccess` and `verbatimModuleSyntax`, with
both `NodeNext` and `Bundler` resolution, and has no dependencies. Locale
modules are named by BCP 47 tag (`pt-BR`). Keys are the sheet keys. A message
without placeholders is a `string`. A message with placeholders is a function
of an object with one property per placeholder: `String` is `string`,
`int`/`num`/`double` are `number`, and `Object` is `string | number`.
A key cannot be `then` (a dictionary with a `then` member is a "thenable",
so the Promise of its lazy loader would never resolve to it) or a member of
`Object.prototype` (`constructor`, `toString`, `__proto__`, ...).

```ts
import { app } from './i18n/index.js';

const locale = app.resolveLocale(navigator.languages); // 'de-AT' -> 'de' -> base
const t = await app.loaders[locale]();                  // one chunk per locale
t.title;                                                // 'Sheety Notizen'
t.notes({ count: 3 });                                  // '3 Notizen'
await app.loadMessages('pt-PT');                        // resolve + load in one call
```

`resolveLocale` accepts a tag or a list of tags. It matches case-insensitively
(`_` and `-` alike), drops subtags from the end (`zh-Hant-TW` → `zh-Hant` →
`zh`) and returns the base locale when nothing matches.

### SolidJS (`@solid-primitives/i18n`)

The dictionaries are plain objects of strings and functions, which is the
shape `@solid-primitives/i18n` expects:

```ts
import * as i18n from '@solid-primitives/i18n';
import { createResource, createSignal } from 'solid-js';
import { app } from './i18n/index.js';

export function useI18n() {
  const [locale, setLocale] = createSignal<app.Locale>(app.resolveLocale(navigator.languages));
  const [dict] = createResource(locale, (l) => app.loaders[l]()); // lazy, per locale
  const t = i18n.translator(dict);
  return { locale, setLocale, t };
}

// t('title'), t('notes', { count: 3 })
```

When the dictionaries must be there synchronously (SSR, tests), import the
eager bundle:

```ts
import { messages } from './i18n/app/eager.js';
const t = i18n.translator(() => messages.de);
```

### Astro

```js
// astro.config.mjs
import { defineConfig } from 'astro/config';
import { app } from '@acme/l10n'; // or a relative import of the generated index

export default defineConfig({
  i18n: { locales: [...app.locales], defaultLocale: app.baseLocale },
});
```

```astro
---
// src/pages/[...].astro (or any component)
import { app } from '@acme/l10n';

const locale = app.resolveLocale(Astro.currentLocale ?? Astro.preferredLocaleList ?? []);
const t = await app.loaders[locale]();
---
<h1>{t.title}</h1>
<p>{t.notes({ count: 2 })}</p>
```

### Metadata (tests)

`meta.ts` is separate, so production bundles never include it:

```ts
import assert from 'node:assert/strict';
import * as meta from './i18n/meta.js';
import type { MessageEntry } from './i18n/index.js';

interface ScopeMeta<L extends string> {
  readonly scope: string;
  readonly locales: readonly L[];
  readonly entries: readonly MessageEntry<L>[];
  format(locale: L, key: string, args?: Readonly<Record<string, unknown>>): Promise<string>;
}

async function checkScope<L extends string>(scope: ScopeMeta<L>): Promise<void> {
  for (const locale of scope.locales) {
    for (const entry of scope.entries) {
      const args = Object.fromEntries(
        entry.placeholders.map((p) => [
          p.name,
          p.type === 'String' || p.type === 'Object' ? (p.example ?? p.name) : Number(p.example ?? 1),
        ]),
      );
      const text = await scope.format(locale, entry.key, args);
      assert.ok(text.length > 0, `${scope.scope}.${entry.key} (${locale})`);
    }
  }
}

await checkScope(meta.app);
await checkScope(meta.sign_up);
```

Each entry has `key`, `description`, `placeholders` (`name`, `type`,
`example`, `description`, `declared`) and `templates[locale]` (`raw`,
`isFallback`, `source`).

---

## Python target (FastAPI)

### Output

The output directory is itself a package. All imports inside it are
relative, so it works as a top-level package (`src/myapp_l10n`) or as a
sub-package of your application (`myapp/l10n`).

```text
myapp/l10n/
├── __init__.py            SCOPES, SUPPORTED_LOCALES, BASE_LOCALE, get(scope, locale), resolve_locale()
├── _runtime.py            Localization base class, Message, Placeholder, CLDR plural rules,
│                          negotiate_locale(), parse_accept_language()
├── py.typed
├── sheety_manifest.json
└── backend_mail/
    ├── __init__.py        class BackendMailLocalization (abstract), get(locale), resolve_locale(),
    │                      LOCALES, BASE_LOCALE, MESSAGES, SCOPE, SHEET_TITLE, SYNTAX
    ├── _en.py             one module per locale, imported on first use
    └── _de.py
```

Python ≥ 3.9, no dependencies, and `mypy --strict` clean. Messages are
snake_case properties (no placeholders) or keyword-only methods: `String` is
`str`, `int` is `int`, `num`/`double` are `float`, and `Object` is `object`.

```python
from myapp.l10n import backend_mail, get

l10n = backend_mail.get("de-CH, de;q=0.9, en;q=0.5")  # a tag, a list or an Accept-Language header
l10n.welcome_subject(name="Alice")  # 'Willkommen bei Sheety Notes, Alice!'
l10n.LOCALE                         # 'de'

# Keys known only at runtime: the sheet key (or the raw label) and the
# placeholder names from the sheet.
get("backend-mail", "ru").format("trial.ends", days=7)
```

`get(locale)` negotiates the locale as described in
[Locale negotiation](#locale-negotiation-typescript-and-python). Instances are
cached.

A message may be named like a Python builtin (`property`, `str`, `int`, ...):
such a scope refers to the builtins as `_builtins.property`, `_builtins.str`,
so the class still works and type-checks.

### FastAPI

```python
from typing import Annotated, Dict

from fastapi import FastAPI, Header

from myapp.l10n import backend_mail

app = FastAPI()


@app.get("/welcome")
def welcome(name: str, accept_language: Annotated[str, Header()] = "en") -> Dict[str, str]:
    l10n = backend_mail.get(accept_language)
    return {"subject": l10n.welcome_subject(name=name), "locale": l10n.LOCALE}
```

### Metadata (tests)

```python
import importlib

import pytest

import myapp.l10n as l10n


def example_value(placeholder):
    if placeholder.type == "int":
        return int(placeholder.example or 1)
    if placeholder.type in ("num", "double"):
        return float(placeholder.example or 1)
    return placeholder.example or placeholder.name


CASES = [
    (scope, locale)
    for scope in l10n.SCOPES
    for locale in importlib.import_module(f"{l10n.__name__}.{scope}").LOCALES
]


@pytest.mark.parametrize("scope,locale", CASES)
def test_every_message_renders(scope, locale):
    localization = l10n.get(scope, locale)
    for message in localization.MESSAGES:
        args = {p.name: example_value(p) for p in message.placeholders}
        assert localization.format(message.key, **args)
        assert message.key in localization.TEMPLATES
```

Each localization also has `TEMPLATES` (raw texts by key), `FALLBACK_KEYS` and
`LOCALE`. `MESSAGES` entries have `key`, `attribute`, `description` and
`placeholders` (`name`, `parameter`, `type`, `example`, `description`).

---

## Locale negotiation (TypeScript and Python)

`resolveLocale` / `negotiateLocale` (TypeScript) and `get` /
`resolve_locale` / `negotiate_locale` (Python) implement one algorithm; a
shared test table runs against both runtimes:

1. The request is one tag (`pt-BR`), an HTTP `Accept-Language` header
   (anything containing `,` or `;`), a list of tags in order of preference
   (`navigator.languages`), or nothing (then the base locale).
2. An `Accept-Language` header is split at `,`; each item is
   `tag;param;...`. A `q` (or `Q`) value must be a plain decimal number
   (`0.8`, `1`, `.5`): above 1 counts as 1, anything else (`bad`, `1e-1`)
   as 0. Items with weight 0 and `*` are dropped; the rest is sorted by
   weight, equal weights keep their order.
3. Each tag is normalized: ASCII whitespace around it is ignored, so is
   everything from the first `.` or `@` (`en_US.UTF-8`, `de_AT@euro`); the
   rest is split at `-` and `_`. The first subtag must be a 2-3 letter
   language (`C`, `*` and the like are skipped), then an optional 4-letter
   script and an optional 2-letter or 3-digit region are taken while they
   come in that order; anything else (extensions `-u-...`, `-x-...`) ends the
   tag. Case is normalized (`zh-hant-tw` -> `zh_Hant_TW`).
4. For each tag in order, the candidates language+script+region,
   language+script, language+region and language are tried, then the same
   for the current code of a deprecated language (`iw` -> `he`, `in` -> `id`,
   `ji` -> `yi`, `jw` -> `jv`, `mo` -> `ro`); the first supported one wins
   (`pt-PT` -> `pt`, `zh-Hant-TW` -> `zh_Hant_TW`).
5. Otherwise, for each tag in order, the first supported locale of the same
   language wins (`pt` -> `pt_BR`, `es-MX` -> `es_419`).
6. Otherwise the base locale.

The Dart target leaves this to Flutter: the app's locale is chosen by
Flutter's locale resolution over `supportedLocales`, and
`lookup<Scope>Localization` maps it to a class the way gen-l10n does (see
[Usage](#usage)).

---

## Packaging the output for a registry

The generated code is meant to be wrapped in a package of its own and
published to pub.dev, a private pub server, an npm registry or a Python
index. The generator writes only the code. You add the package files once,
next to it or above it.

**Ownership.** Each target directory gets a `sheety_manifest.json` with the
generator version, a hash of the input, the scopes, locales, translation
coverage and the SHA-256 of every file the generator owns. On every run the
generator:

- rewrites only files whose content changed;
- deletes files it generated before that are no longer generated (a removed
  sheet or locale). A file edited by hand since is **kept** instead and is no
  longer owned (`modified-generated-file` warning); an edited file that is
  still generated is overwritten with the same warning;
- **never touches any other file**: a `pubspec.yaml`, `package.json`,
  `pyproject.toml`, `README.md` or `CHANGELOG.md` can sit in the same
  directory;
- refuses to overwrite a file it does not own (`unowned-file`). Without a
  manifest (first run, or a path that is new to the manifest), an existing
  file is taken over only when it is identical or carries the whole
  generated header as comment lines; a takeover that changes the file is
  reported (`took-over-file` warning).

Commit `sheety_manifest.json` with the code. Its `sourceHash` and per-locale
`coverage` are handy in release notes and version checks. The
[`example/`](example/) directory has all three packages below, ready to build.

### pub (Flutter package)

Generate into the package's `lib/` (`output: lib`) and add `pubspec.yaml`:

```yaml
name: my_localization
version: 1.4.0
publish_to: https://pub.example.com # your private pub server

environment:
  sdk: ^3.6.0
  flutter: ">=3.27.0"

dependencies:
  flutter:
    sdk: flutter
  flutter_localizations:
    sdk: flutter
  intl: any
```

Apps import `package:my_localization/localization.dart`.

### npm (TypeScript)

Generate into `src/i18n` and compile it to `dist` with `tsc`:

```json
{
  "name": "@acme/l10n",
  "version": "1.4.0",
  "type": "module",
  "sideEffects": false,
  "files": ["dist"],
  "exports": {
    ".": { "types": "./dist/index.d.ts", "default": "./dist/index.js" },
    "./*": { "types": "./dist/*.d.ts", "default": "./dist/*.js" }
  },
  "scripts": { "prepack": "tsc -p tsconfig.json" },
  "devDependencies": { "typescript": "^5.6.0" }
}
```

```json
{
  "compilerOptions": {
    "target": "ES2022",
    "module": "NodeNext",
    "moduleResolution": "NodeNext",
    "strict": true,
    "declaration": true,
    "rootDir": "src/i18n",
    "outDir": "dist"
  },
  "include": ["src/i18n/**/*.ts"]
}
```

`"type": "module"` is required because the output is ESM. `"sideEffects": false`
lets bundlers drop unused scopes and locales. Consumers import
`@acme/l10n` (scopes as namespaces), `@acme/l10n/app/eager` and
`@acme/l10n/meta`. Publish with `npm publish --registry=https://npm.example.com`.

### Python (wheel)

Generate into `src/myapp_l10n` and add `pyproject.toml`:

```toml
[build-system]
requires = ["setuptools>=69"]
build-backend = "setuptools.build_meta"

[project]
name = "myapp-l10n"
version = "1.4.0"
requires-python = ">=3.9"
dependencies = []

[tool.setuptools.packages.find]
where = ["src"]

[tool.setuptools.package-data]
"*" = ["py.typed"]
```

Build and upload with `python -m build` and
`twine upload --repository-url https://pypi.example.com dist/*`.

---

## CI

Generation needs only the Dart SDK (no Flutter). A typical job checks that
the committed code matches the sheet:

```yaml
# .github/workflows/l10n.yml
jobs:
  l10n:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: dart-lang/setup-dart@v1
      - run: dart pub global activate sheety_localization 1.0.0
      - run: printf '%s' "$GOOGLE_SHEETS_KEY" > credentials.json
        env:
          GOOGLE_SHEETS_KEY: ${{ secrets.GOOGLE_SHEETS_KEY }}
      - run: >
          dart pub global run sheety_localization:generate
          --check --strict --diagnostics-format=github
```

- `--check` writes nothing. It lists the added (`+`), changed (`~`) and
  removed (`-`) files and exits with `1` when the output is stale.
  `dart format` still runs, so the comparison is stable; use the same
  `--[no-]format` setting as when generating.
- `--strict` turns warnings (missing CLDR plural categories, tag mismatches,
  unknown locales…) into errors.
- `--diagnostics-format=github` prints `::error` / `::warning` annotations
  (titled with the code and cell, e.g. `sheety icu-syntax app!E12`) plus the
  usual text. `json` prints one JSON document on stdout (`ok`, `exitCode`,
  `summary`, `targets`, `issues`, `diagnostics`, each diagnostic with `code`,
  `severity`, `message`, `scope`, `sheet`, `row`, `column`, `locale`, `key`)
  and logs to stderr, also for a bad command line, configuration or
  credentials. Annotation paths are relative to `GITHUB_WORKSPACE` (or the
  working directory).

**Offline / reproducible runs.** Save the sheet once, commit the snapshot,
and generate from it without credentials:

```sh
dart run sheety_localization:generate --sheet=<id> --dump-snapshot=l10n/sheets.json   # no target needed
dart run sheety_localization:generate --snapshot=l10n/sheets.json --check
```

A snapshot is `{"sheets": [{"title": "...", "values": [["label", ...], ...]}]}`
and contains every sheet, including ignored ones.

---

## Diagnostics

Every problem has a stable code, so it can be grepped or filtered. Errors stop
generation and nothing is written. Warnings become errors with `--strict`.
Infos are shown with `-v`.

| Code | Severity | Meaning |
|---|---|---|
| `icu-syntax` | error | The cell is not valid ICU (or mustache) within the supported subset, at the reported offset |
| `plural-missing-other` | error | A plural or select has no `other` branch |
| `placeholder-mismatch` | error | A translation uses placeholders the base text does not, or misses one it has |
| `placeholder-type` | error | A plural count is not `int`/`num`, a select choice is not `String`, or one name is used as both |
| `select-duplicate-case` | error | A select has the same case twice |
| `duplicate-label` | error | Two rows have the same key after sanitizing |
| `duplicate-scope` | error | Two sheets have the same scope name after sanitizing; the second is skipped |
| `empty-base` | warning | The base-language cell of a row is empty; the message is left out |
| `unsupported-meta` | error | `meta` uses `DateTime`, an unknown type, `format`, `optionalParameters`… |
| `invalid-meta-json` | error | `meta` is not a JSON object |
| `reserved-word` | error | A key, placeholder or scope is a reserved word of a target (`class`, Python `def`) or a name the generated code uses itself (Dart `format`, `intl`, `override`; TypeScript `then`; Python `get`) |
| `invalid-identifier` | error | A name is not a valid identifier in a target (a key or sheet title starting with a digit, a Dart key starting with an upper-case letter) |
| `name-collision` | error | Two names collide after case conversion (Python `fooBar` and `foo_bar`), or two scopes give the same class or (case-insensitively) directory (`rate-us-2` and `rate_us2` are both `RateUs2Localization`) |
| `plural-missing-category` | warning | A plural lacks a category CLDR requires for the locale (`ru` needs `one few many other`); `other` is used |
| `plural-exact-as-category` | warning | An exact `=0`/`=1`/`=2` stands in for `zero`/`one`/`two`, but that category also covers other numbers in the locale (Russian `=1{…}` without `one{…}` is also shown for 21, 31…); add the keyword case |
| `plural-duplicate-case` | warning | A plural has `=1` and `one` (or similar); the later branch wins, as in gen-l10n |
| `tag-mismatch` | warning | Markup tags differ from the base text or are not balanced |
| `unused-placeholder` | warning | A placeholder declared in `meta` is used by no text |
| `invalid-locale` | warning | A header cell is not a locale code; the column is skipped |
| `unknown-locale` | warning | A well-formed locale code of an unknown language; the column is kept |
| `duplicate-locale` | warning | Two header cells denote the same locale; the later column is skipped |
| `empty-label` | warning | A row has texts but no label; it is skipped |
| `short-row` | warning | With `include_empty: false`: a row shorter than the header was skipped |
| `parent-overridden` | warning | With `legacy_regional_override`: a regional column overwrote its language's column |
| `fallback` | info | Messages of a locale use the parent or base text (with counts and keys) |
| `synthetic-locale` | info | A parent locale (`pt`) was generated from a regional column (`pt_BR`) |
| `not-localization-sheet` | info | A sheet without the localization header is skipped |
| `empty-row` | info | An empty row is skipped |
| `non-string-cell` | info | A number or boolean cell was converted to text |
| `invalid-unicode` | warning | A cell or sheet title contains a lone UTF-16 surrogate; values keep it, comments show U+FFFD |
| `plural-rules-mismatch` | warning | The Dart target (intl has no rules for the locale) and the TypeScript/Python targets (CLDR) render a plural differently |

Problems outside the sheet are reported with these codes:

| Code | Severity | Meaning |
|---|---|---|
| `unowned-file` | error | A file not generated by this tool is in the way; move it or choose another output |
| `invalid-manifest` | error | `sheety_manifest.json` cannot be read; delete it to let the generator take over again |
| `foreign-manifest` | error | The `sheety_manifest.json` in the output belongs to another target (two targets' directories mixed up); nothing is deleted |
| `case-collision` | error | Two generated paths differ only in case |
| `path-traversal`, `duplicate-output` | error | An output path escapes the directory, or is generated twice |
| `reserved-file-name` | error | A generated path has a segment Windows cannot create (`con`, `nul`, `com1`…, from a sheet title or locale) |
| `unknown-option`, `invalid-option` | error | An unknown key under `targets.<target>.options`, or a value of the wrong type |
| `no-scopes` | error | A target's filters select no localization sheet |
| `source-error` | error | The sheet or snapshot cannot be read (error messages never quote the credentials file) |
| `usage-error`, `config-error`, `internal-error` | error | Bad command line, invalid `sheety.yaml`, or an unexpected failure (exit code 64, 2, 2); also reported in `json` / `github` format |
| `format-failed`, `emitter-failed`, `write-failed`, `snapshot-write` | error | `dart format`, an emitter, or writing a file failed. Writing is staged (see below), so `write-failed` says exactly which targets were written |
| `legacy-output` | warning | First run: files that look generated but are not produced any more (old ARBs, removed scopes). They are left untouched; delete them |
| `modified-generated-file` | warning | A generated file was edited by hand: a stale one is kept and no longer owned, one that is still generated is overwritten |
| `took-over-file` | warning | Files without a manifest entry that carried the generated header were taken over and rewritten |

Writing is staged: the new files of every target are first written into a
`.sheety-staging-<target>` directory inside the target's output directory. Only when
all of them were written are they moved into place, target by target (stale
files are deleted first, the manifest is written last); the staging
directories are then removed. When staging fails, nothing was written. A
failure while moving files into place is rare (a rename on the same file
system); the `write-failed` message then lists the targets written completely
and the one left partly written (also `"partial": true` in `json`), and the
next run repairs it. Deleting before
moving also makes renaming a sheet by case only (`chat` -> `Chat`) work on
case-insensitive file systems (macOS, Windows).

---

## Migrating from 0.6.x

1.0.0 no longer writes ARB files or runs `flutter gen-l10n`. It generates the
same Dart API directly.

**Removed options.** Each one fails with an explanation (exit code 64):

| 0.6.x | 1.0.0 |
|---|---|
| `--arb`, `-a` | Removed: no ARB files. Delete the old ARB directory (`lib/src/l10n`) |
| `--prefix` | Removed (it named the ARB files) |
| `--author`, `--comment`, `--context` | Removed (ARB metadata). Use `--header` / `header:` to put text into every file |
| `--modified`, `--[no-]last-modified` | Removed: the output has no timestamps and is deterministic |

**Kept.** `--lib=<dir>` and `--gen=<subdir>` still work. They select the Dart
target with output `<dir>` (default `lib`) and the per-scope files under
`<subdir>` (default `src/generated`), the same layout as before. They cannot
be combined with `--dart`. The equivalent `sheety.yaml` is:

```yaml
targets:
  dart:
    output: lib
    options: { directory: src/generated, barrel: localization.dart }
```

`--sheet`, `--credentials`, `--ignore`, `--header`, `--[no-]format` and
`--[no-]include-empty` keep their meaning, but the default of
`--include-empty` is now on (see below). 0.6.x defaulted `--lib` to `lib`;
1.0.0 needs a target, so a bare `generate --sheet=…` now asks for one. Pass
`--lib=lib` or `--dart=lib`.

**First run over the old output.** Without a manifest, files at the generated
paths that carry the generated header are taken over and rewritten. Old ARB
files and the files of scopes that are no longer generated are **not**
deleted. They are listed in a `legacy-output` warning; delete them yourself.
From then on the manifest tracks ownership.

**Behaviour changes:**

- **Regional columns.** 0.6.x let the first regional column of a language
  overwrite the language's own column: real `ar` texts were replaced by
  `ar_EG`. Now `ar` keeps its texts and `ar_EG` overrides only its own
  cells. Synthetic parents (`pt` from `pt_BR`) work as before.
  `--legacy-regional-override` restores the old behaviour.
- **Short rows.** 0.6.x dropped a row from every locale when the Sheets API
  omitted its trailing empty cells, that is, when the last locale column was
  empty. Now the missing cells fall back to the parent or base text.
  `--no-include-empty` restores the old behaviour.
- **Duplicate labels** used to overwrite each other silently. Now they are an
  error.
- **Stricter ICU.** Texts that gen-l10n mis-parsed silently (a stray `}`,
  `=3{…}`) are errors.
- **Diagnostics.** The whole sheet is validated and every problem is
  reported, instead of failing at the first one inside gen-l10n.
- **CI no longer needs Flutter** to generate. The app that uses the code still
  needs `flutter_localizations` and `intl`.
- **New members.** The generated classes gain `messages`, `templates`,
  `fallbackKeys` and `format` (the [metadata API](#metadata-api-for-tests)).
  `metadata: false` removes them.

---

## AI-powered localization (`localize`)

Besides generating code, Sheety Localization can translate missing cells in
your Google Sheet with the OpenAI API and write them back. The service account
needs **Editor** access.

### Basic command

```bash
dart pub global run sheety_localization:localize \
  --credentials=credentials.json \
  --sheet=<YOUR_SPREADSHEET_ID> \
  --token=<YOUR_OPENAI_API_KEY> \
  --model=gpt-5-mini \
  --batch=3 \
  --workers=6
```

### Localize option definitions

- `--credentials` (or `-c`):
  Path to your Service Account JSON file. Defaults to `credentials.json`.
- `--sheet` (or `-s`) **(required)**:
  The Google Spreadsheet ID.
- `--token` (or `-t`):
  OpenAI API key (e.g. `sk-...`).
- `--token-file` (or `-f`):
  Path to a file containing the OpenAI API key (alternative to `--token`).
- `--model` (or `-m`):
  OpenAI model to use. Defaults to `gpt-5-mini`.
- `--batch` (or `-b`):
  Number of languages to translate per single API call. Defaults to `3`. Higher values are faster but may reduce quality for weaker models. Range: 1–20.
- `--workers` (or `-w`):
  Number of concurrent API requests. Defaults to `6`, max `14`.
- `--timeout`:
  Hard timeout of a single OpenAI request, in seconds. Defaults to `120`, range 10–900. A request that the model never finishes is aborted instead of stalling a worker forever.
- `--ignore` (or `-i`):
  Comma-separated list of **regular expressions** — not globs — matched against sheet titles; a sheet whose title matches any of them is skipped (e.g. `^help$,^backend,^temp-`). The match is unanchored, so `backend` also skips `backend-billing`; anchor with `^`/`$` when you want an exact title. A glob-looking `temp-*` means "temp followed by any number of dashes" and will not do what you expect.
- `--prompt` (or `-p`):
  Path to a custom system prompt file for the AI model.

`localize` does not read `sheety.yaml`; pass its options on the command line.

### How localization failures are handled

> **Only localization sheets are written to.** A sheet is localized only when its header matches `label | description | meta | <source> | <locale> ...` — that is, when the fourth column is a recognized source language. It does not have to be English: `ru`, `de`, `pt_BR` and any other known language code work just as well, and the rest of the row is translated *from* that language. Reference tables and notes kept in the same spreadsheet have ordinary data in the fourth column (e.g. `Family`, `Region`), which is not a language, so they are skipped with a warning rather than overwritten with translations. `--ignore` remains available for sheets that *do* match the layout but should be left alone anyway.

Language models are unreliable on ambiguous or rare locale codes, so `localize` defends against that:

- **Every locale code is spelled out for the model** — name, native endonym and, for codes that are routinely misread, an explicit warning. `uk` is sent as `uk — Ukrainian (українська) — Ukrainian (Cyrillic script). NOT English and NOT "United Kingdom"`, so it can no longer come back as English.
- **A failed batch is split, not retried.** If a request for a batch of languages fails — timeout, truncated or invalid JSON, garbage output — the batch is *not* re-sent as-is. Each language of that batch is retried on its own, so one problematic rare language cannot take its neighbours down with it.
- **Every translation is validated before it is written**: non-empty, ICU placeholders (`{name}`) and markup tags preserved exactly, no leaked markdown fences, no runaway output. An ICU source must give a translation that `generate`'s ICU parser accepts, with every placeholder used the same way (argument, plural or select); a `{{name}}` source must keep its `{{name}}` placeholders. A translation that fails validation is retried alone; only that one language is affected.
- **Partial rows are still saved.** Languages that succeeded are written to the sheet even if one of their neighbours never worked; the failed cell stays empty and is picked up on the next run.

Run `generate` after `localize`: it validates the new translations as well
(placeholders, plural categories, tags) before any code is produced.

---

## Docker

A minimal Docker image with AOT-compiled `generate` and `localize` binaries is available on DockerHub. No Dart SDK installation required.

### Pull

```bash
docker pull plugfox/sheety:latest
```

### Generate localization code

Mount the project and run from it, so `sheety.yaml` and its relative paths
resolve:

```bash
docker run --rm \
  -v "$(pwd):/work" -w /work \
  plugfox/sheety:latest \
    --config=sheety.yaml \
    --no-format
```

Or without a configuration file:

```bash
docker run --rm \
  -v "$(pwd)/credentials.json:/credentials.json:ro" \
  -v "$(pwd)/lib:/output" \
  plugfox/sheety:latest \
    --credentials=/credentials.json \
    --sheet=<YOUR_SPREADSHEET_ID> \
    --dart=/output \
    --no-format
```

> **Note:** `--no-format` is needed inside Docker, because `dart format` is not available in the minimal image. Format the generated Dart files on the host afterwards, and run `--check` with the same setting.

The default entrypoint is `/bin/generate`.

### AI-powered localization (translate missing cells)

Override the entrypoint to use `/bin/localize`:

```bash
docker run --rm \
  --entrypoint /bin/localize \
  -v $(pwd)/credentials.json:/credentials.json:ro \
  plugfox/sheety:latest \
    --credentials=/credentials.json \
    --sheet=<YOUR_SPREADSHEET_ID> \
    --token=<YOUR_OPENAI_API_KEY> \
    --model=gpt-5-mini \
    --batch=3 \
    --workers=6
```

Alternatively, pass the API key via a file:

```bash
docker run --rm \
  --entrypoint /bin/localize \
  -v $(pwd)/credentials.json:/credentials.json:ro \
  -v $(pwd)/openai_token.txt:/token.txt:ro \
  plugfox/sheety:latest \
    --credentials=/credentials.json \
    --sheet=<YOUR_SPREADSHEET_ID> \
    --token-file=/token.txt
```

### Custom system prompt for localization

```bash
docker run --rm \
  --entrypoint /bin/localize \
  -v $(pwd)/credentials.json:/credentials.json:ro \
  -v $(pwd)/my_prompt.txt:/prompt.txt:ro \
  plugfox/sheety:latest \
    --credentials=/credentials.json \
    --sheet=<YOUR_SPREADSHEET_ID> \
    --token=<YOUR_OPENAI_API_KEY> \
    --prompt=/prompt.txt
```

### Print help

```bash
# generate help
docker run --rm plugfox/sheety --help

# localize help
docker run --rm --entrypoint /bin/localize plugfox/sheety:latest --help
```

### Building the image locally

```bash
# Clone the repository
git clone https://github.com/DoctorinaAI/sheety_localization.git

# Navigate into the project directory
cd sheety_localization

# Local build
docker build -t username/sheety:latest .

# Multi-platform build and push to DockerHub
docker buildx build \
  --platform linux/amd64,linux/arm64 \
  -t username/sheety:latest \
  -t username/sheety:1.0.0 \
  --push .
```

---

## Tips

- **Commit the generated code and its `sheety_manifest.json`**, and run
  `--check` in CI, so a sheet edit can never silently change a release.
- **Never commit the service account key.** Inject it from a CI secret.
- **Pin the generator version** (`dart pub add --dev sheety_localization` or
  `dart pub global activate sheety_localization 1.0.0`). The output is
  deterministic for a given version, but may change between versions.
- **Keep non-localization tabs** (notes, glossaries) in the spreadsheet. They
  are skipped automatically, and you can list them in `ignore` to silence the
  info.
- **Snapshot before big edits** (`--dump-snapshot`). A snapshot diff in a pull
  request shows exactly what translators changed.

### Sample VS Code task

Copy the following into `.vscode/tasks.json` to run generation from the command palette:

```json
{
  "version": "2.0.0",
  "tasks": [
    {
      "label": "Generate Localization",
      "type": "shell",
      "command": "dart run sheety_localization:generate --config=sheety.yaml",
      "options": {
        "cwd": "${workspaceFolder}/packages/localization"
      },
      "problemMatcher": []
    }
  ]
}
```

- Open **Command Palette** -> **Tasks: Run Task** -> **Generate Localization**.

### Example: automatic Google Translate formula

If you want to auto-fill missing translations from English to Russian:

```plaintext
=IF(ISBLANK(D2), "", GOOGLETRANSLATE(D2, "en", "ru"))
```

- Place this formula in cell `E2` (under the `ru` column).
- Drag/fill down to apply to all rows.
- Cells with empty `en` will remain blank; otherwise, English text will be machine-translated to Russian.

### Example: conditional formatting rules

1. **Gray out machine translations**
   - Select entire column (e.g., column `E` for `ru`).
   - Add a custom formula rule: `=ISFORMULA(E2)`.
   - Set fill color to light gray.

2. **Highlight empty cells (missing translations)**
   - Select entire column (e.g., `E`).
   - Add a custom formula rule: `=E2=""`.
   - Set fill color to red (or any noticeable color).
