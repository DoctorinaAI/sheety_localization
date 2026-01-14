# Sheety Localization

[![Checkout](https://github.com/DoctorinaAI/sheety_localization/actions/workflows/checkout.yml/badge.svg)](https://github.com/DoctorinaAI/sheety_localization/actions/workflows/checkout.yml)
[![Pub Package](https://img.shields.io/pub/v/sheety_localization.svg)](https://pub.dev/packages/sheety_localization)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Dart](https://img.shields.io/badge/Dart-%230175C2.svg?style=flat&logo=dart&logoColor=white)](https://dart.dev)
[![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=flat&logo=Flutter&logoColor=white)](https://flutter.dev)

**Sheety Localization** is a Dart console script that generates ARB files (Application Resource Bundle) and corresponding Dart localization classes from a Google Sheets spreadsheet. It uses the Google Sheets API to fetch localization tables and produces everything you need to integrate internationalization into your Flutter project.

---

## Features

- **Fetch data from Google Sheets** via Service Account credentials.
- **Generate ARB files** for each language column (e.g., `en`, `ru`, `fr`).
- **Produce a "library barrel" file** (e.g., `localization.dart`) that exports generated localization classes.
- **Generate Dart localization classes** under a configurable folder (e.g., `src/generated`).
- **Flexible directory structure** via command-line options:
  - Specify credentials JSON path (`--credentials`)
  - Provide the Google Spreadsheet ID (`--sheet`)
  - Configure output directories for ARB files (`--arb`) and generated Dart classes (`--gen`)
  - Customize ARB filename prefix (`--prefix`)
  - Insert author, comments, last-modified timestamp, and context metadata into generated files
- **Automatic `dart format`** of generated Dart files (enabled by default)
- **Default folder structure** if you don't override:
  - `credentials.json` in the working directory
  - Library barrel file under `lib/localization.dart`
  - ARB files under `lib/src/l10n/`
  - Generated Dart classes under `lib/src/generated/`

---

## TL;DR

1. **Create a properly formatted Google Sheet** with headers: `label | description | meta | en | ru | ... (other locales)`.
2. **Generate a Service Account** in Google Cloud, enable Sheets API, and share the sheet.
3. **Activate** Sheety Localization via `dart pub global activate sheety_localization`.
4. **Run** the generator:

   ```bash
   dart pub global run sheety_localization:generate \
     --credentials=credentials.json \
     --sheet=<YOUR_SPREADSHEET_ID> \
     --lib=lib \
     --arb=src/l10n \
     --gen=src/generated \
     --prefix=app \
     --format
   ```

5. **Import/Export** the generated barrel file (`lib/localization.dart`) in your Flutter project.
6. **Optionally** automate translation formulas, conditional formatting, VS Code tasks, and CI pipelines.

---

## Prerequisites

1. **Dart SDK >= 3.7.0 < 4.0.0**
2. **Service Account** with **Google Sheets API** enabled:

   - Create a new project in [Google Cloud Console](https://console.cloud.google.com/).
   - Enable **Google Sheets API** for that project.
   - Create a **Service Account** and download its credentials JSON (e.g., `credentials.json`).
   - Share your spreadsheet with the Service Account's email (visible in the credentials JSON).

3. **Google Sheet** laid out in the following format (each sheet/tab = one ARB file):
   - First row (header) must contain:
     ```
     label | description | meta | en | ru | es | de | ... (other locales)
     ```
   - Column definitions:
     - `label` - key (getter name) for your Dart code
     - `description` - human-readable note (e.g., Button text on login screen)
     - `meta` - JSON with metadata (e.g., plural rules, date formats, placeholders)
     - `en`, `ru`, `es`, `de` - one column per locale

---

## Installation

Activate the script globally so you can invoke the `generate` command from anywhere:

```bash
dart pub global activate sheety_localization
```

> **Note:** If you already have `sheety_localization` activated, run `dart pub global activate sheety_localization` again to upgrade to the latest version.

---

## Usage

After activation, run:

```bash
dart pub global run sheety_localization:generate --help
```

This will display the help message with all available options and their descriptions.

### Basic Command

```bash
dart pub global run sheety_localization:generate \
  --credentials=credentials.json \
  --sheet=<YOUR_SPREADSHEET_ID> \
  --lib=lib \
  --arb=src/l10n \
  --gen=src/generated \
  --prefix=app \
  --format
```

#### Option Definitions

- `--credentials` (or `-c`):
  Path to your Service Account JSON file. Defaults to `credentials.json` in the current directory.
- `--sheet` (or `-s`) **(required)**:
  The Google Spreadsheet ID (found in the sheet's URL, between `/d/` and `/edit`).
- `--lib` (or `-o`):
  Output root folder for the "library barrel" file (`localization.dart`). Defaults to `lib`.
- `--arb` (or `-a`):
  Relative path (under `--lib`) where ARB files will be written. Defaults to `src/l10n`.
- `--gen` (or `-g`):
  Relative path (under `--lib`) where generated Dart classes will be written. Defaults to `src/generated`.
- `--author`:
  String to insert as author in generated ARB files (e.g., `--author="Jane Doe <jane@example.com>"`).
- `--comment`:
  Description text to include in generated ARB files.
- `--modified`:
  Last modified timestamp for generated ARB files in ISO 8601 (e.g., `2025-06-04T12:30:00Z`). Defaults to the current time.
- `--context`:
  Arbitrary string (e.g., version number) to embed in ARB files.
- `--prefix`:
  Prefix for ARB filenames (e.g., `app` will produce `app_en.arb`, `app_ru.arb`, etc.). Defaults to `app`.
- `--header`:
  Custom header comment for each generated Dart file. Defaults to `// This file is generated, do not edit it manually!`.
- `--format` / `--no-format`:
  Whether to run `dart format` on generated Dart code. Enabled by default.
- `--include-empty`:
  Allow processing rows where Google Sheets API omits trailing empty locale cells.
  Missing translations are omitted per-locale (no key and no `@meta` entry).
  Default: disabled (rows with missing locale columns are skipped).
---

## Integration Steps

1. **Prepare your Google Sheet**

   - Create a new or reuse an existing Google Sheet.
   - For each sheet/tab within that spreadsheet, set up the header in the first row as follows: `label | description | meta | en | ru | es | de | ... (other locales)`.

   - Each subsequent row represents one localized string:

     - **`label`**: Unique key (used as a Dart getter name).
     - **`description`**: Short human-readable note (e.g., `"Login button text"`).
     - **`meta`**: JSON string with any metadata (e.g., `{"plural":"one","other":"{count} items"}`).
     - **`en`, `ru`, `es`, `de`, ...**: One column per locale.

2. **Create a Google Cloud project & Service Account**

   > **Note:** [How to use client libraries to access Google APIs](https://cloud.google.com/docs/authentication/client-libraries#creating_a_service_account)

   - Go to [Google Cloud Console](https://console.cloud.google.com/).
   - Create a new project or select an existing one.
   - Enable the **Google Sheets API** for that project.
   - Create a **Service Account** under IAM -> Service Accounts.
   - Grant it **"Viewer"** (or higher) access to the target spreadsheet.
   - Download the JSON key file (e.g., `credentials.json`).

3. **Share your spreadsheet with the Service Account**

   - In Google Sheets, click **Share** (top right).
   - Add your Service Account's email (from the JSON file) with **Viewer** or **Editor** rights.

4. **(Optional) Create a dedicated localization Dart package**
   If you want to keep generated localization code in its own package, set up a new Flutter package, for example:

   ```yaml
   # packages/localization/pubspec.yaml
   name: localization
   description: "Localization"
   version: 0.0.1
   environment:
     sdk: ">=3.7.0 <4.0.0"
     flutter: ">=3.29.3"

   dependencies:
     flutter:
       sdk: flutter
     flutter_localizations:
       sdk: flutter
   ```

   - Run `flutter pub get` (or `dart pub get`).
   - Later, import this package as a dependency in your app, and export the generated `localization.dart` barrel file.

5. **(Optional) Configure a VS Code task**
   If you use VS Code, add a task to automatically generate localization on demand. Create (or edit) `.vscode/tasks.json` in your package root:

   ```json
   {
     "version": "2.0.0",
     "tasks": [
       {
         "label": "Generate Localization",
         "type": "shell",
         "command": [
           "dart pub global activate sheety_localization",
           "&& dart pub global run sheety_localization:generate --credentials=credentials.json",
           "--sheet=1QgD5i0U-va3VrljXw8I3o8FxtMJAqrhk3ybbJ9O5mA4",
           "--lib=lib",
           "--arb=src/l10n",
           "--gen=src/generated",
           "--prefix=app",
           "--format"
         ],
         "options": {
           "cwd": "${workspaceFolder}/packages/localization"
         },
         "problemMatcher": []
       }
     ]
   }
   ```

   - Adjust `--sheet=<YOUR_SPREADSHEET_ID>` to match your actual ID.
   - Change `cwd` to point to your localization package location.

6. **(Optional) Add automatic translations via Google Sheets formulas**
   If you want to auto-fill missing translations, add a formula in your sheet cells. For example, in column `E2` (assuming `D2` is the source text in English):

   ```plaintext
   =IF(ISBLANK(D2), "", GOOGLETRANSLATE(D2, "en", "ru"))
   ```

   This formula translates the English text to Russian whenever `E2` is empty. Replace `"ru"` with any target locale code.

7. **(Optional) Conditional formatting to highlight missing or machine-translated cells**

   - Set up **Conditional Formatting** in Google Sheets:

     - Select all cells in a language column (e.g., column `E` for Russian).
     - Use a rule like `=ISFORMULA(E2)` to gray out any cell where a formula (i.e., machine translation) is used.
     - Use `=E2=""` to highlight cells that are still empty (missing translation).

8. **Run the generator**
   In your terminal (inside the package folder containing `credentials.json`), execute:

   ```bash
   dart pub global activate sheety_localization
   dart pub global run sheety_localization:generate \
     --credentials=credentials.json \
     --sheet=<YOUR_SPREADSHEET_ID> \
     --lib=lib \
     --arb=src/l10n \
     --gen=src/generated \
     --prefix=app \
     --format
   ```

   - This will produce:

     - `lib/localization.dart` (exports all generated classes)
     - One ARB file per sheet (e.g., `app_en.arb`, `app_ru.arb`, etc.) under `lib/src/l10n/`
     - One Dart file per locale under `lib/src/generated/` (e.g., `app_localizations_en.dart`, `app_localizations_ru.dart`, etc.)

---

9. **Add the generated localization package to your app**

   In your main Dart file (e.g., `main.dart`), import the generated localization
   and set up the localization delegates at MaterialApp:

   ```dart
   import 'package:localization/localization.dart';

   MaterialApp(
    // Add generated localization delegate here:
    localizationsDelegates: const <LocalizationsDelegate<Object?>>[
      AppLocalization.delegate,
      ErrorsLocalization.delegate,
      SignUpLocalization.delegate,
      ChatLocalization.delegate,
      SettingsLocalization.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
    ],
    supportedLocales: const <Locale>[
      Locale('en'),
      Locale('ru'),
      // Add other supported locales here
    ],
   ```

10. **Use the generated localization classes in your app**

    You can now access localized strings from context under the MaterialApp,
    using the generated localization classes. For example:

    ```dart
    String title = AppLocalization.of(context).title;
    ```

## Directory Structure Example

After you run the generator with default paths, your package might look like:

```
.vscode/
  tasks.json
packages/
  localization/
    credentials.json
    lib/
      localization.dart <- Barrel file (exports generated classes)
      src/
        l10n/
          app_en.arb
          app_ru.arb
          (other languages)
        generated/
          app_localizations_en.dart
          app_localizations_ru.dart
          (other languages)
    pubspec.yaml
```

- **`localization.dart`**:

  ```dart
  // GENERATED file: localization.dart
  // This file exports all generated localization classes.

  export 'src/generated/app_localizations_en.dart';
  export 'src/generated/app_localizations_ru.dart';
  // ... other exports
  ```

- **`app_en.arb`** (example):

  ```json
  {
    "@@locale": "en",
    "title": "Doctorina",
    "@title": {
      "description": "App title"
    },
    "checkVersionUpdateNowButton": "Update Now",
    "@checkVersionUpdateNowButton": {
      "description": "Button text to update now"
    }
    // ... more key-value pairs for English
  }
  ```

- **`app_localizations_en.dart`** (example):

  ```dart
  // GENERATED CODE - DO NOT MODIFY BY HAND
  // Author: Jane Doe <jane@example.com>
  // Generated by sheety_localization on 2025-06-04T15:23:21.739113Z

  import 'package:flutter/widgets.dart';
  import 'package:intl/intl.dart';
  import 'package:intl/message_lookup_by_library.dart';

  class AppLocalizationsEn {
    static Future<AppLocalizationsEn> load(Locale locale) {
      // load logic using ARB data
    }

    String get title => "Doctorina";
    String get checkVersionUpdateNowButton => "Update Now";
    // ... other getters
  }
  ```

(Actual generated Dart code may vary depending on your template and ARB contents.)

---

## Tips & Best Practices

- **Keep your ARB files under version control** (for reference and manual tweaks).
- **Do not commit service account JSON to public repos**. Store `credentials.json` securely, or inject it as CI secret.
- **Use `--author`, `--comment`, and `--modified` flags** to annotate generated files for auditing.
- If you add or remove columns in the sheet (e.g., adding `fr` for French), delete old ARB files or run the generator with `--prefix` set to a new value to force regeneration.
- To regenerate only a subset of sheets, you can temporarily hide unwanted sheets in Google Sheets, or maintain separate spreadsheets per feature set.

### Note about missing cells in Google Sheets

Google Sheets API may omit trailing empty cells in returned rows.
By default, such rows are skipped to avoid generating partially broken translations.
Use `--include-empty` to still generate available translations from these rows.

---

## Sample VS Code Task

Copy the following into `.vscode/tasks.json` to run generation from the command palette:

```json
{
  "version": "2.0.0",
  "tasks": [
    {
      "label": "Generate Localization",
      "type": "shell",
      "command": [
        "dart pub global activate sheety_localization",
        "&& dart pub global run sheety_localization:generate --credentials=credentials.json",
        "--sheet=1QgD5i0U-va3VrljXw8I3o8FxtMJAqrhk3ybbJ9O5mA4",
        "--lib=lib",
        "--arb=src/l10n",
        "--gen=src/generated",
        "--prefix=app",
        "--format"
      ],
      "options": {
        "cwd": "${workspaceFolder}/packages/localization"
      },
      "problemMatcher": []
    }
  ]
}
```

- Open **Command Palette** -> **Tasks: Run Task** -> **Generate Localization**.

---

## Example: Automatic Google Translate Formula

If you want to auto-fill missing translations from English to Russian:

```plaintext
=IF(ISBLANK(D2), "", GOOGLETRANSLATE(D2, "en", "ru"))
```

- Place this formula in cell `E2` (under the `ru` column).
- Drag/fill down to apply to all rows.
- Cells with empty `en` will remain blank; otherwise, English text will be machine-translated to Russian.

---

## Example: Conditional Formatting Rules

1. **Gray out machine translations**

   - Select entire column (e.g., column `E` for `ru`).
   - Add a custom formula rule: `=ISFORMULA(E2)`.
   - Set fill color to light gray.

2. **Highlight empty cells (missing translations)**

   - Select entire column (e.g., `E`).
   - Add a custom formula rule: `=E2=""`.
   - Set fill color to red (or any noticeable color).
