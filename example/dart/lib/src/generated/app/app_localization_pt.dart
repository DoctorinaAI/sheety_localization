// This file is generated, do not edit it manually!

// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localization.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationPt extends AppLocalization {
  AppLocalizationPt([String locale = 'pt']) : super(locale);

  @override
  String get title => 'Notas Sheety';

  @override
  String greeting(String name) {
    return 'Olá, $name!';
  }

  @override
  String notes(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count notas',
      many: '$count de notas',
      one: 'Uma nota',
      zero: 'Nenhuma nota',
    );
    return '$_temp0';
  }

  @override
  String sharedBy(String gender, String name) {
    String _temp0 = intl.Intl.selectLogic(gender, {
      'male': '$name compartilhou a nota dele',
      'female': '$name compartilhou a nota dela',
      'other': '$name compartilhou uma nota',
    });
    return '$_temp0';
  }

  @override
  String get terms => 'Aceito os <b>termos</b>';

  @override
  String lastSync(Object time) {
    return 'Sincronizado $time';
  }

  @override
  Map<String, String> get templates => _templatesPt;

  @override
  Set<String> get fallbackKeys => const <String>{};
}

/// The translations for Portuguese, as used in Brazil (`pt_BR`).
class AppLocalizationPtBr extends AppLocalizationPt {
  AppLocalizationPtBr() : super('pt_BR');

  @override
  String get title => 'Notas Sheety';

  @override
  String greeting(String name) {
    return 'Olá, $name!';
  }

  @override
  String notes(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count notas',
      many: '$count de notas',
      one: 'Uma nota',
      zero: 'Nenhuma nota',
    );
    return '$_temp0';
  }

  @override
  String sharedBy(String gender, String name) {
    String _temp0 = intl.Intl.selectLogic(gender, {
      'male': '$name compartilhou a nota dele',
      'female': '$name compartilhou a nota dela',
      'other': '$name compartilhou uma nota',
    });
    return '$_temp0';
  }

  @override
  String get terms => 'Aceito os <b>termos</b>';

  @override
  String lastSync(Object time) {
    return 'Sincronizado $time';
  }

  @override
  Map<String, String> get templates => _templatesPtBr;

  @override
  Set<String> get fallbackKeys => const <String>{};
}

const Map<String, String> _templatesPt = <String, String>{
  'title': 'Notas Sheety',
  'greeting': 'Olá, {name}!',
  'notes':
      '{count, plural, =0{Nenhuma nota} one{Uma nota} many{{count} de notas} other{{count} notas}}',
  'sharedBy':
      '{gender, select, male{{name} compartilhou a nota dele} female{{name} compartilhou a nota dela} other{{name} compartilhou uma nota}}',
  'terms': 'Aceito os <b>termos</b>',
  'lastSync': 'Sincronizado {time}',
};

const Map<String, String> _templatesPtBr = <String, String>{
  'title': 'Notas Sheety',
  'greeting': 'Olá, {name}!',
  'notes':
      '{count, plural, =0{Nenhuma nota} one{Uma nota} many{{count} de notas} other{{count} notas}}',
  'sharedBy':
      '{gender, select, male{{name} compartilhou a nota dele} female{{name} compartilhou a nota dela} other{{name} compartilhou uma nota}}',
  'terms': 'Aceito os <b>termos</b>',
  'lastSync': 'Sincronizado {time}',
};
