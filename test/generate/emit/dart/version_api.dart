/// A release script that derives the semver bump of a package wrapping the
/// generated Dart from its public API by matching these expressions on the
/// sources. The generated code must keep matching them.
library;

/// The public surface of a generated `lib/`, as `tool/version.dart` sees it.
final class VersionApi {
  VersionApi._(this.members, this.locales);

  /// Reads [files] (path relative to `lib/` -> contents).
  factory VersionApi.of(Map<String, String> files) {
    final members = <String, String>{};
    final locales = <String>{};
    for (final MapEntry(key: relative, value: content) in files.entries) {
      if (!relative.endsWith('.dart')) continue;
      if (section.firstMatch(relative) != null) {
        final owner = abstractClass.firstMatch(content)?.group(1) ?? relative;
        for (final match in member.allMatches(content)) {
          final signature = match.group(1) != null
              ? ''
              : (match.group(3) ?? '').replaceAll(_spaces, ' ');
          members['$owner.${match.group(2)}'] =
              signature.replaceAll(', )', ')').replaceAll('( ', '(');
        }
      }
      if (relative.endsWith('locales.dart')) {
        for (final match in locale.allMatches(content)) {
          locales.add(
            [match.group(1), if (match.group(2) != null) match.group(2)]
                .join('_'),
          );
        }
      }
    }
    return VersionApi._(members, locales);
  }

  /// `Owner.key` -> `''` for a getter, `(<parameters>)` for a method.
  final Map<String, String> members;

  /// Locale codes found in `locales.dart`.
  final Set<String> locales;

  /// `src/generated/<section>/<section>_localization.dart`.
  static final RegExp section = RegExp(r'(?:^|/)(\w+)/\1_localization\.dart$');

  /// The owner of the members: the first abstract class.
  static final RegExp abstractClass = RegExp(r'abstract class (\w+)');

  /// An abstract `String` member.
  static final RegExp member = RegExp(
    r'^\s*String\s+(get\s+)?(\w+)\s*(\([^)]*\))?\s*;',
    multiLine: true,
  );

  /// A `Locale(...)` literal.
  static final RegExp locale = RegExp(r"Locale\('(\w+)'(?:,\s*'(\w+)')?\)");

  static final RegExp _spaces = RegExp(r'\s+');
}
