// This file is generated, do not edit it manually!
/* eslint-disable */
import type { SignUpMessages } from './types.js';

/**
 * Messages of the `sign_up` scope in `en`.
 */
export const messages: SignUpMessages = /* @__PURE__ */ Object.freeze({
  signUp: 'Sign up',
  codeSent: (args: { readonly phone: string; readonly seconds: number }): string => `Code sent to ${args.phone}, resend in ${args.seconds}s`,
});

export default messages;
