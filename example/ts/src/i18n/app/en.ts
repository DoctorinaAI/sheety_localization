// This file is generated, do not edit it manually!
/* eslint-disable */
import { plural, plural_en, select } from '../runtime.js';
import type { AppMessages } from './types.js';

/**
 * Messages of the `app` scope in `en`.
 */
export const messages: AppMessages = /* @__PURE__ */ Object.freeze({
  title: 'Sheety Notes',
  greeting: (args: { readonly name: string }): string => `Hello, ${args.name}!`,
  notes: (args: { readonly count: number }): string => plural(args.count, plural_en, {
    zero: 'No notes',
    one: 'One note',
    other: `${args.count} notes`,
  }),
  sharedBy: (args: { readonly gender: string; readonly name: string }): string => select(args.gender, {
    male: `${args.name} shared his note`,
    female: `${args.name} shared her note`,
    other: `${args.name} shared their note`,
  }),
  terms: 'I accept the <b>terms</b>',
  lastSync: (args: { readonly time: string | number }): string => `Last synced ${args.time}`,
});

export default messages;
