// This file is generated, do not edit it manually!
/* eslint-disable */
import { plural, plural_ar, select } from '../runtime.js';
import type { AppMessages } from './types.js';

/**
 * Messages of the `app` scope in `ar`.
 *
 * 2 of 6 messages have no translation and use a fallback text.
 */
export const messages: AppMessages = /* @__PURE__ */ Object.freeze({
  title: 'ملاحظات Sheety',
  greeting: (args: { readonly name: string }): string => `مرحبا ${args.name}!`,
  notes: (args: { readonly count: number }): string => plural(args.count, plural_ar, {
    zero: 'لا ملاحظات',
    one: 'ملاحظة واحدة',
    two: 'ملاحظتان',
    few: `${args.count} ملاحظات`,
    many: `${args.count} ملاحظة`,
    other: `${args.count} ملاحظة`,
  }),
  sharedBy: (args: { readonly gender: string; readonly name: string }): string => select(args.gender, {
    male: `${args.name} shared his note`,
    female: `${args.name} shared her note`,
    other: `${args.name} shared their note`,
  }), // fallback: en
  terms: 'أوافق على <b>الشروط</b>',
  lastSync: (args: { readonly time: string | number }): string => `Last synced ${args.time}`, // fallback: en
});

export default messages;
