// This file is generated, do not edit it manually!
/* eslint-disable */
import type { SignUpMessages } from './types.js';

/**
 * Messages of the `sign_up` scope in `de`.
 */
export const messages: SignUpMessages = /* @__PURE__ */ Object.freeze({
  signUp: 'Registrieren',
  codeSent: (args: { readonly phone: string; readonly seconds: number }): string => `Code an ${args.phone} gesendet, erneut in ${args.seconds} s`,
});

export default messages;
