// This file is generated, do not edit it manually!
/* eslint-disable */
import { plural, plural_ru, select } from '../runtime.js';
import type { AppMessages } from './types.js';

/**
 * Messages of the `app` scope in `ru`.
 */
export const messages: AppMessages = /* @__PURE__ */ Object.freeze({
  title: 'Заметки Sheety',
  greeting: (args: { readonly name: string }): string => `Привет, ${args.name}!`,
  notes: (args: { readonly count: number }): string => plural(args.count, plural_ru, {
    zero: 'Нет заметок',
    one: `${args.count} заметка`,
    few: `${args.count} заметки`,
    many: `${args.count} заметок`,
    other: `${args.count} заметки`,
  }),
  sharedBy: (args: { readonly gender: string; readonly name: string }): string => select(args.gender, {
    male: `${args.name} поделился заметкой`,
    female: `${args.name} поделилась заметкой`,
    other: `${args.name} поделились заметкой`,
  }),
  terms: 'Я принимаю <b>условия</b>',
  lastSync: (args: { readonly time: string | number }): string => `Синхронизировано ${args.time}`,
});

export default messages;
