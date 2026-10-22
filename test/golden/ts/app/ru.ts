// This file is generated, do not edit it manually!
/* eslint-disable */
import { formatDouble, plural, plural_ru, select } from '../runtime.js';
import type { AppMessages } from './types.js';

/**
 * Messages of the `app` scope in `ru`.
 *
 * 3 of 15 messages have no translation and use a fallback text.
 */
export const messages: AppMessages = /* @__PURE__ */ Object.freeze({
  title: 'Пример',
  greeting: (args: { readonly name: string }): string => `Привет, ${args.name}!`,
  items: (args: { readonly count: number }): string => plural(args.count, plural_ru, {
    zero: 'Нет товаров',
    one: `${args.count} товар`,
    few: `${args.count} товара`,
    many: `${args.count} товаров`,
    other: `${args.count} товара`,
  }),
  weight: (args: { readonly value: number }): string => plural(args.value, plural_ru, {
    one: `${args.value} килограмм`,
    few: `${args.value} килограмма`,
    many: `${args.value} килограммов`,
    other: `${args.value} килограмма`,
  }),
  price: (args: { readonly amount: number }): string => `Цена: ${formatDouble(args.amount)} ₽`,
  pronoun: (args: { readonly gender: string; readonly count: number }): string => select(args.gender, {
    male: `У него ${plural(args.count, plural_ru, {
      one: `${args.count} кот`,
      few: `${args.count} кота`,
      many: `${args.count} котов`,
      other: `${args.count} кота`,
    })}`,
    female: `У неё ${plural(args.count, plural_ru, {
      one: `${args.count} кот`,
      few: `${args.count} кота`,
      many: `${args.count} котов`,
      other: `${args.count} кота`,
    })}`,
    other: `У них ${plural(args.count, plural_ru, {
      one: `${args.count} кот`,
      few: `${args.count} кота`,
      many: `${args.count} котов`,
      other: `${args.count} кота`,
    })}`,
  }),
  terms: 'Примите <b>условия</b> и <a>политику</a>',
  special: 'Это $5 \\ 100% #1\nвторая строка',
  dollarArg: (args: { readonly sum: string }): string => `Итого: \$${args.sum}`,
  lastSeen: (args: { readonly when: string | number }): string => `Был(а) ${args.when}`,
  unicode: '👋 привет',
  delete: 'Удалить',
  choice: (args: { readonly kind: string }): string => select(args.kind, {
    'a|b': 'pipe',
    '1': 'one',
    constructor: 'ctor',
    ['__proto__']: 'proto',
    other: 'other',
  }), // fallback: en
  empty: (args: { readonly n: number }): string => plural(args.n, plural_ru, {
    zero: '',
    other: `${args.n} left`,
  }), // fallback: en
  onlyFallback: 'Base only', // fallback: en
});

export default messages;
