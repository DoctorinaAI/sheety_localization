// This file is generated, do not edit it manually!
/* eslint-disable */
import { plural, plural_es } from '../runtime.js';
import type { ErrorsMessages } from './types.js';

/**
 * Messages of the `errors` scope in `es`.
 *
 * The sheet has no `es` column: the texts are copied from `es-419`.
 */
export const messages: ErrorsMessages = /* @__PURE__ */ Object.freeze({
  notFound: 'No encontrado',
  retry: (args: { readonly attempts: number }): string => plural(args.attempts, plural_es, {
    one: `Queda ${args.attempts} intento`,
    other: `Quedan ${args.attempts} intentos`,
  }),
});

export default messages;
