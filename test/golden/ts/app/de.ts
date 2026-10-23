// This file is generated, do not edit it manually!
/* eslint-disable */
import { formatDouble, plural, plural_de, select } from '../runtime.js';
import type { AppMessages } from './types.js';

/**
 * Messages of the `app` scope in `de`.
 *
 * 4 of 15 messages have no translation and use a fallback text.
 */
export const messages: AppMessages = /* @__PURE__ */ Object.freeze({
  title: 'Beispiel',
  greeting: (args: { readonly name: string }): string => `Hallo, ${args.name}!`,
  items: (args: { readonly count: number }): string => plural(args.count, plural_de, {
    zero: 'Keine Artikel',
    one: 'Ein Artikel',
    other: `${args.count} Artikel`,
  }),
  weight: (args: { readonly value: number }): string => plural(args.value, plural_de, {
    one: `${args.value} Kilogramm`,
    other: `${args.value} Kilogramm`,
  }),
  price: (args: { readonly amount: number }): string => `Preis: ${formatDouble(args.amount)} €`,
  pronoun: (args: { readonly gender: string; readonly count: number }): string => select(args.gender, {
    male: `Er hat ${plural(args.count, plural_de, {
      one: 'eine Katze',
      other: `${args.count} Katzen`,
    })}`,
    female: `Sie hat ${plural(args.count, plural_de, {
      one: 'eine Katze',
      other: `${args.count} Katzen`,
    })}`,
    other: `Sie haben ${plural(args.count, plural_de, {
      one: 'eine Katze',
      other: `${args.count} Katzen`,
    })}`,
  }),
  terms: 'Akzeptieren Sie die <b>Bedingungen</b> und die <a>Richtlinie</a>',
  special: 'Das ist $5 \\ 100% #1\nzweite Zeile',
  dollarArg: (args: { readonly sum: string }): string => `Summe: \$${args.sum}`,
  lastSeen: (args: { readonly when: string | number }): string => `Zuletzt ${args.when}`,
  unicode: '👋 héllo é 𝔘𝔫𝔦 ‏ עברית \uD83D!', // fallback: en
  delete: 'Löschen',
  choice: (args: { readonly kind: string }): string => select(args.kind, {
    'a|b': 'pipe',
    '1': 'one',
    constructor: 'ctor',
    ['__proto__']: 'proto',
    other: 'other',
  }), // fallback: en
  empty: (args: { readonly n: number }): string => plural(args.n, plural_de, {
    zero: '',
    other: `${args.n} left`,
  }), // fallback: en
  onlyFallback: 'Base only', // fallback: en
});

export default messages;
