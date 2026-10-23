// This file is generated, do not edit it manually!
/* eslint-disable */
import { formatDouble, plural, plural_pl, select } from '../runtime.js';
import type { AppMessages } from './types.js';

/**
 * Messages of the `app` scope in `pl`.
 *
 * 8 of 15 messages have no translation and use a fallback text.
 */
export const messages: AppMessages = /* @__PURE__ */ Object.freeze({
  title: 'Przykład',
  greeting: (args: { readonly name: string }): string => `Cześć, ${args.name}!`,
  items: (args: { readonly count: number }): string => plural(args.count, plural_pl, {
    one: `${args.count} przedmiot`,
    few: `${args.count} przedmioty`,
    many: `${args.count} przedmiotów`,
    other: `${args.count} przedmiotu`,
  }),
  weight: (args: { readonly value: number }): string => plural(args.value, plural_pl, {
    one: `${args.value} kilogram`,
    few: `${args.value} kilogramy`,
    many: `${args.value} kilogramów`,
    other: `${args.value} kilograma`,
  }),
  price: (args: { readonly amount: number }): string => `Cena: ${formatDouble(args.amount)} zł`,
  pronoun: (args: { readonly gender: string; readonly count: number }): string => select(args.gender, {
    male: `He has ${plural(args.count, plural_pl, {
      one: 'one cat',
      other: `${args.count} cats`,
    })}`,
    female: `She has ${plural(args.count, plural_pl, {
      one: 'one cat',
      other: `${args.count} cats`,
    })}`,
    other: `They have ${plural(args.count, plural_pl, {
      one: 'one cat',
      other: `${args.count} cats`,
    })}`,
  }), // fallback: en
  terms: 'Zaakceptuj <b>warunki</b> i <a>politykę</a>',
  special: 'It\'s $5 \\ 100% #1 `tick` "q" \t tab\nsecond line\r\nthird\u2028sep\u2029par \uFEFFbom */ end \x00nul', // fallback: en
  dollarArg: (args: { readonly sum: string }): string => `Total: \$${args.sum}`, // fallback: en
  lastSeen: (args: { readonly when: string | number }): string => `Last seen ${args.when}`, // fallback: en
  unicode: '👋 héllo é 𝔘𝔫𝔦 ‏ עברית \uD83D!', // fallback: en
  delete: 'Usuń',
  choice: (args: { readonly kind: string }): string => select(args.kind, {
    'a|b': 'pipe',
    '1': 'one',
    constructor: 'ctor',
    ['__proto__']: 'proto',
    other: 'other',
  }), // fallback: en
  empty: (args: { readonly n: number }): string => plural(args.n, plural_pl, {
    zero: '',
    other: `${args.n} left`,
  }), // fallback: en
  onlyFallback: 'Base only', // fallback: en
});

export default messages;
