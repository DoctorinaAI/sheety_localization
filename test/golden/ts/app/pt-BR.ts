// This file is generated, do not edit it manually!
/* eslint-disable */
import { formatDouble, plural, plural_pt, select } from '../runtime.js';
import type { AppMessages } from './types.js';

/**
 * Messages of the `app` scope in `pt-BR`.
 *
 * 6 of 15 messages have no translation and use a fallback text.
 */
export const messages: AppMessages = /* @__PURE__ */ Object.freeze({
  title: 'Exemplo',
  greeting: (args: { readonly name: string }): string => `Olá, ${args.name}!`,
  items: (args: { readonly count: number }): string => plural(args.count, plural_pt, {
    zero: 'Nenhum item',
    one: 'Um item',
    many: `${args.count} de itens`,
    other: `${args.count} itens`,
  }),
  weight: (args: { readonly value: number }): string => plural(args.value, plural_pt, {
    one: `${args.value} quilograma`,
    other: `${args.value} quilogramas`,
  }),
  price: (args: { readonly amount: number }): string => `Preço: R\$ ${formatDouble(args.amount)}`,
  pronoun: (args: { readonly gender: string; readonly count: number }): string => select(args.gender, {
    male: `Ele tem ${plural(args.count, plural_pt, {
      one: 'um gato',
      other: `${args.count} gatos`,
    })}`,
    female: `Ela tem ${plural(args.count, plural_pt, {
      one: 'um gato',
      other: `${args.count} gatos`,
    })}`,
    other: `Eles têm ${plural(args.count, plural_pt, {
      one: 'um gato',
      other: `${args.count} gatos`,
    })}`,
  }),
  terms: 'Aceite os <b>termos</b> e a <a>política</a>',
  special: 'It\'s $5 \\ 100% #1 `tick` "q" \t tab\nsecond line\r\nthird\u2028sep\u2029par \uFEFFbom */ end \x00nul', // fallback: en
  dollarArg: (args: { readonly sum: string }): string => `Total: \$${args.sum}`, // fallback: en
  lastSeen: (args: { readonly when: string | number }): string => `Visto ${args.when}`,
  unicode: '👋 héllo é 𝔘𝔫𝔦 ‏ עברית \uD83D!', // fallback: en
  delete: 'Excluir',
  choice: (args: { readonly kind: string }): string => select(args.kind, {
    'a|b': 'pipe',
    '1': 'one',
    constructor: 'ctor',
    ['__proto__']: 'proto',
    other: 'other',
  }), // fallback: en
  empty: (args: { readonly n: number }): string => plural(args.n, plural_pt, {
    zero: '',
    other: `${args.n} left`,
  }), // fallback: en
  onlyFallback: 'Base only', // fallback: en
});

export default messages;
