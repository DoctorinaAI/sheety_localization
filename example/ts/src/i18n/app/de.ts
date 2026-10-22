// This file is generated, do not edit it manually!
/* eslint-disable */
import { plural, plural_de, select } from '../runtime.js';
import type { AppMessages } from './types.js';

/**
 * Messages of the `app` scope in `de`.
 */
export const messages: AppMessages = /* @__PURE__ */ Object.freeze({
  title: 'Sheety Notizen',
  greeting: (args: { readonly name: string }): string => `Hallo, ${args.name}!`,
  notes: (args: { readonly count: number }): string => plural(args.count, plural_de, {
    zero: 'Keine Notizen',
    one: 'Eine Notiz',
    other: `${args.count} Notizen`,
  }),
  sharedBy: (args: { readonly gender: string; readonly name: string }): string => select(args.gender, {
    male: `${args.name} hat seine Notiz geteilt`,
    female: `${args.name} hat ihre Notiz geteilt`,
    other: `${args.name} hat eine Notiz geteilt`,
  }),
  terms: 'Ich akzeptiere die <b>Bedingungen</b>',
  lastSync: (args: { readonly time: string | number }): string => `Zuletzt synchronisiert ${args.time}`,
});

export default messages;
