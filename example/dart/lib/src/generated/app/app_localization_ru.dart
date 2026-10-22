// This file is generated, do not edit it manually!

// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localization.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationRu extends AppLocalization {
  AppLocalizationRu([String locale = 'ru']) : super(locale);

  @override
  String get title => 'Заметки Sheety';

  @override
  String greeting(String name) {
    return 'Привет, $name!';
  }

  @override
  String notes(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count заметки',
      many: '$count заметок',
      few: '$count заметки',
      one: '$count заметка',
      zero: 'Нет заметок',
    );
    return '$_temp0';
  }

  @override
  String sharedBy(String gender, String name) {
    String _temp0 = intl.Intl.selectLogic(gender, {
      'male': '$name поделился заметкой',
      'female': '$name поделилась заметкой',
      'other': '$name поделились заметкой',
    });
    return '$_temp0';
  }

  @override
  String get terms => 'Я принимаю <b>условия</b>';

  @override
  String lastSync(Object time) {
    return 'Синхронизировано $time';
  }

  @override
  Map<String, String> get templates => _templatesRu;

  @override
  Set<String> get fallbackKeys => const <String>{};
}

const Map<String, String> _templatesRu = <String, String>{
  'title': 'Заметки Sheety',
  'greeting': 'Привет, {name}!',
  'notes':
      '{count, plural, =0{Нет заметок} one{{count} заметка} few{{count} заметки} many{{count} заметок} other{{count} заметки}}',
  'sharedBy':
      '{gender, select, male{{name} поделился заметкой} female{{name} поделилась заметкой} other{{name} поделились заметкой}}',
  'terms': 'Я принимаю <b>условия</b>',
  'lastSync': 'Синхронизировано {time}',
};
