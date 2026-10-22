// This file is generated, do not edit it manually!
/* eslint-disable */
import { negotiateLocale } from '../runtime.js';
import type { SignUpMessages } from './types.js';

export type { SignUpKey, SignUpMessages } from './types.js';

/** The scope name (sheet "sign-up"). */
export const scope = 'sign_up';

/** The base language: the fallback of every message. */
export const baseLocale = 'de';

/** Every locale of the scope (BCP 47), base first. */
export const locales = ['de', 'en'] as const;

/** A locale of the scope. */
export type Locale = (typeof locales)[number];

/**
 * Loads the dictionary of a locale; each locale is a separate module, so
 * bundlers emit one chunk per locale.
 */
export const loaders: { readonly [L in Locale]: () => Promise<SignUpMessages> } = {
  'de': () => import('./de.js').then((m) => m.messages),
  'en': () => import('./en.js').then((m) => m.messages),
};

/** Whether `value` is one of the [locales]. */
export function isLocale(value: string): value is Locale {
  return (locales as readonly string[]).includes(value);
}

/**
 * The locale that best matches `requested` (e.g. `navigator.languages`):
 * `pt-BR` -> `pt` -> [baseLocale], case-insensitive, `_` or `-`,
 * an `Accept-Language` header too (see `negotiateLocale`).
 */
export function resolveLocale(
  requested: string | readonly string[] | null | undefined,
): Locale {
  return negotiateLocale(requested, locales, baseLocale);
}

/** Loads the dictionary of the best match for `requested`. */
export function loadMessages(
  requested: string | readonly string[] | null | undefined,
): Promise<SignUpMessages> {
  return loaders[resolveLocale(requested)]();
}
