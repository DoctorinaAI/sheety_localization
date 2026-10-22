// This file is generated, do not edit it manually!
/* eslint-disable */
/**
 * Messages of the `errors` scope (sheet "errors"), base locale `ru`.
 *
 * A message without placeholders is a string, a message with placeholders is a
 * function of an object with one property per placeholder.
 *
 * A type alias rather than an interface: object types get an implicit index
 * signature, so the dictionary is assignable to `Record<string, ...>` (e.g. to
 * `@solid-primitives/i18n`'s `BaseRecordDict`).
 */
export type ErrorsMessages = {
  /**
   * Base language is not English
   *
   * `ru`: Не найдено
   */
  readonly notFound: string;
  /**
   * `ru`: {attempts, plural, one{Осталась {attempts} попытка} few{Осталось {attempts} попытки} other{Осталось {attempts} попыток}}
   *
   * @param args.attempts `int`, e.g. `2`
   */
  readonly retry: (args: { readonly attempts: number }) => string;
};

/** The key of a message of the `errors` scope. */
export type ErrorsKey = keyof ErrorsMessages;
