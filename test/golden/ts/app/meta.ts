// This file is generated, do not edit it manually!
/* eslint-disable */
// Metadata of the scope, for tests and tooling: raw ICU templates of every
// locale, placeholders with examples, fallbacks. Production code does not
// need to import it.
import { formatMessage } from '../runtime.js';
import type { MessageEntry } from '../runtime.js';
import { loaders } from './index.js';
import type { Locale } from './index.js';
import type { AppKey } from './types.js';

export { baseLocale, locales, scope } from './index.js';

/** Every message, in sheet order. */
export const entries: readonly MessageEntry<Locale, AppKey>[] = [
  {
    key: 'title',
    description: 'Application title',
    placeholders: [],
    templates: {
      'en': { raw: 'Example', isFallback: false, source: 'en' },
      'ru': { raw: 'Пример', isFallback: false, source: 'ru' },
      'pt-BR': { raw: 'Exemplo', isFallback: false, source: 'pt-BR' },
      'ar': { raw: 'مثال', isFallback: false, source: 'ar' },
      'fr': { raw: 'Exemple', isFallback: false, source: 'fr' },
      'de': { raw: 'Beispiel', isFallback: false, source: 'de' },
      'de-AT': { raw: 'Beispiel (AT)', isFallback: false, source: 'de-AT' },
      'ja': { raw: '例', isFallback: false, source: 'ja' },
      'pl': { raw: 'Przykład', isFallback: false, source: 'pl' },
      'pt': { raw: 'Exemplo', isFallback: false, source: 'pt-BR' },
    },
  },
  {
    key: 'greeting',
    description: 'Greets the user',
    placeholders: [
      { name: 'name', type: 'String', example: 'Bob', description: 'User name', declared: true },
    ],
    templates: {
      'en': { raw: 'Hello, {name}!', isFallback: false, source: 'en' },
      'ru': { raw: 'Привет, {name}!', isFallback: false, source: 'ru' },
      'pt-BR': { raw: 'Olá, {name}!', isFallback: false, source: 'pt-BR' },
      'ar': { raw: 'مرحبا {name}', isFallback: false, source: 'ar' },
      'fr': { raw: 'Bonjour, {name} !', isFallback: false, source: 'fr' },
      'de': { raw: 'Hallo, {name}!', isFallback: false, source: 'de' },
      'de-AT': { raw: 'Servus, {name}!', isFallback: false, source: 'de-AT' },
      'ja': { raw: 'こんにちは、{name}さん', isFallback: false, source: 'ja' },
      'pl': { raw: 'Cześć, {name}!', isFallback: false, source: 'pl' },
      'pt': { raw: 'Olá, {name}!', isFallback: false, source: 'pt-BR' },
    },
  },
  {
    key: 'items',
    description: 'Number of items in the cart',
    placeholders: [
      { name: 'count', type: 'int', example: '3', description: null, declared: true },
    ],
    templates: {
      'en': { raw: '{count, plural, =0{No items} =1{One item} other{{count} items}}', isFallback: false, source: 'en' },
      'ru': { raw: '{count, plural, =0{Нет товаров} one{{count} товар} few{{count} товара} many{{count} товаров} other{{count} товара}}', isFallback: false, source: 'ru' },
      'pt-BR': { raw: '{count, plural, =0{Nenhum item} one{Um item} many{{count} de itens} other{{count} itens}}', isFallback: false, source: 'pt-BR' },
      'ar': { raw: '{count, plural, zero{لا عناصر} one{عنصر واحد} two{عنصران} few{{count} عناصر} many{{count} عنصرًا} other{{count} عنصر}}', isFallback: false, source: 'ar' },
      'fr': { raw: '{count, plural, one{{count} article} many{{count} d’articles} other{{count} articles}}', isFallback: false, source: 'fr' },
      'de': { raw: '{count, plural, =0{Keine Artikel} one{Ein Artikel} other{{count} Artikel}}', isFallback: false, source: 'de' },
      'de-AT': { raw: '{count, plural, =0{Keine Artikel} one{Ein Artikel} other{{count} Artikel}}', isFallback: true, source: 'de' },
      'ja': { raw: '{count}個のアイテム', isFallback: false, source: 'ja' },
      'pl': { raw: '{count, plural, one{{count} przedmiot} few{{count} przedmioty} many{{count} przedmiotów} other{{count} przedmiotu}}', isFallback: false, source: 'pl' },
      'pt': { raw: '{count, plural, =0{Nenhum item} one{Um item} many{{count} de itens} other{{count} itens}}', isFallback: false, source: 'pt-BR' },
    },
  },
  {
    key: 'weight',
    description: 'Fractional plural count (num): intl rounds the integer digits',
    placeholders: [
      { name: 'value', type: 'num', example: '1.5', description: null, declared: true },
    ],
    templates: {
      'en': { raw: '{value, plural, one{{value} kilogram} other{{value} kilograms}}', isFallback: false, source: 'en' },
      'ru': { raw: '{value, plural, one{{value} килограмм} few{{value} килограмма} many{{value} килограммов} other{{value} килограмма}}', isFallback: false, source: 'ru' },
      'pt-BR': { raw: '{value, plural, one{{value} quilograma} other{{value} quilogramas}}', isFallback: false, source: 'pt-BR' },
      'ar': { raw: '{value, plural, zero{{value} كيلوغرام} one{كيلوغرام} two{كيلوغرامان} few{{value} كيلوغرامات} many{{value} كيلوغرامًا} other{{value} كيلوغرام}}', isFallback: false, source: 'ar' },
      'fr': { raw: '{value, plural, one{{value} kilogramme} other{{value} kilogrammes}}', isFallback: false, source: 'fr' },
      'de': { raw: '{value, plural, one{{value} Kilogramm} other{{value} Kilogramm}}', isFallback: false, source: 'de' },
      'de-AT': { raw: '{value, plural, one{{value} Kilogramm} other{{value} Kilogramm}}', isFallback: true, source: 'de' },
      'ja': { raw: '{value}キログラム', isFallback: false, source: 'ja' },
      'pl': { raw: '{value, plural, one{{value} kilogram} few{{value} kilogramy} many{{value} kilogramów} other{{value} kilograma}}', isFallback: false, source: 'pl' },
      'pt': { raw: '{value, plural, one{{value} quilograma} other{{value} quilogramas}}', isFallback: false, source: 'pt-BR' },
    },
  },
  {
    key: 'price',
    description: 'Double placeholder',
    placeholders: [
      { name: 'amount', type: 'double', example: '9.5', description: null, declared: true },
    ],
    templates: {
      'en': { raw: 'Price: {amount} €', isFallback: false, source: 'en' },
      'ru': { raw: 'Цена: {amount} ₽', isFallback: false, source: 'ru' },
      'pt-BR': { raw: 'Preço: R$ {amount}', isFallback: false, source: 'pt-BR' },
      'ar': { raw: 'السعر: {amount}', isFallback: false, source: 'ar' },
      'fr': { raw: 'Prix : {amount} €', isFallback: false, source: 'fr' },
      'de': { raw: 'Preis: {amount} €', isFallback: false, source: 'de' },
      'de-AT': { raw: 'Preis: {amount} €', isFallback: true, source: 'de' },
      'ja': { raw: '価格: {amount}円', isFallback: false, source: 'ja' },
      'pl': { raw: 'Cena: {amount} zł', isFallback: false, source: 'pl' },
      'pt': { raw: 'Preço: R$ {amount}', isFallback: false, source: 'pt-BR' },
    },
  },
  {
    key: 'pronoun',
    description: 'Select with a nested plural',
    placeholders: [
      { name: 'gender', type: 'String', example: 'female', description: null, declared: true },
      { name: 'count', type: 'int', example: '2', description: null, declared: true },
    ],
    templates: {
      'en': { raw: '{gender, select, male{He has {count, plural, =1{one cat} other{{count} cats}}} female{She has {count, plural, =1{one cat} other{{count} cats}}} other{They have {count, plural, =1{one cat} other{{count} cats}}}}', isFallback: false, source: 'en' },
      'ru': { raw: '{gender, select, male{У него {count, plural, one{{count} кот} few{{count} кота} many{{count} котов} other{{count} кота}}} female{У неё {count, plural, one{{count} кот} few{{count} кота} many{{count} котов} other{{count} кота}}} other{У них {count, plural, one{{count} кот} few{{count} кота} many{{count} котов} other{{count} кота}}}}', isFallback: false, source: 'ru' },
      'pt-BR': { raw: '{gender, select, male{Ele tem {count, plural, one{um gato} other{{count} gatos}}} female{Ela tem {count, plural, one{um gato} other{{count} gatos}}} other{Eles têm {count, plural, one{um gato} other{{count} gatos}}}}', isFallback: false, source: 'pt-BR' },
      'ar': { raw: '{gender, select, male{He has {count, plural, =1{one cat} other{{count} cats}}} female{She has {count, plural, =1{one cat} other{{count} cats}}} other{They have {count, plural, =1{one cat} other{{count} cats}}}}', isFallback: true, source: 'en' },
      'fr': { raw: '{gender, select, male{He has {count, plural, =1{one cat} other{{count} cats}}} female{She has {count, plural, =1{one cat} other{{count} cats}}} other{They have {count, plural, =1{one cat} other{{count} cats}}}}', isFallback: true, source: 'en' },
      'de': { raw: '{gender, select, male{Er hat {count, plural, one{eine Katze} other{{count} Katzen}}} female{Sie hat {count, plural, one{eine Katze} other{{count} Katzen}}} other{Sie haben {count, plural, one{eine Katze} other{{count} Katzen}}}}', isFallback: false, source: 'de' },
      'de-AT': { raw: '{gender, select, male{Er hat {count, plural, one{eine Katze} other{{count} Katzen}}} female{Sie hat {count, plural, one{eine Katze} other{{count} Katzen}}} other{Sie haben {count, plural, one{eine Katze} other{{count} Katzen}}}}', isFallback: true, source: 'de' },
      'ja': { raw: '{gender, select, male{He has {count, plural, =1{one cat} other{{count} cats}}} female{She has {count, plural, =1{one cat} other{{count} cats}}} other{They have {count, plural, =1{one cat} other{{count} cats}}}}', isFallback: true, source: 'en' },
      'pl': { raw: '{gender, select, male{He has {count, plural, =1{one cat} other{{count} cats}}} female{She has {count, plural, =1{one cat} other{{count} cats}}} other{They have {count, plural, =1{one cat} other{{count} cats}}}}', isFallback: true, source: 'en' },
      'pt': { raw: '{gender, select, male{Ele tem {count, plural, one{um gato} other{{count} gatos}}} female{Ela tem {count, plural, one{um gato} other{{count} gatos}}} other{Eles têm {count, plural, one{um gato} other{{count} gatos}}}}', isFallback: false, source: 'pt-BR' },
    },
  },
  {
    key: 'terms',
    description: 'Inline markup',
    placeholders: [],
    templates: {
      'en': { raw: 'Accept the <b>terms</b> and the <a>policy</a>', isFallback: false, source: 'en' },
      'ru': { raw: 'Примите <b>условия</b> и <a>политику</a>', isFallback: false, source: 'ru' },
      'pt-BR': { raw: 'Aceite os <b>termos</b> e a <a>política</a>', isFallback: false, source: 'pt-BR' },
      'ar': { raw: 'Accept the <b>terms</b> and the <a>policy</a>', isFallback: true, source: 'en' },
      'fr': { raw: 'Acceptez les <b>conditions</b> et la <a>politique</a>', isFallback: false, source: 'fr' },
      'de': { raw: 'Akzeptieren Sie die <b>Bedingungen</b> und die <a>Richtlinie</a>', isFallback: false, source: 'de' },
      'de-AT': { raw: 'Akzeptieren Sie die <b>Bedingungen</b> und die <a>Richtlinie</a>', isFallback: true, source: 'de' },
      'ja': { raw: '<b>規約</b>と<a>ポリシー</a>に同意', isFallback: false, source: 'ja' },
      'pl': { raw: 'Zaakceptuj <b>warunki</b> i <a>politykę</a>', isFallback: false, source: 'pl' },
      'pt': { raw: 'Aceite os <b>termos</b> e a <a>política</a>', isFallback: false, source: 'pt-BR' },
    },
  },
  {
    key: 'special',
    description: 'Characters that need escaping in generated code',
    placeholders: [],
    templates: {
      'en': { raw: 'It\'s $5 \\ 100% #1 `tick` "q" \t tab\nsecond line\r\nthird\u2028sep\u2029par \uFEFFbom */ end \x00nul', isFallback: false, source: 'en' },
      'ru': { raw: 'Это $5 \\ 100% #1\nвторая строка', isFallback: false, source: 'ru' },
      'pt-BR': { raw: 'It\'s $5 \\ 100% #1 `tick` "q" \t tab\nsecond line\r\nthird\u2028sep\u2029par \uFEFFbom */ end \x00nul', isFallback: true, source: 'en' },
      'ar': { raw: 'It\'s $5 \\ 100% #1 `tick` "q" \t tab\nsecond line\r\nthird\u2028sep\u2029par \uFEFFbom */ end \x00nul', isFallback: true, source: 'en' },
      'fr': { raw: 'It\'s $5 \\ 100% #1 `tick` "q" \t tab\nsecond line\r\nthird\u2028sep\u2029par \uFEFFbom */ end \x00nul', isFallback: true, source: 'en' },
      'de': { raw: 'Das ist $5 \\ 100% #1\nzweite Zeile', isFallback: false, source: 'de' },
      'de-AT': { raw: 'Das ist $5 \\ 100% #1\nzweite Zeile', isFallback: true, source: 'de' },
      'ja': { raw: 'It\'s $5 \\ 100% #1 `tick` "q" \t tab\nsecond line\r\nthird\u2028sep\u2029par \uFEFFbom */ end \x00nul', isFallback: true, source: 'en' },
      'pl': { raw: 'It\'s $5 \\ 100% #1 `tick` "q" \t tab\nsecond line\r\nthird\u2028sep\u2029par \uFEFFbom */ end \x00nul', isFallback: true, source: 'en' },
      'pt': { raw: 'It\'s $5 \\ 100% #1 `tick` "q" \t tab\nsecond line\r\nthird\u2028sep\u2029par \uFEFFbom */ end \x00nul', isFallback: true, source: 'en' },
    },
  },
  {
    key: 'dollarArg',
    description: 'A placeholder right after a dollar sign',
    placeholders: [
      { name: 'sum', type: 'String', example: '10', description: null, declared: true },
    ],
    templates: {
      'en': { raw: 'Total: ${sum}', isFallback: false, source: 'en' },
      'ru': { raw: 'Итого: ${sum}', isFallback: false, source: 'ru' },
      'pt-BR': { raw: 'Total: ${sum}', isFallback: true, source: 'en' },
      'ar': { raw: 'Total: ${sum}', isFallback: true, source: 'en' },
      'fr': { raw: 'Total: ${sum}', isFallback: true, source: 'en' },
      'de': { raw: 'Summe: ${sum}', isFallback: false, source: 'de' },
      'de-AT': { raw: 'Summe: ${sum}', isFallback: true, source: 'de' },
      'ja': { raw: 'Total: ${sum}', isFallback: true, source: 'en' },
      'pl': { raw: 'Total: ${sum}', isFallback: true, source: 'en' },
      'pt': { raw: 'Total: ${sum}', isFallback: true, source: 'en' },
    },
  },
  {
    key: 'lastSeen',
    description: 'Undeclared placeholder (typed Object)',
    placeholders: [
      { name: 'when', type: 'Object', example: null, description: null, declared: false },
    ],
    templates: {
      'en': { raw: 'Last seen {when}', isFallback: false, source: 'en' },
      'ru': { raw: 'Был(а) {when}', isFallback: false, source: 'ru' },
      'pt-BR': { raw: 'Visto {when}', isFallback: false, source: 'pt-BR' },
      'ar': { raw: 'Last seen {when}', isFallback: true, source: 'en' },
      'fr': { raw: 'Vu {when}', isFallback: false, source: 'fr' },
      'de': { raw: 'Zuletzt {when}', isFallback: false, source: 'de' },
      'de-AT': { raw: 'Zuletzt {when}', isFallback: true, source: 'de' },
      'ja': { raw: 'Last seen {when}', isFallback: true, source: 'en' },
      'pl': { raw: 'Last seen {when}', isFallback: true, source: 'en' },
      'pt': { raw: 'Visto {when}', isFallback: false, source: 'pt-BR' },
    },
  },
  {
    key: 'unicode',
    description: 'Emoji, combining marks, RTL, astral plane and a lone surrogate',
    placeholders: [],
    templates: {
      'en': { raw: '👋 héllo é 𝔘𝔫𝔦 ‏ עברית \uD83D!', isFallback: false, source: 'en' },
      'ru': { raw: '👋 привет', isFallback: false, source: 'ru' },
      'pt-BR': { raw: '👋 héllo é 𝔘𝔫𝔦 ‏ עברית \uD83D!', isFallback: true, source: 'en' },
      'ar': { raw: '👋 héllo é 𝔘𝔫𝔦 ‏ עברית \uD83D!', isFallback: true, source: 'en' },
      'fr': { raw: '👋 héllo é 𝔘𝔫𝔦 ‏ עברית \uD83D!', isFallback: true, source: 'en' },
      'de': { raw: '👋 héllo é 𝔘𝔫𝔦 ‏ עברית \uD83D!', isFallback: true, source: 'en' },
      'de-AT': { raw: '👋 héllo é 𝔘𝔫𝔦 ‏ עברית \uD83D!', isFallback: true, source: 'en' },
      'ja': { raw: '👋 こんにちは', isFallback: false, source: 'ja' },
      'pl': { raw: '👋 héllo é 𝔘𝔫𝔦 ‏ עברית \uD83D!', isFallback: true, source: 'en' },
      'pt': { raw: '👋 héllo é 𝔘𝔫𝔦 ‏ עברית \uD83D!', isFallback: true, source: 'en' },
    },
  },
  {
    key: 'delete',
    description: 'A key that is a JavaScript reserved word',
    placeholders: [],
    templates: {
      'en': { raw: 'Delete', isFallback: false, source: 'en' },
      'ru': { raw: 'Удалить', isFallback: false, source: 'ru' },
      'pt-BR': { raw: 'Excluir', isFallback: false, source: 'pt-BR' },
      'ar': { raw: 'حذف', isFallback: false, source: 'ar' },
      'fr': { raw: 'Supprimer', isFallback: false, source: 'fr' },
      'de': { raw: 'Löschen', isFallback: false, source: 'de' },
      'de-AT': { raw: 'Löschen', isFallback: true, source: 'de' },
      'ja': { raw: '削除', isFallback: false, source: 'ja' },
      'pl': { raw: 'Usuń', isFallback: false, source: 'pl' },
      'pt': { raw: 'Excluir', isFallback: false, source: 'pt-BR' },
    },
  },
  {
    key: 'choice',
    description: 'Select with unusual case values',
    placeholders: [
      { name: 'kind', type: 'String', example: 'a|b', description: null, declared: true },
    ],
    templates: {
      'en': { raw: '{kind, select, a|b{pipe} 1{one} constructor{ctor} __proto__{proto} other{other}}', isFallback: false, source: 'en' },
      'ru': { raw: '{kind, select, a|b{pipe} 1{one} constructor{ctor} __proto__{proto} other{other}}', isFallback: true, source: 'en' },
      'pt-BR': { raw: '{kind, select, a|b{pipe} 1{one} constructor{ctor} __proto__{proto} other{other}}', isFallback: true, source: 'en' },
      'ar': { raw: '{kind, select, a|b{pipe} 1{one} constructor{ctor} __proto__{proto} other{other}}', isFallback: true, source: 'en' },
      'fr': { raw: '{kind, select, a|b{pipe} 1{one} constructor{ctor} __proto__{proto} other{other}}', isFallback: true, source: 'en' },
      'de': { raw: '{kind, select, a|b{pipe} 1{one} constructor{ctor} __proto__{proto} other{other}}', isFallback: true, source: 'en' },
      'de-AT': { raw: '{kind, select, a|b{pipe} 1{one} constructor{ctor} __proto__{proto} other{other}}', isFallback: true, source: 'en' },
      'ja': { raw: '{kind, select, a|b{pipe} 1{one} constructor{ctor} __proto__{proto} other{other}}', isFallback: true, source: 'en' },
      'pl': { raw: '{kind, select, a|b{pipe} 1{one} constructor{ctor} __proto__{proto} other{other}}', isFallback: true, source: 'en' },
      'pt': { raw: '{kind, select, a|b{pipe} 1{one} constructor{ctor} __proto__{proto} other{other}}', isFallback: true, source: 'en' },
    },
  },
  {
    key: 'empty',
    description: 'An empty plural branch',
    placeholders: [
      { name: 'n', type: 'int', example: '0', description: null, declared: true },
    ],
    templates: {
      'en': { raw: '{n, plural, =0{} other{{n} left}}', isFallback: false, source: 'en' },
      'ru': { raw: '{n, plural, =0{} other{{n} left}}', isFallback: true, source: 'en' },
      'pt-BR': { raw: '{n, plural, =0{} other{{n} left}}', isFallback: true, source: 'en' },
      'ar': { raw: '{n, plural, =0{} other{{n} left}}', isFallback: true, source: 'en' },
      'fr': { raw: '{n, plural, =0{} other{{n} left}}', isFallback: true, source: 'en' },
      'de': { raw: '{n, plural, =0{} other{{n} left}}', isFallback: true, source: 'en' },
      'de-AT': { raw: '{n, plural, =0{} other{{n} left}}', isFallback: true, source: 'en' },
      'ja': { raw: '{n, plural, =0{} other{{n} left}}', isFallback: true, source: 'en' },
      'pl': { raw: '{n, plural, =0{} other{{n} left}}', isFallback: true, source: 'en' },
      'pt': { raw: '{n, plural, =0{} other{{n} left}}', isFallback: true, source: 'en' },
    },
  },
  {
    key: 'onlyFallback',
    description: 'Only the base language',
    placeholders: [],
    templates: {
      'en': { raw: 'Base only', isFallback: false, source: 'en' },
      'ru': { raw: 'Base only', isFallback: true, source: 'en' },
      'pt-BR': { raw: 'Base only', isFallback: true, source: 'en' },
      'ar': { raw: 'Base only', isFallback: true, source: 'en' },
      'fr': { raw: 'Base only', isFallback: true, source: 'en' },
      'de': { raw: 'Base only', isFallback: true, source: 'en' },
      'de-AT': { raw: 'Base only', isFallback: true, source: 'en' },
      'ja': { raw: 'Base only', isFallback: true, source: 'en' },
      'pl': { raw: 'Base only', isFallback: true, source: 'en' },
      'pt': { raw: 'Base only', isFallback: true, source: 'en' },
    },
  },
];

/**
 * Renders the message `key` of `locale` with `args` (placeholder name -> value),
 * without static types.
 */
export async function format(
  locale: Locale,
  key: string,
  args: Readonly<Record<string, unknown>> = {},
): Promise<string> {
  return formatMessage(await loaders[locale](), key, args);
}
