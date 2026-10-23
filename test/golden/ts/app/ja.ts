// This file is generated, do not edit it manually!
/* eslint-disable */
import { formatDouble, plural, plural_ja, select } from '../runtime.js';
import type { AppMessages } from './types.js';

/**
 * Messages of the `app` scope in `ja`.
 *
 * 7 of 15 messages have no translation and use a fallback text.
 */
export const messages: AppMessages = /* @__PURE__ */ Object.freeze({
  title: '例',
  greeting: (args: { readonly name: string }): string => `こんにちは、${args.name}さん`,
  items: (args: { readonly count: number }): string => `${args.count}個のアイテム`,
  weight: (args: { readonly value: number }): string => `${args.value}キログラム`,
  price: (args: { readonly amount: number }): string => `価格: ${formatDouble(args.amount)}円`,
  pronoun: (args: { readonly gender: string; readonly count: number }): string => select(args.gender, {
    male: `He has ${plural(args.count, plural_ja, {
      one: 'one cat',
      other: `${args.count} cats`,
    })}`,
    female: `She has ${plural(args.count, plural_ja, {
      one: 'one cat',
      other: `${args.count} cats`,
    })}`,
    other: `They have ${plural(args.count, plural_ja, {
      one: 'one cat',
      other: `${args.count} cats`,
    })}`,
  }), // fallback: en
  terms: '<b>規約</b>と<a>ポリシー</a>に同意',
  special: 'It\'s $5 \\ 100% #1 `tick` "q" \t tab\nsecond line\r\nthird\u2028sep\u2029par \uFEFFbom */ end \x00nul', // fallback: en
  dollarArg: (args: { readonly sum: string }): string => `Total: \$${args.sum}`, // fallback: en
  lastSeen: (args: { readonly when: string | number }): string => `Last seen ${args.when}`, // fallback: en
  unicode: '👋 こんにちは',
  delete: '削除',
  choice: (args: { readonly kind: string }): string => select(args.kind, {
    'a|b': 'pipe',
    '1': 'one',
    constructor: 'ctor',
    ['__proto__']: 'proto',
    other: 'other',
  }), // fallback: en
  empty: (args: { readonly n: number }): string => plural(args.n, plural_ja, {
    zero: '',
    other: `${args.n} left`,
  }), // fallback: en
  onlyFallback: 'Base only', // fallback: en
});

export default messages;
