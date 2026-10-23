// This file is generated, do not edit it manually!
/* eslint-disable */
// Metadata of the scope, for tests and tooling: raw ICU templates of every
// locale, placeholders with examples, fallbacks. Production code does not
// need to import it.
import { formatMessage } from '../runtime.js';
import type { MessageEntry } from '../runtime.js';
import { loaders } from './index.js';
import type { Locale } from './index.js';
import type { ErrorsKey } from './types.js';

export { baseLocale, locales, scope } from './index.js';

/** Every message, in sheet order. */
export const entries: readonly MessageEntry<Locale, ErrorsKey>[] = [
  {
    key: 'notFound',
    description: 'Base language is not English',
    placeholders: [],
    templates: {
      'ru': { raw: 'Не найдено', isFallback: false, source: 'ru' },
      'en': { raw: 'Not found', isFallback: false, source: 'en' },
      'es-419': { raw: 'No encontrado', isFallback: false, source: 'es-419' },
      'es': { raw: 'No encontrado', isFallback: false, source: 'es-419' },
    },
  },
  {
    key: 'retry',
    description: null,
    placeholders: [
      { name: 'attempts', type: 'int', example: '2', description: null, declared: true },
    ],
    templates: {
      'ru': { raw: '{attempts, plural, one{Осталась {attempts} попытка} few{Осталось {attempts} попытки} other{Осталось {attempts} попыток}}', isFallback: false, source: 'ru' },
      'en': { raw: '{attempts, plural, one{{attempts} attempt left} other{{attempts} attempts left}}', isFallback: false, source: 'en' },
      'es-419': { raw: '{attempts, plural, one{Queda {attempts} intento} other{Quedan {attempts} intentos}}', isFallback: false, source: 'es-419' },
      'es': { raw: '{attempts, plural, one{Queda {attempts} intento} other{Quedan {attempts} intentos}}', isFallback: false, source: 'es-419' },
    },
  },
];

/**
 * Renders the message `key` of `locale` with `args` (placeholder name -> value),
 * without static types.
 */
export async function format(
  locale: Locale,
  key: string,
  args: Readonly<Record<string, unknown>> = {},
): Promise<string> {
  return formatMessage(await loaders[locale](), key, args);
}
