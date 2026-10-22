// This file is generated, do not edit it manually!
/* eslint-disable */
import { plural, plural_en } from '../runtime.js';
import type { ErrorsMessages } from './types.js';

/**
 * Messages of the `errors` scope in `en`.
 */
export const messages: ErrorsMessages = /* @__PURE__ */ Object.freeze({
  notFound: 'Not found',
  retry: (args: { readonly attempts: number }): string => plural(args.attempts, plural_en, {
    one: `${args.attempts} attempt left`,
    other: `${args.attempts} attempts left`,
  }),
});

export default messages;
