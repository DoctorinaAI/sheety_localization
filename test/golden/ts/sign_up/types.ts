// This file is generated, do not edit it manually!
/* eslint-disable */
/**
 * Messages of the `sign_up` scope (sheet "sign-up"), base locale `en`.
 *
 * A message without placeholders is a string, a message with placeholders is a
 * function of an object with one property per placeholder.
 *
 * A type alias rather than an interface: object types get an implicit index
 * signature, so the dictionary is assignable to `Record<string, ...>` (e.g. to
 * `@solid-primitives/i18n`'s `BaseRecordDict`).
 */
export type SignUpMessages = {
  /**
   * `en`: Sign up
   */
  readonly signUp: string;
  /**
   * `en`: Code sent to {phone}, resend in {seconds}s
   *
   * @param args.phone `String`, e.g. `+123`
   * @param args.seconds `int`, e.g. `25`
   */
  readonly codeSent: (args: { readonly phone: string; readonly seconds: number }) => string;
};

/** The key of a message of the `sign_up` scope. */
export type SignUpKey = keyof SignUpMessages;
