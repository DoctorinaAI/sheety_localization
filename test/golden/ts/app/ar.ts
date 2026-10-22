// This file is generated, do not edit it manually!
/* eslint-disable */
import { formatDouble, plural, plural_ar, select } from '../runtime.js';
import type { AppMessages } from './types.js';

/**
 * Messages of the `app` scope in `ar`.
 *
 * 9 of 15 messages have no translation and use a fallback text.
 */
export const messages: AppMessages = /* @__PURE__ */ Object.freeze({
  title: 'مثال',
  greeting: (args: { readonly name: string }): string => `مرحبا ${args.name}`,
  items: (args: { readonly count: number }): string => plural(args.count, plural_ar, {
    zero: 'لا عناصر',
    one: 'عنصر واحد',
    two: 'عنصران',
    few: `${args.count} عناصر`,
    many: `${args.count} عنصرًا`,
    other: `${args.count} عنصر`,
  }),
  weight: (args: { readonly value: number }): string => plural(args.value, plural_ar, {
    zero: `${args.value} كيلوغرام`,
    one: 'كيلوغرام',
    two: 'كيلوغرامان',
    few: `${args.value} كيلوغرامات`,
    many: `${args.value} كيلوغرامًا`,
    other: `${args.value} كيلوغرام`,
  }),
  price: (args: { readonly amount: number }): string => `السعر: ${formatDouble(args.amount)}`,
  pronoun: (args: { readonly gender: string; readonly count: number }): string => select(args.gender, {
    male: `He has ${plural(args.count, plural_ar, {
      one: 'one cat',
      other: `${args.count} cats`,
    })}`,
    female: `She has ${plural(args.count, plural_ar, {
      one: 'one cat',
      other: `${args.count} cats`,
    })}`,
    other: `They have ${plural(args.count, plural_ar, {
      one: 'one cat',
      other: `${args.count} cats`,
    })}`,
  }), // fallback: en
  terms: 'Accept the <b>terms</b> and the <a>policy</a>', // fallback: en
  special: 'It\'s $5 \\ 100% #1 `tick` "q" \t tab\nsecond line\r\nthird\u2028sep\u2029par \uFEFFbom */ end \x00nul', // fallback: en
  dollarArg: (args: { readonly sum: string }): string => `Total: \$${args.sum}`, // fallback: en
  lastSeen: (args: { readonly when: string | number }): string => `Last seen ${args.when}`, // fallback: en
  unicode: '👋 héllo é 𝔘𝔫𝔦 ‏ עברית \uD83D!', // fallback: en
  delete: 'حذف',
  choice: (args: { readonly kind: string }): string => select(args.kind, {
    'a|b': 'pipe',
    '1': 'one',
    constructor: 'ctor',
    ['__proto__']: 'proto',
    other: 'other',
  }), // fallback: en
  empty: (args: { readonly n: number }): string => plural(args.n, plural_ar, {
    zero: '',
    other: `${args.n} left`,
  }), // fallback: en
  onlyFallback: 'Base only', // fallback: en
});

export default messages;
