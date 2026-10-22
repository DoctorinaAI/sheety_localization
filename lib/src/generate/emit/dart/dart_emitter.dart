/// Dart (Flutter) code generator: a drop-in replacement for the output of
/// `flutter gen-l10n --no-nullable-getter`, without the Flutter tool.
library;

import 'package:path/path.dart' as p;

import '../../diagnostics.dart';
import '../../emitter.dart';
import '../../model.dart';
import '../../naming.dart';
import '../../validate.dart';
import 'dart_code.dart';
import 'layout.dart';
import 'locale_description.dart';

/// Options of the Dart target, read from [EmitOptions.options].
final class DartEmitOptions {
  /// Creates options.
  const DartEmitOptions({
    this.directory = 'src/generated',
    this.barrel = 'localization.dart',
    this.metadata = true,
    this.pageWidth = 80,
  });

  /// Reads the options from [options]: keys `directory`, `barrel`,
  /// `metadata` and `page_width` (also `pageWidth`).
  factory DartEmitOptions.from(EmitOptions options) => DartEmitOptions(
        directory: _relative(
          options.option<String>('directory', 'src/generated'),
          'directory',
        ),
        barrel: _relative(
          options.option<String>('barrel', 'localization.dart'),
          'barrel',
        ),
        metadata: options.option<bool>('metadata', true),
        pageWidth: options.option<int>(
          'page_width',
          options.option<int>('pageWidth', 80),
        ),
      );

  /// Directory of the generated scopes, `locales.dart` and
  /// `localization_meta.dart`, relative to the output root (POSIX, empty
  /// for the root itself). The previous generator's layout is
  /// `src/generated` under `lib/`.
  final String directory;

  /// Path of the barrel library exporting everything, relative to the
  /// output root; empty for no barrel. Default `localization.dart`, i.e.
  /// `lib/localization.dart` exporting `src/generated/...`.
  final String barrel;

  /// Whether to add the metadata API for tests (`localization_meta.dart`,
  /// `XLocalization.messages`, `templates`, `fallbackKeys`, `format`).
  /// Without it the output is the same as gen-l10n's.
  final bool metadata;

  /// Line length the code is laid out for.
  final int pageWidth;

  static String _relative(String path, String name) {
    final normalized = path.trim();
    if (normalized.isEmpty) return '';
    if (normalized.startsWith('/') ||
        normalized.contains(r'\') ||
        normalized.split('/').any((s) => s.isEmpty || s == '.' || s == '..')) {
      throw ArgumentError.value(
        path,
        name,
        'Must be a normalized relative POSIX path',
      );
    }
    return normalized;
  }
}

/// Generates Flutter localization classes.
///
/// Per scope `<dir>/<scope>/<scope>_localization.dart` (the abstract class,
/// delegate and lookup) and `<dir>/<scope>/<scope>_localization_<ll>.dart`
/// (one per language, with its regional subclasses), plus
/// `<dir>/locales.dart`, `<dir>/localization_meta.dart` (metadata only)
/// and the barrel. See [DartEmitOptions].
final class DartEmitter implements Emitter {
  /// Creates the emitter.
  const DartEmitter();

  /// Member names the generated classes use besides gen-l10n's own (which
  /// are in [dartClassMembers]) when the metadata API is generated: message
  /// keys must not take them then (`localizationArgument` is the helper
  /// `format` calls). See [validate].
  static const Set<String> reservedNames = {
    'messages',
    'templates',
    'fallbackKeys',
    'format',
    'localizationArgument',
  };

  /// Message keys `format` must call through `this.`: its parameters have
  /// these names.
  static const Set<String> formatParameters = {'key', 'args'};

  @override
  Target get target => Target.dart;

  /// Dart identifier diagnostics for [catalog] (already filtered to the
  /// scopes of this target) with the target [options]: [reservedNames] are
  /// reserved for message keys only when the metadata API is on.
  List<Diagnostic> validate(
    Catalog catalog,
    Map<String, Object?> options, {
    DiagnosticSink? sink,
  }) {
    final metadata = switch (options['metadata']) {
      final bool value => value,
      _ => true,
    };
    return validateIdentifiers(
      catalog,
      Target.dart,
      sink: sink,
      reservedByRole: {
        if (metadata) IdentifierRole.message: reservedNames,
      },
    );
  }

  @override
  List<GeneratedFile> emit(Catalog catalog, EmitOptions options) {
    final dart = DartEmitOptions.from(options);
    final context = _Context(options, dart);
    final files = <GeneratedFile>[];
    for (final scope in catalog.scopes) {
      files.addAll(_ScopeWriter(context, scope).files());
    }
    files.add(GeneratedFile(
        context.path('locales.dart'), _locales(context, catalog)));
    if (dart.metadata) {
      files.add(
        GeneratedFile(context.path(metaFile), _meta(context, catalog)),
      );
    }
    if (dart.barrel.isNotEmpty) {
      files.add(GeneratedFile(dart.barrel, _barrel(context, catalog)));
    }
    return files;
  }

  /// Name of the shared metadata library.
  static const String metaFile = 'localization_meta.dart';
}

final class _Context {
  _Context(this.options, this.dart) : layout = Layout(dart.pageWidth);

  final EmitOptions options;
  final DartEmitOptions dart;
  final Layout layout;

  String path(String relative) =>
      dart.directory.isEmpty ? relative : '${dart.directory}/$relative';

  /// The header comment lines, without a trailing newline ('' if none).
  String get header {
    final comment = options.headerComment('//');
    return comment.isEmpty ? '' : comment.substring(0, comment.length - 1);
  }

  /// [header] followed by a newline, or nothing.
  String get headerLine => header.isEmpty ? '' : '$header\n';
}

/// Lines of [text] with trailing whitespace removed (gen-l10n does this
/// for the main file; it only matters for doc comments).
String _trimLines(String text) =>
    text.split('\n').map((l) => l.trimRight()).join('\n');

// ---------------------------------------------------------------------------
// Scope files
// ---------------------------------------------------------------------------

final class _ScopeWriter {
  _ScopeWriter(this.context, this.scope)
      : className = scopeClassName(scope.name),
        fileStem = '${scope.name}_localization',
        locales = scope.sortedLocaleTags;

  final _Context context;
  final Scope scope;
  final String className;
  final String fileStem;

  /// Every locale, sorted by code (gen-l10n sorts the ARB files by path).
  final List<LocaleTag> locales;

  Layout get layout => context.layout;
  bool get metadata => context.dart.metadata;

  String get dir => context.path(scope.name);

  /// Bare languages, in sorted order.
  List<LocaleTag> get languages => [
        for (final l in locales)
          if (l.isLanguageOnly) l
      ];

  List<GeneratedFile> files() => [
        GeneratedFile('$dir/$fileStem.dart', _main()),
        for (final language in languages)
          GeneratedFile(
            '$dir/${fileStem}_${language.code}.dart',
            _languageFile(language),
          ),
      ];

  // -- main file -------------------------------------------------------------

  String _main() {
    final b = StringBuffer()
      ..write(context.headerLine)
      ..writeln("import 'dart:async';")
      ..writeln()
      ..writeln("import 'package:flutter/foundation.dart';")
      ..writeln("import 'package:flutter/widgets.dart';")
      ..writeln(
        "import 'package:flutter_localizations/flutter_localizations.dart';",
      )
      ..writeln("import 'package:intl/intl.dart' as intl;")
      ..writeln();
    if (metadata) {
      final meta = p.posix.relative(
        context.path(DartEmitter.metaFile),
        from: dir,
      );
      b.writeln("import '$meta';");
    }
    for (final language in languages) {
      b.writeln("import '${fileStem}_${language.code}.dart';");
    }
    b
      ..writeln()
      ..writeln('// ignore_for_file: type=lint')
      ..writeln()
      ..write(_classDoc())
      ..writeln(
        _classHeader(
          'abstract class $className',
          metadata ? 'implements LocalizationBundle' : null,
        ),
      )
      ..writeln(_constructor())
      ..writeln()
      ..writeln('  final String localeName;')
      ..writeln()
      ..write(_of())
      ..writeln()
      ..writeln(_delegateField())
      ..writeln()
      ..write(_delegatesDoc)
      ..writeln(
        layout.assignment(
          'static const List<LocalizationsDelegate<dynamic>> '
          'localizationsDelegates',
          const Group(
              '<LocalizationsDelegate<dynamic>>[',
              [
                Atom('delegate'),
                Atom('GlobalMaterialLocalizations.delegate'),
                Atom('GlobalCupertinoLocalizations.delegate'),
                Atom('GlobalWidgetsLocalizations.delegate'),
              ],
              ']'),
          indent: 2,
        ),
      )
      ..writeln()
      ..writeln(
          "  /// A list of this localizations delegate's supported locales.")
      ..writeln(
        layout.assignment(
          'static const List<Locale> supportedLocales',
          Group(
              '<Locale>[',
              [
                for (final l in locales) _localeLiteral(l),
              ],
              ']'),
          indent: 2,
        ),
      )
      ..writeln();
    final members = [
      for (final message in scope.messages) _abstractMember(message),
      if (metadata) ..._metadataMembers(),
    ];
    b
      ..write(members.join('\n'))
      ..writeln('}')
      ..writeln()
      ..write(_delegateClass())
      ..writeln()
      ..write(_lookupFunction());
    return _trimLines(b.toString());
  }

  String _classDoc() => '''
/// Callers can lookup localized strings with an instance of $className
/// returned by `$className.of(context)`.
///
/// Applications need to include `$className.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import '${scope.name}/$fileStem.dart';
///
/// return MaterialApp(
///   localizationsDelegates: $className.localizationsDelegates,
///   supportedLocales: $className.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the $className.supportedLocales
/// property.
''';

  static const String _delegatesDoc = '''
  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
''';

  /// `class X extends Y {`, split before the clause when too long.
  String _classHeader(String head, String? clause) {
    final line = clause == null ? '$head {' : '$head $clause {';
    if (clause == null || layout.fits(0, line)) return line;
    if (layout.fits(4, '$clause {')) return '$head\n    $clause {';
    final space = clause.indexOf(' ');
    return '$head\n    ${clause.substring(0, space)}\n'
        '        ${clause.substring(space + 1)} {';
  }

  String _constructor() {
    final head = '  $className(String locale)';
    const init =
        ': localeName = intl.Intl.canonicalizedLocale(locale.toString());';
    if (layout.fits(0, '$head $init')) return '$head $init';
    return '$head\n    $init';
  }

  String _of() {
    final signature = layout.statement(
      Group('static $className of(', const [Atom('BuildContext context')], ')'),
      indent: 2,
      suffix: ' {',
    );
    final body = layout.statement(
      Group(
        'return Localizations.of<$className>(',
        [const Atom('context'), Atom(className)],
        ')!',
      ),
      indent: 4,
      suffix: ';',
    );
    return '$signature\n$body\n  }\n';
  }

  List<Atom> _parameters(Message message) => [
        for (final placeholder in message.placeholders)
          Atom('${placeholder.type.arbName} ${placeholder.name}'),
      ];

  String _abstractMember(Message message) {
    final b = StringBuffer();
    final description = message.description;
    if (description == null) {
      b.writeln('  /// No description provided for @${message.key}.');
    } else {
      for (final line in commentText(description).split(RegExp('\r\n|\r|\n'))) {
        b.writeln('  /// $line');
      }
    }
    b
      ..writeln('  ///')
      ..writeln('  /// In ${scope.baseLocale.code}, '
          'this message translates to:')
      ..writeln("  /// **'${dartString(commentText(message.base.raw))}'**");
    if (message.hasPlaceholders) {
      b.writeln(
        layout.statement(
          Group('String ${message.key}(', _parameters(message), ')'),
          indent: 2,
          suffix: ';',
        ),
      );
    } else {
      b.writeln(
        layout.fits(2, 'String get ${message.key};')
            ? '  String get ${message.key};'
            : '  String\n  get ${message.key};',
      );
    }
    return b.toString();
  }

  // -- metadata members of the abstract class ----------------------------

  List<String> _metadataMembers() {
    final entries = [
      for (final message in scope.messages)
        Group(
            'LocalizationMessage(',
            [
              Atom(dartQuote(message.key)),
              if (message.description case final String description)
                Named('description', Atom(dartQuote(description))),
              if (message.hasPlaceholders)
                Named(
                  'placeholders',
                  Group(
                      '<LocalizationPlaceholder>[',
                      [
                        for (final placeholder in message.placeholders)
                          Group(
                              'LocalizationPlaceholder(',
                              [
                                Atom(dartQuote(placeholder.name)),
                                Named('type',
                                    Atom(dartQuote(placeholder.type.arbName))),
                                if (placeholder.example
                                    case final String example)
                                  Named('example', Atom(dartQuote(example))),
                                if (placeholder.description
                                    case final String description)
                                  Named('description',
                                      Atom(dartQuote(description))),
                              ],
                              ')'),
                      ],
                      ']'),
                ),
            ],
            ')'),
    ];
    final messages = StringBuffer()
      ..writeln('  /// Metadata of every message of [$className], '
          'in sheet order.')
      ..writeln(
        layout.assignment(
          'static const List<LocalizationMessage> messages',
          Group(
              '<LocalizationMessage>[',
              [
                ...entries,
              ],
              ']'),
          indent: 2,
        ),
      );
    final cases = <String>[
      for (final message in scope.messages)
        layout.arrow(
          dartQuote(message.key),
          message.hasPlaceholders
              ? Group(
                  '${_member(message.key)}(',
                  [
                    for (final placeholder in message.placeholders)
                      Atom(
                        'localizationArgument<${placeholder.type.arbName}>'
                        "(args, key, ${dartQuote(placeholder.name)})",
                      ),
                  ],
                  ')')
              : Atom(_member(message.key)),
          indent: 4,
          end: ',',
          continuation: 2,
        ),
      layout.arrow(
        '_',
        Group(
            'throw ArgumentError.value(',
            [
              const Atom('key'),
              const Atom("'key'"),
              Atom(dartQuote('Not a message of $className')),
            ],
            ')'),
        indent: 4,
        end: ',',
        continuation: 2,
      ),
    ];
    return [
      messages.toString(),
      '  /// The ICU text of every message in this locale, by key.\n'
          '  @override\n'
          '  Map<String, String> get templates;\n',
      '  /// Keys of the messages this locale has no text of its own for\n'
          '  /// (they use the text of the parent locale or the base '
          'language).\n'
          '  @override\n'
          '  Set<String> get fallbackKeys;\n',
      '  /// Renders the message [key] with the named [args] (placeholder\n'
          '  /// name -> value), like calling its getter or method.\n'
          '  ///\n'
          '  /// Throws an [ArgumentError] for an unknown key, a missing '
          'argument\n'
          '  /// or an argument of the wrong type.\n'
          '  @override\n'
          '  String format(\n'
          '    String key, [\n'
          '    Map<String, Object?> args = const <String, Object?>{},\n'
          '  ]) => switch (key) {\n'
          '${cases.map((c) => '$c\n').join()}'
          '  };\n',
    ];
  }

  /// [key] as a member access inside `format`, whose parameters `key` and
  /// `args` hide the messages of those names.
  String _member(String key) =>
      DartEmitter.formatParameters.contains(key) ? 'this.$key' : key;

  // -- delegate and lookup ------------------------------------------------

  String _delegateClass() {
    final delegate = '_${className}Delegate';
    final languageCodes = [for (final l in languages) Atom("'${l.language}'")];
    return '''
${_classHeader('class $delegate', 'extends LocalizationsDelegate<$className>')}
  const $delegate();

  @override
${layout.statement(Group('Future<$className> load(', const [
              Atom('Locale locale')
            ], ')'), indent: 2, suffix: ' {')}
${layout.statement(Group('return SynchronousFuture<$className>(', [
              Atom('lookup$className(locale)')
            ], ')'), indent: 4, suffix: ';')}
  }

  @override
${layout.arrow('bool isSupported(Locale locale)', Group('<String>[', languageCodes, '].contains(locale.languageCode)'), indent: 2)}

  @override
${_shouldReload(delegate)}
}
''';
  }

  /// `static const LocalizationsDelegate<X> delegate = _XDelegate();`,
  /// split the way `dart format` splits it for long class names.
  String _delegateField() {
    final type = 'LocalizationsDelegate<$className>';
    final value = '_${className}Delegate();';
    final line = '  static const $type delegate = $value';
    if (layout.fits(0, line)) return line;
    if (layout.fits(0, '  static const $type delegate =') &&
        layout.fits(6, value)) {
      return '  static const $type delegate =\n      $value';
    }
    if (layout.fits(0, '  static const $type')) {
      return '  static const $type\n  delegate = $value';
    }
    return '  static const LocalizationsDelegate<\n    $className\n  >\n'
        '  delegate = $value';
  }

  /// `X lookupX(Locale locale) {`, split like `dart format` does.
  String _lookupSignature() {
    final line = '$className lookup$className(Locale locale) {';
    if (layout.fits(0, line)) return line;
    if (layout.fits(0, '$className lookup$className(')) {
      return '$className lookup$className(\n  Locale locale,\n) {';
    }
    if (layout.fits(0, 'lookup$className(Locale locale) {')) {
      return '$className\nlookup$className(Locale locale) {';
    }
    return '$className\nlookup$className(\n  Locale locale,\n) {';
  }

  String _shouldReload(String delegate) {
    final line = '  bool shouldReload($delegate old) => false;';
    if (layout.fits(0, line)) return line;
    if (layout.fits(0, '  bool shouldReload($delegate old) =>')) {
      return '  bool shouldReload($delegate old) =>\n      false;';
    }
    return '  bool shouldReload(\n    $delegate old,\n  ) => false;';
  }

  String _lookupFunction() {
    final b = StringBuffer()..writeln(_lookupSignature());
    final sections = <String>[];

    final allCodes = [
      for (final l in locales)
        if (l.script != null && l.country != null) l,
    ];
    if (allCodes.isNotEmpty) {
      sections.add(
        '  // Lookup logic when language+script+country codes are specified.\n'
        '  switch (locale.toString()) {\n'
        '${allCodes.map((l) => _case(4, l.code, l)).join()}'
        '  }\n',
      );
    }
    String? nested(String comment, String field, bool Function(LocaleTag) test,
        String Function(LocaleTag) value) {
      final clauses = StringBuffer();
      for (final language in languages) {
        final matching = [
          for (final l in locales)
            if (l.language == language.language && test(l)) l,
        ];
        if (matching.isEmpty) continue;
        clauses
          ..writeln("    case '${language.language}':")
          ..writeln('      {')
          ..writeln('        switch (locale.$field) {')
          ..write(matching.map((l) => _case(10, value(l), l)).join())
          ..writeln('        }')
          ..writeln('        break;')
          ..writeln('      }');
      }
      if (clauses.isEmpty) return null;
      return '  // $comment\n'
          '  switch (locale.languageCode) {\n'
          '$clauses'
          '  }\n';
    }

    if (nested(
      'Lookup logic when language+script codes are specified.',
      'scriptCode',
      (l) => l.script != null && l.country == null,
      (l) => l.script!,
    )
        case final String section) {
      sections.add(section);
    }
    if (nested(
      'Lookup logic when language+country codes are specified.',
      'countryCode',
      (l) => l.country != null && l.script == null,
      (l) => l.country!,
    )
        case final String section) {
      sections.add(section);
    }
    if (languages.isNotEmpty) {
      sections.add(
        '  // Lookup logic when only language code is specified.\n'
        '  switch (locale.languageCode) {\n'
        '${languages.map((l) => _case(4, l.language, l)).join()}'
        '  }\n',
      );
    }
    b
      ..write(sections.join('\n'))
      ..writeln()
      ..writeln('  throw FlutterError(')
      ..writeln("    '$className.delegate failed to load unsupported locale "
          '"\$locale". This is likely \'')
      ..writeln("    'an issue with the localizations generation tool. "
          "Please file an issue '")
      ..writeln("    'on GitHub with a reproducible sample app and the "
          "gen-l10n configuration '")
      ..writeln("    'that was used.',")
      ..writeln('  );')
      ..writeln('}');
    return b.toString();
  }

  String _case(int indent, String value, LocaleTag locale) =>
      "${' ' * indent}case '$value':\n"
      '${' ' * (indent + 2)}return ${localeClassName(scope.name, locale)}();\n';

  // -- language files -----------------------------------------------------

  String _languageFile(LocaleTag language) {
    final header = context.header;
    final b = StringBuffer();
    if (header.isNotEmpty) {
      b
        ..writeln(header)
        ..writeln();
    }
    b
      ..writeln('// ignore: unused_import')
      ..writeln("import 'package:intl/intl.dart' as intl;")
      ..writeln()
      ..writeln("import '$fileStem.dart';")
      ..writeln()
      ..writeln('// ignore_for_file: type=lint')
      ..writeln();
    final languageClass = localeClassName(scope.name, language);
    final regional = [
      for (final l in locales)
        if (!l.isLanguageOnly && l.language == language.language) l,
    ];
    final constructor =
        "  $languageClass([String locale = '${language.code}'])";
    b
      ..writeln('/// The translations for ${describeLocale(language)} '
          '(`${language.code}`).')
      ..writeln(_classHeader('class $languageClass', 'extends $className'))
      ..writeln(
        layout.fits(0, '$constructor : super(locale);')
            ? '$constructor : super(locale);'
            : '$constructor\n    : super(locale);',
      )
      ..writeln();
    final members = [
      for (final message in scope.messages)
        _implementation(message, message.translationFor(language)),
      if (metadata) ..._localeMetadata(language),
    ];
    b
      ..write(members.join('\n'))
      ..writeln('}');
    for (final locale in regional) {
      final localeClass = localeClassName(scope.name, locale);
      final constructor = "  $localeClass() : super('${locale.code}');";
      b
        ..writeln()
        ..writeln('/// The translations for ${describeLocale(locale)} '
            '(`${locale.code}`).')
        ..writeln(_classHeader('class $localeClass', 'extends $languageClass'))
        ..writeln(
          layout.fits(0, constructor)
              ? constructor
              : "  $localeClass()\n    : super('${locale.code}');",
        );
      final members = [
        for (final message in scope.messages)
          if (message.translations[locale] case final Translation translation)
            _implementation(message, translation),
        if (metadata) ..._localeMetadata(locale),
      ];
      if (members.isNotEmpty) {
        b
          ..writeln()
          ..write(members.join('\n'));
      }
      b.writeln('}');
    }
    if (metadata) {
      for (final locale in [language, ...regional]) {
        b
          ..writeln()
          ..writeln(_templatesConstant(locale));
      }
    }
    return b.toString();
  }

  String _implementation(Message message, Translation translation) {
    final b = StringBuffer()..writeln('  @override');
    if (!message.hasPlaceholders && translation.ast.isPlainText) {
      final value = Atom(getterExpression(translation.ast));
      if (layout.fits(2, 'String get ${message.key} =>')) {
        b.writeln(
          layout.arrow('String get ${message.key}', value, indent: 2),
        );
      } else {
        // `dart format` moves `get` to its own line for very long keys.
        b
          ..writeln('  String')
          ..writeln(layout.arrow('get ${message.key}', value, indent: 2));
      }
      return b.toString();
    }
    final body = methodBody(translation.ast);
    b.writeln(
      layout.statement(
        Group('String ${message.key}(', _parameters(message), ')'),
        indent: 2,
        suffix: ' {',
      ),
    );
    for (final (name, call) in body.temps) {
      b.writeln(layout.assignment('String $name', call, indent: 4));
    }
    b
      ..writeln('    return ${body.result};')
      ..writeln('  }');
    return b.toString();
  }

  String _templatesName(LocaleTag locale) => '_templates${locale.camelCase}';

  List<String> _localeMetadata(LocaleTag locale) {
    final fallbacks = [
      for (final message in scope.messages)
        if (message.translationFor(locale).isFallback)
          Atom(dartQuote(message.key)),
    ];
    final templates = layout.arrow(
      'Map<String, String> get templates',
      Atom(_templatesName(locale)),
      indent: 2,
    );
    final fallbackKeys = layout.arrow(
      'Set<String> get fallbackKeys',
      Group('const <String>{', fallbacks, '}'),
      indent: 2,
    );
    return ['  @override\n$templates\n', '  @override\n$fallbackKeys\n'];
  }

  String _templatesConstant(LocaleTag locale) => layout.assignment(
        'const Map<String, String> ${_templatesName(locale)}',
        Group(
            '<String, String>{',
            [
              for (final message in scope.messages)
                Named(
                  dartQuote(message.key),
                  Atom(dartQuote(message.translationFor(locale).raw)),
                ),
            ],
            '}'),
        indent: 0,
      );
}

/// `Locale('pt', 'BR')`, as gen-l10n writes supported locales.
Code _localeLiteral(LocaleTag l) => switch ((l.script, l.country)) {
      (null, null) => Atom("Locale('${l.language}')"),
      (null, final String country) =>
        Atom("Locale('${l.language}', '$country')"),
      (final String script, final String? country) => Group(
          'Locale.fromSubtags(',
          [
            Named('languageCode', Atom("'${l.language}'")),
            if (country != null) Named('countryCode', Atom("'$country'")),
            Named('scriptCode', Atom("'$script'")),
          ],
          ')'),
    };

// ---------------------------------------------------------------------------
// Shared files
// ---------------------------------------------------------------------------

/// The field of [locale] in the `Locales` class of `locales.dart`, as the
/// previous generator named it (`en`, `pt$BR`, `zh$Hant$TW`); a Dart reserved
/// word gets a trailing `$` (`is$` for Icelandic).
String dartLocaleField(LocaleTag locale) {
  final field = [
    locale.language,
    if (locale.script != null) locale.script!,
    if (locale.country != null) locale.country!,
  ].join(r'$');
  return dartReservedWords.contains(field) ? '$field\$' : field;
}

/// `locales.dart`, as the previous generator wrote it (field `pt$BR`,
/// union of all locales in order of first appearance).
String _locales(_Context context, Catalog catalog) {
  final layout = context.layout;
  final fields = <String>[];
  final b = StringBuffer()
    ..write(context.headerLine)
    ..writeln('// ignore_for_file: directives_ordering')
    ..writeln()
    ..writeln("import 'dart:ui' show Locale;")
    ..writeln()
    ..writeln('/// Supported locales for the application.')
    ..writeln('abstract final class Locales {')
    ..writeln('  const Locales._();')
    ..writeln();
  for (final locale in catalog.locales) {
    final field = dartLocaleField(locale);
    fields.add(field);
    final literal = _localeLiteral(locale);
    b.writeln(
      layout.assignment('static const Locale $field', literal, indent: 2),
    );
  }
  b
    ..writeln()
    ..writeln(
      layout.assignment(
        'static const List<Locale> values',
        Group('[', [for (final f in fields) Atom(f)], ']'),
        indent: 2,
      ),
    )
    ..writeln('}');
  return b.toString();
}

/// The barrel: exports `flutter_localizations`, every scope, `locales.dart`
/// and (with metadata) `localization_meta.dart`.
String _barrel(_Context context, Catalog catalog) {
  final from = p.posix.dirname(context.dart.barrel);
  String uri(String path) => p.posix.relative(path, from: from);
  final b = StringBuffer()
    ..write(context.headerLine)
    ..writeln('// ignore_for_file: directives_ordering')
    ..writeln('library;')
    ..writeln()
    ..writeln(
      "export 'package:flutter_localizations/flutter_localizations.dart';",
    )
    ..writeln();
  for (final scope in catalog.scopes) {
    final file = '${scope.name}/${scope.name}_localization.dart';
    b.writeln("export '${uri(context.path(file))}';");
  }
  b.writeln("export '${uri(context.path('locales.dart'))}';");
  if (context.dart.metadata) {
    b.writeln("export '${uri(context.path(DartEmitter.metaFile))}';");
  }
  return b.toString();
}

/// `localization_meta.dart`: the metadata types and the scope registry.
String _meta(_Context context, Catalog catalog) {
  final layout = context.layout;
  final b = StringBuffer()
    ..write(context.headerLine)
    ..writeln('// ignore_for_file: type=lint')
    ..writeln()
    ..writeln("import 'package:flutter/widgets.dart';")
    ..writeln();
  for (final scope in catalog.scopes) {
    b.writeln("import '${scope.name}/${scope.name}_localization.dart';");
  }
  if (catalog.scopes.isNotEmpty) b.writeln();
  b.write(_metaTypes);
  final scopes = [
    for (final scope in catalog.scopes)
      Group(
          'LocalizationScope(',
          [
            Named('name', Atom(dartQuote(scope.name))),
            Named('baseLocale', _localeLiteral(scope.baseLocale)),
            Named(
              'supportedLocales',
              Atom('${scopeClassName(scope.name)}.supportedLocales'),
            ),
            Named('messages', Atom('${scopeClassName(scope.name)}.messages')),
            Named('delegate', Atom('${scopeClassName(scope.name)}.delegate')),
            Named('lookup', Atom('lookup${scopeClassName(scope.name)}')),
          ],
          ')'),
  ];
  b
    ..writeln()
    ..writeln('/// Every generated scope, in sheet order.')
    ..writeln(
      layout.assignment(
        'const List<LocalizationScope> localizationScopes',
        Group('<LocalizationScope>[', scopes, ']'),
        indent: 0,
      ),
    );
  return b.toString();
}

const String _metaTypes = r'''
/// A placeholder of a [LocalizationMessage].
final class LocalizationPlaceholder {
  /// Creates the metadata of a placeholder.
  const LocalizationPlaceholder(
    this.name, {
    required this.type,
    this.example,
    this.description,
  });

  /// Name of the placeholder: the parameter name of the generated method
  /// and the key of the argument in [LocalizationBundle.format].
  final String name;

  /// Dart type of the argument: `String`, `int`, `num`, `double` or
  /// `Object`.
  final String type;

  /// Example value from the sheet, if any.
  final String? example;

  /// Description from the sheet, if any.
  final String? description;

  /// A value of [type] for tests: [example] parsed as a number for numeric
  /// types (`1` when it is missing or not a number), otherwise [example] or,
  /// without one, [name].
  Object get exampleValue => switch (type) {
    'int' => int.tryParse(example ?? '') ?? 1,
    'double' => double.tryParse(example ?? '') ?? 1.0,
    'num' => num.tryParse(example ?? '') ?? 1,
    _ => example ?? name,
  };
}

/// A message of a scope: what a test needs to render it.
final class LocalizationMessage {
  /// Creates the metadata of a message.
  const LocalizationMessage(
    this.key, {
    this.description,
    this.placeholders = const <LocalizationPlaceholder>[],
  });

  /// Key of the message: the name of its getter or method.
  final String key;

  /// Description from the sheet, if any.
  final String? description;

  /// Placeholders in parameter order; empty for a getter.
  final List<LocalizationPlaceholder> placeholders;

  /// Whether the message is a getter (it has no placeholders).
  bool get isGetter => placeholders.isEmpty;

  /// Arguments for [LocalizationBundle.format] made of the
  /// [LocalizationPlaceholder.exampleValue]s.
  Map<String, Object> get exampleArguments => <String, Object>{
    for (final placeholder in placeholders)
      placeholder.name: placeholder.exampleValue,
  };
}

/// What every generated localization class offers besides its messages.
abstract interface class LocalizationBundle {
  /// The canonicalized locale of this instance (`pt_BR`).
  String get localeName;

  /// The ICU text of every message in this locale, by key.
  Map<String, String> get templates;

  /// Keys of the messages this locale has no text of its own for.
  Set<String> get fallbackKeys;

  /// Renders the message [key] with the named [args].
  String format(String key, [Map<String, Object?> args]);
}

/// A generated scope (one sheet): its messages, locales and lookup.
final class LocalizationScope {
  /// Creates the metadata of a scope.
  const LocalizationScope({
    required this.name,
    required this.baseLocale,
    required this.supportedLocales,
    required this.messages,
    required this.delegate,
    required this.lookup,
  });

  /// Name of the scope (the sanitized sheet title, `sign_up`).
  final String name;

  /// The base language of the sheet.
  final Locale baseLocale;

  /// The supported locales, as in the generated class.
  final List<Locale> supportedLocales;

  /// Every message, in sheet order.
  final List<LocalizationMessage> messages;

  /// The localizations delegate of the scope.
  final LocalizationsDelegate<LocalizationBundle> delegate;

  /// Returns the localization of a supported locale (the generated
  /// `lookup...` function).
  final LocalizationBundle Function(Locale locale) lookup;
}

/// The argument [name] of message [key] from [args], checked to be a [T].
///
/// Throws an [ArgumentError] when it is missing or of another type.
T localizationArgument<T extends Object>(
  Map<String, Object?> args,
  String key,
  String name,
) {
  final value = args[name];
  if (value is T) return value;
  throw ArgumentError.value(
    value,
    name,
    args.containsKey(name)
        ? 'Argument "$name" of message "$key" must be a $T'
        : 'Missing argument "$name" of message "$key"',
  );
}
''';
