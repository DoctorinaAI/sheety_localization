// This file is generated, do not edit it manually!
/* eslint-disable */
// Metadata of the scope, for tests and tooling: raw ICU templates of every
// locale, placeholders with examples, fallbacks. Production code does not
// need to import it.
import { formatMessage } from '../runtime.js';
import type { MessageEntry } from '../runtime.js';
import { loaders } from './index.js';
import type { Locale } from './index.js';
import type { SignUpKey } from './types.js';

export { baseLocale, locales, scope } from './index.js';

/** Every message, in sheet order. */
export const entries: readonly MessageEntry<Locale, SignUpKey>[] = [
  {
    key: 'signUp',
    description: null,
    placeholders: [],
    templates: {
      'en': { raw: 'Sign up', isFallback: false, source: 'en' },
      'de': { raw: 'Registrieren', isFallback: false, source: 'de' },
    },
  },
  {
    key: 'codeSent',
    description: null,
    placeholders: [
      { name: 'phone', type: 'String', example: '+123', description: null, declared: true },
      { name: 'seconds', type: 'int', example: '25', description: null, declared: true },
    ],
    templates: {
      'en': { raw: 'Code sent to {phone}, resend in {seconds}s', isFallback: false, source: 'en' },
      'de': { raw: 'Code an {phone} gesendet, erneut in {seconds} s', isFallback: false, source: 'de' },
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
