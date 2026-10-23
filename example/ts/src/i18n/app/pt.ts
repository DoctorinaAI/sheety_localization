// This file is generated, do not edit it manually!
/* eslint-disable */
import { plural, plural_pt, select } from '../runtime.js';
import type { AppMessages } from './types.js';

/**
 * Messages of the `app` scope in `pt`.
 *
 * The sheet has no `pt` column: the texts are copied from `pt-BR`.
 */
export const messages: AppMessages = /* @__PURE__ */ Object.freeze({
  title: 'Notas Sheety',
  greeting: (args: { readonly name: string }): string => `Olá, ${args.name}!`,
  notes: (args: { readonly count: number }): string => plural(args.count, plural_pt, {
    zero: 'Nenhuma nota',
    one: 'Uma nota',
    many: `${args.count} de notas`,
    other: `${args.count} notas`,
  }),
  sharedBy: (args: { readonly gender: string; readonly name: string }): string => select(args.gender, {
    male: `${args.name} compartilhou a nota dele`,
    female: `${args.name} compartilhou a nota dela`,
    other: `${args.name} compartilhou uma nota`,
  }),
  terms: 'Aceito os <b>termos</b>',
  lastSync: (args: { readonly time: string | number }): string => `Sincronizado ${args.time}`,
});

export default messages;
