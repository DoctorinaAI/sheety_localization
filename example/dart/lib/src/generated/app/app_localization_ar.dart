// This file is generated, do not edit it manually!

// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localization.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationAr extends AppLocalization {
  AppLocalizationAr([String locale = 'ar']) : super(locale);

  @override
  String get title => 'ملاحظات Sheety';

  @override
  String greeting(String name) {
    return 'مرحبا $name!';
  }

  @override
  String notes(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ملاحظة',
      many: '$count ملاحظة',
      few: '$count ملاحظات',
      two: 'ملاحظتان',
      one: 'ملاحظة واحدة',
      zero: 'لا ملاحظات',
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
  String get terms => 'أوافق على <b>الشروط</b>';

  @override
  String lastSync(Object time) {
    return 'Last synced $time';
  }

  @override
  Map<String, String> get templates => _templatesAr;

  @override
  Set<String> get fallbackKeys => const <String>{'sharedBy', 'lastSync'};
}

/// The translations for Arabic, as used in Egypt (`ar_EG`).
class AppLocalizationArEg extends AppLocalizationAr {
  AppLocalizationArEg() : super('ar_EG');

  @override
  String greeting(String name) {
    return 'أهلا $name!';
  }

  @override
  Map<String, String> get templates => _templatesArEg;

  @override
  Set<String> get fallbackKeys => const <String>{
        'title',
        'notes',
        'sharedBy',
        'terms',
        'lastSync',
      };
}

const Map<String, String> _templatesAr = <String, String>{
  'title': 'ملاحظات Sheety',
  'greeting': 'مرحبا {name}!',
  'notes':
      '{count, plural, zero{لا ملاحظات} one{ملاحظة واحدة} two{ملاحظتان} few{{count} ملاحظات} many{{count} ملاحظة} other{{count} ملاحظة}}',
  'sharedBy':
      '{gender, select, male{{name} shared his note} female{{name} shared her note} other{{name} shared their note}}',
  'terms': 'أوافق على <b>الشروط</b>',
  'lastSync': 'Last synced {time}',
};

const Map<String, String> _templatesArEg = <String, String>{
  'title': 'ملاحظات Sheety',
  'greeting': 'أهلا {name}!',
  'notes':
      '{count, plural, zero{لا ملاحظات} one{ملاحظة واحدة} two{ملاحظتان} few{{count} ملاحظات} many{{count} ملاحظة} other{{count} ملاحظة}}',
  'sharedBy':
      '{gender, select, male{{name} shared his note} female{{name} shared her note} other{{name} shared their note}}',
  'terms': 'أوافق على <b>الشروط</b>',
  'lastSync': 'Last synced {time}',
};
