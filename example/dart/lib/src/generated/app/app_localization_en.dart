// This file is generated, do not edit it manually!

// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localization.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationEn extends AppLocalization {
  AppLocalizationEn([String locale = 'en']) : super(locale);

  @override
  String get title => 'Sheety Notes';

  @override
  String greeting(String name) {
    return 'Hello, $name!';
  }

  @override
  String notes(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count notes',
      one: 'One note',
      zero: 'No notes',
    );
    return '$_temp0';
  }

  @override
  String sharedBy(String gender, String name) {
    String _temp0 = intl.Intl.selectLogic(gender, {
      'male': '$name shared his note',
      'female': '$name shared her note',
      'other': '$name shared their note',
    });
    return '$_temp0';
  }

  @override
  String get terms => 'I accept the <b>terms</b>';

  @override
  String lastSync(Object time) {
    return 'Last synced $time';
  }

  @override
  Map<String, String> get templates => _templatesEn;

  @override
  Set<String> get fallbackKeys => const <String>{};
}

const Map<String, String> _templatesEn = <String, String>{
  'title': 'Sheety Notes',
  'greeting': 'Hello, {name}!',
  'notes': '{count, plural, =0{No notes} one{One note} other{{count} notes}}',
  'sharedBy':
      '{gender, select, male{{name} shared his note} female{{name} shared her note} other{{name} shared their note}}',
  'terms': 'I accept the <b>terms</b>',
  'lastSync': 'Last synced {time}',
};
