// This file is generated, do not edit it manually!
/* eslint-disable */
import { formatDouble, plural, plural_fr, select } from '../runtime.js';
import type { AppMessages } from './types.js';

/**
 * Messages of the `app` scope in `fr`.
 *
 * 7 of 15 messages have no translation and use a fallback text.
 */
export const messages: AppMessages = /* @__PURE__ */ Object.freeze({
  title: 'Exemple',
  greeting: (args: { readonly name: string }): string => `Bonjour, ${args.name} !`,
  items: (args: { readonly count: number }): string => plural(args.count, plural_fr, {
    one: `${args.count} article`,
    many: `${args.count} d’articles`,
    other: `${args.count} articles`,
  }),
  weight: (args: { readonly value: number }): string => plural(args.value, plural_fr, {
    one: `${args.value} kilogramme`,
    other: `${args.value} kilogrammes`,
  }),
  price: (args: { readonly amount: number }): string => `Prix : ${formatDouble(args.amount)} €`,
  pronoun: (args: { readonly gender: string; readonly count: number }): string => select(args.gender, {
    male: `He has ${plural(args.count, plural_fr, {
      one: 'one cat',
      other: `${args.count} cats`,
    })}`,
    female: `She has ${plural(args.count, plural_fr, {
      one: 'one cat',
      other: `${args.count} cats`,
    })}`,
    other: `They have ${plural(args.count, plural_fr, {
      one: 'one cat',
      other: `${args.count} cats`,
    })}`,
  }), // fallback: en
  terms: 'Acceptez les <b>conditions</b> et la <a>politique</a>',
  special: 'It\'s $5 \\ 100% #1 `tick` "q" \t tab\nsecond line\r\nthird\u2028sep\u2029par \uFEFFbom */ end \x00nul', // fallback: en
  dollarArg: (args: { readonly sum: string }): string => `Total: \$${args.sum}`, // fallback: en
  lastSeen: (args: { readonly when: string | number }): string => `Vu ${args.when}`,
  unicode: '👋 héllo é 𝔘𝔫𝔦 ‏ עברית \uD83D!', // fallback: en
  delete: 'Supprimer',
  choice: (args: { readonly kind: string }): string => select(args.kind, {
    'a|b': 'pipe',
    '1': 'one',
    constructor: 'ctor',
    ['__proto__']: 'proto',
    other: 'other',
  }), // fallback: en
  empty: (args: { readonly n: number }): string => plural(args.n, plural_fr, {
    zero: '',
    other: `${args.n} left`,
  }), // fallback: en
  onlyFallback: 'Base only', // fallback: en
});

export default messages;
