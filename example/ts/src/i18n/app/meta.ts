// This file is generated, do not edit it manually!
/* eslint-disable */
// Metadata of the scope, for tests and tooling: raw ICU templates of every
// locale, placeholders with examples, fallbacks. Production code does not
// need to import it.
import { formatMessage } from '../runtime.js';
import type { MessageEntry } from '../runtime.js';
import { loaders } from './index.js';
import type { Locale } from './index.js';
import type { AppKey } from './types.js';

export { baseLocale, locales, scope } from './index.js';

/** Every message, in sheet order. */
export const entries: readonly MessageEntry<Locale, AppKey>[] = [
  {
    key: 'title',
    description: 'Application title',
    placeholders: [],
    templates: {
      'en': { raw: 'Sheety Notes', isFallback: false, source: 'en' },
      'de': { raw: 'Sheety Notizen', isFallback: false, source: 'de' },
      'ru': { raw: 'Заметки Sheety', isFallback: false, source: 'ru' },
      'pt-BR': { raw: 'Notas Sheety', isFallback: false, source: 'pt-BR' },
      'ar': { raw: 'ملاحظات Sheety', isFallback: false, source: 'ar' },
      'ar-EG': { raw: 'ملاحظات Sheety', isFallback: true, source: 'ar' },
      'pt': { raw: 'Notas Sheety', isFallback: false, source: 'pt-BR' },
    },
  },
  {
    key: 'greeting',
    description: 'Greets the user on the home screen',
    placeholders: [
      { name: 'name', type: 'String', example: 'Alice', description: 'First name of the user', declared: true },
    ],
    templates: {
      'en': { raw: 'Hello, {name}!', isFallback: false, source: 'en' },
      'de': { raw: 'Hallo, {name}!', isFallback: false, source: 'de' },
      'ru': { raw: 'Привет, {name}!', isFallback: false, source: 'ru' },
      'pt-BR': { raw: 'Olá, {name}!', isFallback: false, source: 'pt-BR' },
      'ar': { raw: 'مرحبا {name}!', isFallback: false, source: 'ar' },
      'ar-EG': { raw: 'أهلا {name}!', isFallback: false, source: 'ar-EG' },
      'pt': { raw: 'Olá, {name}!', isFallback: false, source: 'pt-BR' },
    },
  },
  {
    key: 'notes',
    description: 'Number of notes in the list',
    placeholders: [
      { name: 'count', type: 'int', example: '3', description: null, declared: true },
    ],
    templates: {
      'en': { raw: '{count, plural, =0{No notes} one{One note} other{{count} notes}}', isFallback: false, source: 'en' },
      'de': { raw: '{count, plural, =0{Keine Notizen} one{Eine Notiz} other{{count} Notizen}}', isFallback: false, source: 'de' },
      'ru': { raw: '{count, plural, =0{Нет заметок} one{{count} заметка} few{{count} заметки} many{{count} заметок} other{{count} заметки}}', isFallback: false, source: 'ru' },
      'pt-BR': { raw: '{count, plural, =0{Nenhuma nota} one{Uma nota} many{{count} de notas} other{{count} notas}}', isFallback: false, source: 'pt-BR' },
      'ar': { raw: '{count, plural, zero{لا ملاحظات} one{ملاحظة واحدة} two{ملاحظتان} few{{count} ملاحظات} many{{count} ملاحظة} other{{count} ملاحظة}}', isFallback: false, source: 'ar' },
      'ar-EG': { raw: '{count, plural, zero{لا ملاحظات} one{ملاحظة واحدة} two{ملاحظتان} few{{count} ملاحظات} many{{count} ملاحظة} other{{count} ملاحظة}}', isFallback: true, source: 'ar' },
      'pt': { raw: '{count, plural, =0{Nenhuma nota} one{Uma nota} many{{count} de notas} other{{count} notas}}', isFallback: false, source: 'pt-BR' },
    },
  },
  {
    key: 'sharedBy',
    description: 'Who shared a note',
    placeholders: [
      { name: 'gender', type: 'String', example: 'female', description: null, declared: true },
      { name: 'name', type: 'String', example: 'Alice', description: null, declared: true },
    ],
    templates: {
      'en': { raw: '{gender, select, male{{name} shared his note} female{{name} shared her note} other{{name} shared their note}}', isFallback: false, source: 'en' },
      'de': { raw: '{gender, select, male{{name} hat seine Notiz geteilt} female{{name} hat ihre Notiz geteilt} other{{name} hat eine Notiz geteilt}}', isFallback: false, source: 'de' },
      'ru': { raw: '{gender, select, male{{name} поделился заметкой} female{{name} поделилась заметкой} other{{name} поделились заметкой}}', isFallback: false, source: 'ru' },
      'pt-BR': { raw: '{gender, select, male{{name} compartilhou a nota dele} female{{name} compartilhou a nota dela} other{{name} compartilhou uma nota}}', isFallback: false, source: 'pt-BR' },
      'ar': { raw: '{gender, select, male{{name} shared his note} female{{name} shared her note} other{{name} shared their note}}', isFallback: true, source: 'en' },
      'ar-EG': { raw: '{gender, select, male{{name} shared his note} female{{name} shared her note} other{{name} shared their note}}', isFallback: true, source: 'en' },
      'pt': { raw: '{gender, select, male{{name} compartilhou a nota dele} female{{name} compartilhou a nota dela} other{{name} compartilhou uma nota}}', isFallback: false, source: 'pt-BR' },
    },
  },
  {
    key: 'terms',
    description: 'Inline markup is passed through as text',
    placeholders: [],
    templates: {
      'en': { raw: 'I accept the <b>terms</b>', isFallback: false, source: 'en' },
      'de': { raw: 'Ich akzeptiere die <b>Bedingungen</b>', isFallback: false, source: 'de' },
      'ru': { raw: 'Я принимаю <b>условия</b>', isFallback: false, source: 'ru' },
      'pt-BR': { raw: 'Aceito os <b>termos</b>', isFallback: false, source: 'pt-BR' },
      'ar': { raw: 'أوافق على <b>الشروط</b>', isFallback: false, source: 'ar' },
      'ar-EG': { raw: 'أوافق على <b>الشروط</b>', isFallback: true, source: 'ar' },
      'pt': { raw: 'Aceito os <b>termos</b>', isFallback: false, source: 'pt-BR' },
    },
  },
  {
    key: 'lastSync',
    description: 'Undeclared placeholder: typed Object',
    placeholders: [
      { name: 'time', type: 'Object', example: null, description: null, declared: false },
    ],
    templates: {
      'en': { raw: 'Last synced {time}', isFallback: false, source: 'en' },
      'de': { raw: 'Zuletzt synchronisiert {time}', isFallback: false, source: 'de' },
      'ru': { raw: 'Синхронизировано {time}', isFallback: false, source: 'ru' },
      'pt-BR': { raw: 'Sincronizado {time}', isFallback: false, source: 'pt-BR' },
      'ar': { raw: 'Last synced {time}', isFallback: true, source: 'en' },
      'ar-EG': { raw: 'Last synced {time}', isFallback: true, source: 'en' },
      'pt': { raw: 'Sincronizado {time}', isFallback: false, source: 'pt-BR' },
    },
  },
];

/**
 * Renders the message `key` of `locale` with `args` (placeholder name -> value),
 * without static types.
 */
export async function format(
  locale: Locale,
  key: string,
  args: Readonly<Record<string, unknown>> = {},
): Promise<string> {
  return formatMessage(await loaders[locale](), key, args);
}
