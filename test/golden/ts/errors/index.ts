// This file is generated, do not edit it manually!
/* eslint-disable */
import { negotiateLocale } from '../runtime.js';
import type { ErrorsMessages } from './types.js';

export type { ErrorsKey, ErrorsMessages } from './types.js';

/** The scope name (sheet "errors"). */
export const scope = 'errors';

/** The base language: the fallback of every message. */
export const baseLocale = 'ru';

/** Every locale of the scope (BCP 47), base first. */
export const locales = ['ru', 'en', 'es-419', 'es'] as const;

/** A locale of the scope. */
export type Locale = (typeof locales)[number];

/**
 * Loads the dictionary of a locale; each locale is a separate module, so
 * bundlers emit one chunk per locale.
 */
export const loaders: { readonly [L in Locale]: () => Promise<ErrorsMessages> } = {
  'ru': () => import('./ru.js').then((m) => m.messages),
  'en': () => import('./en.js').then((m) => m.messages),
  'es-419': () => import('./es-419.js').then((m) => m.messages),
  'es': () => import('./es.js').then((m) => m.messages),
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
): Promise<ErrorsMessages> {
  return loaders[resolveLocale(requested)]();
}
