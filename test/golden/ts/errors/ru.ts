// This file is generated, do not edit it manually!
/* eslint-disable */
import { plural, plural_ru } from '../runtime.js';
import type { ErrorsMessages } from './types.js';

/**
 * Messages of the `errors` scope in `ru`.
 */
export const messages: ErrorsMessages = /* @__PURE__ */ Object.freeze({
  notFound: 'Не найдено',
  retry: (args: { readonly attempts: number }): string => plural(args.attempts, plural_ru, {
    one: `Осталась ${args.attempts} попытка`,
    few: `Осталось ${args.attempts} попытки`,
    other: `Осталось ${args.attempts} попыток`,
  }),
});

export default messages;
