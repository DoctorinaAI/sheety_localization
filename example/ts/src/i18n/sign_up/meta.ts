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
    description: 'Button',
    placeholders: [],
    templates: {
      'de': { raw: 'Registrieren', isFallback: false, source: 'de' },
      'en': { raw: 'Sign up', isFallback: false, source: 'en' },
    },
  },
  {
    key: 'codeSent',
    description: null,
    placeholders: [
      { name: 'phone', type: 'String', example: '+49 30 1234567', description: null, declared: true },
      { name: 'seconds', type: 'int', example: '30', description: null, declared: true },
    ],
    templates: {
      'de': { raw: 'Code an {phone} gesendet, erneut in {seconds} s', isFallback: false, source: 'de' },
      'en': { raw: 'Code sent to {phone}, resend in {seconds}s', isFallback: false, source: 'en' },
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
