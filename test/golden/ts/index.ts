// This file is generated, do not edit it manually!
/* eslint-disable */
import { negotiateLocale } from './runtime.js';

export * as app from './app/index.js';
export * as sign_up from './sign_up/index.js';
export * as errors from './errors/index.js';

export type {
  MessageEntry,
  MessageValue,
  PlaceholderInfo,
  PlaceholderType,
  PluralCategory,
  TemplateInfo,
} from './runtime.js';
export { formatMessage, negotiateLocale } from './runtime.js';

/** Every scope (sheet), in sheet order. */
export const scopes = ['app', 'sign_up', 'errors'] as const;

/** The name of a scope. */
export type ScopeName = (typeof scopes)[number];

/** Every locale of any scope (BCP 47), in order of first appearance. */
export const supportedLocales = ['en', 'ru', 'pt-BR', 'ar', 'fr', 'de', 'de-AT', 'ja', 'pl', 'pt', 'es-419', 'es'] as const;

/** A locale of any scope. */
export type SupportedLocale = (typeof supportedLocales)[number];

/**
 * The base language of the scopes (they differ, so the base of the first scope).
 */
export const baseLocale = 'en';

/** Whether `value` is one of the [supportedLocales]. */
export function isSupportedLocale(value: string): value is SupportedLocale {
  return (supportedLocales as readonly string[]).includes(value);
}

/**
 * The supported locale that best matches `requested` (e.g. `navigator.languages`),
 * see `negotiateLocale`; [baseLocale] when none does.
 */
export function resolveLocale(
  requested: string | readonly string[] | null | undefined,
): SupportedLocale {
  return negotiateLocale(requested, supportedLocales, baseLocale);
}
