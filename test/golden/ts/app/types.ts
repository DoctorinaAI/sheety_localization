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
   * `en`: Example
   */
  readonly title: string;
  /**
   * Greets the user
   *
   * `en`: Hello, {name}!
   *
   * @param args.name `String`, e.g. `Bob` - User name
   */
  readonly greeting: (args: { readonly name: string }) => string;
  /**
   * Number of items in the cart
   *
   * `en`: {count, plural, =0{No items} =1{One item} other{{count} items}}
   *
   * @param args.count `int`, e.g. `3`
   */
  readonly items: (args: { readonly count: number }) => string;
  /**
   * Fractional plural count (num): intl rounds the integer digits
   *
   * `en`: {value, plural, one{{value} kilogram} other{{value} kilograms}}
   *
   * @param args.value `num`, e.g. `1.5`
   */
  readonly weight: (args: { readonly value: number }) => string;
  /**
   * Double placeholder
   *
   * `en`: Price: {amount} €
   *
   * @param args.amount `double`, e.g. `9.5`
   */
  readonly price: (args: { readonly amount: number }) => string;
  /**
   * Select with a nested plural
   *
   * `en`: {gender, select, male{He has {count, plural, =1{one cat} other{{count} cats}}} female{She has {count, plural, =1{one cat} other{{count} cats}}} other{They have {count, plural, =1{one cat} other{{count} cats}}}}
   *
   * @param args.gender `String`, e.g. `female`
   * @param args.count `int`, e.g. `2`
   */
  readonly pronoun: (args: { readonly gender: string; readonly count: number }) => string;
  /**
   * Inline markup
   *
   * `en`: Accept the <b>terms</b> and the <a>policy</a>
   */
  readonly terms: string;
  /**
   * Characters that need escaping in generated code
   *
   * `en`: It's $5 \ 100% #1 `tick` "q" 	 tab
   * second line
   * third\u2028sep\u2029par \uFEFFbom *\/ end \u0000nul
   */
  readonly special: string;
  /**
   * A placeholder right after a dollar sign
   *
   * `en`: Total: ${sum}
   *
   * @param args.sum `String`, e.g. `10`
   */
  readonly dollarArg: (args: { readonly sum: string }) => string;
  /**
   * Undeclared placeholder (typed Object)
   *
   * `en`: Last seen {when}
   *
   * @param args.when `Object`
   */
  readonly lastSeen: (args: { readonly when: string | number }) => string;
  /**
   * Emoji, combining marks, RTL, astral plane and a lone surrogate
   *
   * `en`: 👋 héllo é 𝔘𝔫𝔦 ‏ עברית �!
   */
  readonly unicode: string;
  /**
   * A key that is a JavaScript reserved word
   *
   * `en`: Delete
   */
  readonly delete: string;
  /**
   * Select with unusual case values
   *
   * `en`: {kind, select, a|b{pipe} 1{one} constructor{ctor} __proto__{proto} other{other}}
   *
   * @param args.kind `String`, e.g. `a|b`
   */
  readonly choice: (args: { readonly kind: string }) => string;
  /**
   * An empty plural branch
   *
   * `en`: {n, plural, =0{} other{{n} left}}
   *
   * @param args.n `int`, e.g. `0`
   */
  readonly empty: (args: { readonly n: number }) => string;
  /**
   * Only the base language
   *
   * `en`: Base only
   */
  readonly onlyFallback: string;
};

/** The key of a message of the `app` scope. */
export type AppKey = keyof AppMessages;
