// This file is generated, do not edit it manually!
/* eslint-disable */
import { formatDouble, plural, plural_en, select } from '../runtime.js';
import type { AppMessages } from './types.js';

/**
 * Messages of the `app` scope in `en`.
 */
export const messages: AppMessages = /* @__PURE__ */ Object.freeze({
  title: 'Example',
  greeting: (args: { readonly name: string }): string => `Hello, ${args.name}!`,
  items: (args: { readonly count: number }): string => plural(args.count, plural_en, {
    zero: 'No items',
    one: 'One item',
    other: `${args.count} items`,
  }),
  weight: (args: { readonly value: number }): string => plural(args.value, plural_en, {
    one: `${args.value} kilogram`,
    other: `${args.value} kilograms`,
  }),
  price: (args: { readonly amount: number }): string => `Price: ${formatDouble(args.amount)} €`,
  pronoun: (args: { readonly gender: string; readonly count: number }): string => select(args.gender, {
    male: `He has ${plural(args.count, plural_en, {
      one: 'one cat',
      other: `${args.count} cats`,
    })}`,
    female: `She has ${plural(args.count, plural_en, {
      one: 'one cat',
      other: `${args.count} cats`,
    })}`,
    other: `They have ${plural(args.count, plural_en, {
      one: 'one cat',
      other: `${args.count} cats`,
    })}`,
  }),
  terms: 'Accept the <b>terms</b> and the <a>policy</a>',
  special: 'It\'s $5 \\ 100% #1 `tick` "q" \t tab\nsecond line\r\nthird\u2028sep\u2029par \uFEFFbom */ end \x00nul',
  dollarArg: (args: { readonly sum: string }): string => `Total: \$${args.sum}`,
  lastSeen: (args: { readonly when: string | number }): string => `Last seen ${args.when}`,
  unicode: '👋 héllo é 𝔘𝔫𝔦 ‏ עברית \uD83D!',
  delete: 'Delete',
  choice: (args: { readonly kind: string }): string => select(args.kind, {
    'a|b': 'pipe',
    '1': 'one',
    constructor: 'ctor',
    ['__proto__']: 'proto',
    other: 'other',
  }),
  empty: (args: { readonly n: number }): string => plural(args.n, plural_en, {
    zero: '',
    other: `${args.n} left`,
  }),
  onlyFallback: 'Base only',
});

export default messages;
