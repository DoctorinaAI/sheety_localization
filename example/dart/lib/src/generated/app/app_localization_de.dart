// This file is generated, do not edit it manually!

// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localization.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationDe extends AppLocalization {
  AppLocalizationDe([String locale = 'de']) : super(locale);

  @override
  String get title => 'Sheety Notizen';

  @override
  String greeting(String name) {
    return 'Hallo, $name!';
  }

  @override
  String notes(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Notizen',
      one: 'Eine Notiz',
      zero: 'Keine Notizen',
    );
    return '$_temp0';
  }

  @override
  String sharedBy(String gender, String name) {
    String _temp0 = intl.Intl.selectLogic(gender, {
      'male': '$name hat seine Notiz geteilt',
      'female': '$name hat ihre Notiz geteilt',
      'other': '$name hat eine Notiz geteilt',
    });
    return '$_temp0';
  }

  @override
  String get terms => 'Ich akzeptiere die <b>Bedingungen</b>';

  @override
  String lastSync(Object time) {
    return 'Zuletzt synchronisiert $time';
  }

  @override
  Map<String, String> get templates => _templatesDe;

  @override
  Set<String> get fallbackKeys => const <String>{};
}

const Map<String, String> _templatesDe = <String, String>{
  'title': 'Sheety Notizen',
  'greeting': 'Hallo, {name}!',
  'notes':
      '{count, plural, =0{Keine Notizen} one{Eine Notiz} other{{count} Notizen}}',
  'sharedBy':
      '{gender, select, male{{name} hat seine Notiz geteilt} female{{name} hat ihre Notiz geteilt} other{{name} hat eine Notiz geteilt}}',
  'terms': 'Ich akzeptiere die <b>Bedingungen</b>',
  'lastSync': 'Zuletzt synchronisiert {time}',
};
