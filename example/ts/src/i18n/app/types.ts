// This file is generated, do not edit it manually!
/* eslint-disable */
/**
 * Messages of the `app` scope (sheet "app"), base locale `en`.
 *
 * A message without placeholders is a string, a message with placeholders is a
 * function of an object with one property per placeholder.
 *
 * A type alias rather than an interface: object types get an implicit index
 * signature, so the dictionary is assignable to `Record<string, ...>` (e.g. to
 * `@solid-primitives/i18n`'s `BaseRecordDict`).
 */
export type AppMessages = {
  /**
   * Application title
   *
   * `en`: Sheety Notes
   */
  readonly title: string;
  /**
   * Greets the user on the home screen
   *
   * `en`: Hello, {name}!
   *
   * @param args.name `String`, e.g. `Alice` - First name of the user
   */
  readonly greeting: (args: { readonly name: string }) => string;
  /**
   * Number of notes in the list
   *
   * `en`: {count, plural, =0{No notes} one{One note} other{{count} notes}}
   *
   * @param args.count `int`, e.g. `3`
   */
  readonly notes: (args: { readonly count: number }) => string;
  /**
   * Who shared a note
   *
   * `en`: {gender, select, male{{name} shared his note} female{{name} shared her note} other{{name} shared their note}}
   *
   * @param args.gender `String`, e.g. `female`
   * @param args.name `String`, e.g. `Alice`
   */
  readonly sharedBy: (args: { readonly gender: string; readonly name: string }) => string;
  /**
   * Inline markup is passed through as text
   *
   * `en`: I accept the <b>terms</b>
   */
  readonly terms: string;
  /**
   * Undeclared placeholder: typed Object
   *
   * `en`: Last synced {time}
   *
   * @param args.time `Object`
   */
  readonly lastSync: (args: { readonly time: string | number }) => string;
};

/** The key of a message of the `app` scope. */
export type AppKey = keyof AppMessages;
