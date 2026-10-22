// This file is generated, do not edit it manually!
/* eslint-disable */
import { negotiateLocale } from '../runtime.js';
import type { AppMessages } from './types.js';

export type { AppKey, AppMessages } from './types.js';

/** The scope name (sheet "app"). */
export const scope = 'app';

/** The base language: the fallback of every message. */
export const baseLocale = 'en';

/** Every locale of the scope (BCP 47), base first. */
export const locales = ['en', 'ru', 'pt-BR', 'ar', 'fr', 'de', 'de-AT', 'ja', 'pl', 'pt'] as const;

/** A locale of the scope. */
export type Locale = (typeof locales)[number];

/**
 * Loads the dictionary of a locale; each locale is a separate module, so
 * bundlers emit one chunk per locale.
 */
export const loaders: { readonly [L in Locale]: () => Promise<AppMessages> } = {
  'en': () => import('./en.js').then((m) => m.messages),
  'ru': () => import('./ru.js').then((m) => m.messages),
  'pt-BR': () => import('./pt-BR.js').then((m) => m.messages),
  'ar': () => import('./ar.js').then((m) => m.messages),
  'fr': () => import('./fr.js').then((m) => m.messages),
  'de': () => import('./de.js').then((m) => m.messages),
  'de-AT': () => import('./de-AT.js').then((m) => m.messages),
  'ja': () => import('./ja.js').then((m) => m.messages),
  'pl': () => import('./pl.js').then((m) => m.messages),
  'pt': () => import('./pt.js').then((m) => m.messages),
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
): Promise<AppMessages> {
  return loaders[resolveLocale(requested)]();
}
