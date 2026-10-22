# This file is generated, do not edit it manually!
# ruff: noqa
"""Runtime support of the generated localization package.

Zero dependencies, Python >= 3.9. Behaves exactly like the Dart (Flutter)
output, which uses ``package:intl``:

* plural branches are chosen like ``Intl.pluralLogic``: an exact ``=0``/``=1``/
  ``=2`` (``zero``/``one``/``two``) branch wins first, then the CLDR category
  of the locale, with ``two`` falling back to ``few`` and everything to
  ``other``; the CLDR operands are computed like intl does (``i`` is the
  *rounded* value, at most three fraction digits) and ``n`` relations test
  the count itself (``1.0004`` is not ``n = 1``);
* select branches are chosen like ``Intl.selectLogic``;
* values are converted to text like Dart's ``'$value'`` (``1.0``, ``1e+21``,
  ``true``), see :func:`to_str`.

Plural rules: Unicode CLDR 48.2.0, cardinal.
"""

from __future__ import annotations

import abc
import math
import numbers
import re
from dataclasses import dataclass
from decimal import Decimal
from types import MappingProxyType
from typing import (
    Callable,
    ClassVar,
    FrozenSet,
    List,
    Mapping,
    Optional,
    Sequence,
    Tuple,
    Union,
    cast,
)

__all__ = [
    "CLDR_VERSION",
    "Localization",
    "Message",
    "PLURAL_RULES",
    "Placeholder",
    "PluralRule",
    "intl_operands",
    "negotiate_locale",
    "normalize_locale",
    "parse_accept_language",
    "plural_case",
    "plural_category",
    "sanitize_key",
    "select_case",
    "to_str",
]

#: Unicode CLDR release the plural rules were compiled from.
CLDR_VERSION = "@CLDR@"

#: A compiled plural rule: ``(n, i, v, f, t) -> category``.
PluralRule = Callable[[float, int, int, int, int], str]


class _Record:
    """Pickle support for the frozen, slotted records (Python 3.9 lacks
    ``dataclass(slots=True)``)."""

    __slots__ = ()

    def __getstate__(self) -> Tuple[object, ...]:
        names: Tuple[str, ...] = self.__slots__
        return tuple(getattr(self, name) for name in names)

    def __setstate__(self, state: Tuple[object, ...]) -> None:
        names: Tuple[str, ...] = self.__slots__
        for name, value in zip(names, state):
            object.__setattr__(self, name, value)


@dataclass(frozen=True)
class Placeholder(_Record):
    """A placeholder of a message, as declared in the sheet's meta column."""

    __slots__ = ("name", "parameter", "type", "example", "description")

    #: Name in the sheet (``{maxFiles}``); the keyword of ``format()``.
    name: str
    #: Keyword parameter of the generated method (``max_files``).
    parameter: str
    #: Declared or inferred type: ``String``, ``int``, ``num``, ``double`` or
    #: ``Object``.
    type: str
    #: Example value from the meta column, if any.
    example: Optional[str]
    #: Description from the meta column, if any.
    description: Optional[str]


@dataclass(frozen=True)
class Message(_Record):
    """Metadata of one message (one row of the sheet)."""

    __slots__ = ("key", "attribute", "description", "placeholders")

    #: Key as in the sheet (sanitized label), e.g. ``chatAttachmentError``.
    key: str
    #: Property / method of the localization class (``chat_attachment_error``).
    attribute: str
    #: Description of the message, if any.
    description: Optional[str]
    #: Placeholders in parameter order; empty for a property.
    placeholders: Tuple[Placeholder, ...]

    @property
    def is_method(self) -> bool:
        """Whether the message is a method (has placeholders), not a property."""
        return bool(self.placeholders)


_INVALID_KEY = re.compile(r"[^a-zA-Z0-9_]")
_REPEATED_UNDERSCORE = re.compile(r"_+")


def sanitize_key(label: str) -> str:
    """The key the generator derives from a sheet label:
    ``chat.welcome.1`` -> ``chat_welcome_1``."""
    return _REPEATED_UNDERSCORE.sub("_", _INVALID_KEY.sub("_", label)).strip("_")


class Localization(abc.ABC):
    """Base class of every generated localization class.

    A scope's abstract class (``ChatLocalization``) declares one property or
    method per message; every locale module implements it.
    """

    __slots__ = ()

    #: Scope (sheet) name.
    SCOPE: ClassVar[str]
    #: Base locale of the scope.
    BASE_LOCALE: ClassVar[str]
    #: Message metadata, in sheet order.
    MESSAGES: ClassVar[Tuple[Message, ...]]
    #: Locale code of the implementation (``pt_BR``).
    LOCALE: ClassVar[str]
    #: Raw templates of this locale by key (ICU or mustache, as in the sheet;
    #: fallbacks resolved).
    TEMPLATES: ClassVar[Mapping[str, str]]
    #: Keys whose text is not translated in this locale and was taken from the
    #: parent locale or the base locale.
    FALLBACK_KEYS: ClassVar[FrozenSet[str]]
    _MESSAGES_BY_KEY: ClassVar[Mapping[str, Message]]

    def format(self, key: str, /, **kwargs: object) -> str:
        """Renders the message ``key`` with ``kwargs``, for keys known only at
        runtime.

        ``key`` is the key as in the sheet (``chatAttachmentErrorMaxFiles``);
        a raw sheet label (``chat.attachment.error``) is sanitized like the
        generator does. ``kwargs`` use the placeholder names of the sheet
        (``maxFiles=3``), not the snake_case parameter names.

        Raises ``KeyError`` for an unknown key and ``TypeError`` for missing
        or unexpected arguments.
        """
        message = self._MESSAGES_BY_KEY.get(key)
        if message is None:
            message = self._MESSAGES_BY_KEY.get(sanitize_key(key))
        if message is None:
            raise KeyError(f"Unknown message {key!r} in scope {self.SCOPE!r}")
        value: object = getattr(self, message.attribute)
        names = [p.name for p in message.placeholders]
        unexpected = sorted(set(kwargs).difference(names))
        if unexpected:
            raise TypeError(
                f"{self.SCOPE}.{message.key}: unexpected argument(s) "
                + ", ".join(unexpected)
            )
        if not message.placeholders:
            return cast(str, value)
        missing = [name for name in names if name not in kwargs]
        if missing:
            raise TypeError(
                f"{self.SCOPE}.{message.key}: missing argument(s) " + ", ".join(missing)
            )
        method = cast(Callable[..., str], value)
        return method(**{p.parameter: kwargs[p.name] for p in message.placeholders})

    def __repr__(self) -> str:
        return f"<{type(self).__name__} {self.SCOPE}/{self.LOCALE}>"


def _dart_double(value: float) -> str:
    """``'$value'`` of a Dart ``double``: the shortest round-trip digits,
    decimal notation for 1e-6 <= |value| < 1e21 (with ``.0`` for integral
    values), exponential otherwise (``1e+21``, ``1.5e-7``)."""
    if math.isnan(value):
        return "NaN"
    if math.isinf(value):
        return "Infinity" if value > 0 else "-Infinity"
    if value == 0:
        return "-0.0" if math.copysign(1.0, value) < 0 else "0.0"
    sign = "-" if value < 0 else ""
    mantissa, _, exponent = repr(abs(value)).partition("e")
    whole, _, fraction = mantissa.partition(".")
    raw = whole + fraction
    digits = raw.lstrip("0")
    point = len(whole) - (len(raw) - len(digits)) + (int(exponent) if exponent else 0)
    digits = digits.rstrip("0") or "0"
    count = len(digits)
    if count <= point <= 21:
        return sign + digits + "0" * (point - count) + ".0"
    if 0 < point <= 21:
        return sign + digits[:point] + "." + digits[point:]
    if -6 < point <= 0:
        return sign + "0." + "0" * -point + digits
    power = point - 1
    head = digits[0] + ("." + digits[1:] if count > 1 else "")
    return sign + head + "e" + ("+" if power >= 0 else "-") + str(abs(power))


def to_str(value: object) -> str:
    """Converts a placeholder value to text the way Dart's ``'$value'`` does:
    ``int`` as is, ``float`` like a Dart ``double`` (``1.0``, ``1.5``,
    ``1e+21``, ``1e-7``, ``NaN``, ``Infinity``), ``True``/``False`` as
    ``true``/``false``, ``None`` as ``null``, anything else with ``str()``.
    """
    if isinstance(value, str):
        return value
    if isinstance(value, bool):
        return "true" if value else "false"
    if isinstance(value, int):
        return str(value)
    if isinstance(value, float):
        return _dart_double(value)
    if value is None:
        return "null"
    return str(value)


def intl_operands(how_many: object) -> Tuple[float, int, int, int, int]:
    """CLDR operands ``(n, i, v, f, t)`` exactly as ``package:intl`` computes
    them: ``n`` is the count itself (an integral float counts as an int; the
    sign is kept), ``i`` the count rounded half away from zero, ``v`` the
    number of fraction digits of the Dart text (at most 3), ``f``/``t`` from
    floating point arithmetic.

    Other real numbers (``Decimal``, ``Fraction``) are converted with
    ``float()``; anything else raises ``TypeError``."""
    n: Union[int, float]
    if isinstance(how_many, (int, float)):
        n = how_many
    elif isinstance(how_many, (numbers.Real, Decimal)):
        n = float(how_many)
    else:
        raise TypeError(
            f"Plural count must be a real number, got {type(how_many).__name__}"
        )
    if isinstance(n, float):
        if not math.isfinite(n):
            raise ValueError(f"Plural count must be finite, got {n!r}")
        if n.is_integer():
            n = int(n)
    if isinstance(n, int):
        count = int(n)
        return count, count, 0, 0, 0
    magnitude = abs(n)
    rounded = math.floor(magnitude)
    if magnitude - rounded >= 0.5:
        rounded += 1
    i = rounded if n >= 0 else -rounded
    text = _dart_double(n)
    dot = text.find(".")
    v = min(0 if dot < 0 else len(text) - dot - 1, 3)
    base = 10**v
    f = math.floor(n * base) % base
    t = f
    while t and t % 10 == 0:
        t //= 10
    return n, i, v, f, t


def plural_case(how_many: float, rule: PluralRule, cases: Tuple[str, ...]) -> str:
    """The branch of a plural message, like ``Intl.pluralLogic``.

    ``cases`` are the categories the message provides (``=0``/``=1``/``=2``
    count as ``zero``/``one``/``two``).
    """
    if how_many == 0 and "zero" in cases:
        return "zero"
    if how_many == 1 and "one" in cases:
        return "one"
    if how_many == 2 and "two" in cases:
        return "two"
    category = rule(*intl_operands(how_many))
    if category in cases:
        return category
    if category == "two" and "few" in cases:
        return "few"
    return "other"


def select_case(choice: object, cases: Tuple[str, ...]) -> str:
    """The branch of a select message, like ``Intl.selectLogic``: the exact
    value, then the text after the last ``.`` (``Gender.female`` ->
    ``female``, for enums), then ``other``."""
    if isinstance(choice, str) and choice in cases:
        return choice
    tail = to_str(choice).split(".")[-1]
    if tail in cases:
        return tail
    return "other"


# --- CLDR plural rules (cardinal), only for the locales in use ---


def cardinal_root(n: float, i: int, v: int, f: int, t: int) -> str:
    """CLDR 48.2.0 cardinal rules of "root"."""
    return "other"


def cardinal_ar(n: float, i: int, v: int, f: int, t: int) -> str:
    """CLDR 48.2.0 cardinal rules of "ar"."""
    if (n == i and i == 0):
        return "zero"
    if (n == i and i == 1):
        return "one"
    if (n == i and i == 2):
        return "two"
    if (n == i and 3 <= i % 100 <= 10):
        return "few"
    if (n == i and 11 <= i % 100 <= 99):
        return "many"
    return "other"


def cardinal_de(n: float, i: int, v: int, f: int, t: int) -> str:
    """CLDR 48.2.0 cardinal rules of "de"."""
    if i == 1 and v == 0:
        return "one"
    return "other"


def cardinal_en(n: float, i: int, v: int, f: int, t: int) -> str:
    """CLDR 48.2.0 cardinal rules of "en"."""
    if i == 1 and v == 0:
        return "one"
    return "other"


def cardinal_pt(n: float, i: int, v: int, f: int, t: int) -> str:
    """CLDR 48.2.0 cardinal rules of "pt"."""
    if 0 <= i <= 1:
        return "one"
    if i != 0 and i % 1000000 == 0 and v == 0:
        return "many"
    return "other"


def cardinal_ru(n: float, i: int, v: int, f: int, t: int) -> str:
    """CLDR 48.2.0 cardinal rules of "ru"."""
    if v == 0 and i % 10 == 1 and i % 100 != 11:
        return "one"
    if v == 0 and 2 <= i % 10 <= 4 and not 12 <= i % 100 <= 14:
        return "few"
    if (v == 0 and i % 10 == 0) or (v == 0 and 5 <= i % 10 <= 9) or (v == 0 and 11 <= i % 100 <= 14):
        return "many"
    return "other"


#: Plural rules of every supported locale, by locale code.
PLURAL_RULES: Mapping[str, PluralRule] = MappingProxyType(
    {
    "en": cardinal_en,
    "de": cardinal_de,
    "ru": cardinal_ru,
    "pt_BR": cardinal_pt,
    "ar": cardinal_ar,
    "ar_EG": cardinal_ar,
    "pt": cardinal_pt,
    }
)


def plural_category(locale: str, how_many: float) -> str:
    """The CLDR cardinal category of ``how_many`` in ``locale`` (intl
    operands, see :func:`intl_operands`); ``other`` for unknown locales."""
    code = normalize_locale(locale)
    if code is not None:
        for candidate in _candidates(code):
            rule = PLURAL_RULES.get(candidate)
            if rule is not None:
                return rule(*intl_operands(how_many))
    return cardinal_root(*intl_operands(how_many))


_SEPARATOR = re.compile(r"[-_]")
_LANGUAGE = re.compile(r"[A-Za-z]{2,3}")
_SCRIPT = re.compile(r"[A-Za-z]{4}")
_REGION = re.compile(r"[A-Za-z]{2}|[0-9]{3}")
_QUALITY = re.compile(r"[0-9]+(?:\.[0-9]*)?|\.[0-9]+")
_WHITESPACE = " \t\n\v\f\r"
_ALIASES = {"iw": "he", "in": "id", "ji": "yi", "jw": "jv", "mo": "ro"}

# Locale negotiation is specified once and implemented identically by the
# TypeScript runtime (``negotiateLocale``); a shared test table runs against
# both. Only ASCII is meaningful: whitespace is " \t\n\v\f\r", subtags are
# ASCII letters / digits.


def normalize_locale(tag: str) -> Optional[str]:
    """Normalizes a BCP 47 / POSIX locale (``pt-br``, ``PT_br``,
    ``zh-Hant-TW``, ``en_US.UTF-8``, ``de-DE-u-co-phonebk``) to the code
    used by the generator (``pt_BR``, ``zh_Hant_TW``, ``en_US``, ``de_DE``);
    ``None`` when it is not a locale (``*``, ``C``, empty).

    The text before the first ``.`` and ``@`` is split at ``-`` and ``_``;
    the first subtag must be a 2-3 letter language, then an optional
    4-letter script and an optional 2-letter or 3-digit region are taken
    while they come in that order; anything else ends the tag."""
    head = tag.strip(_WHITESPACE).split(".")[0].split("@")[0]
    parts = [p for p in _SEPARATOR.split(head) if p]
    if not parts or not _LANGUAGE.fullmatch(parts[0]):
        return None
    language = parts[0].lower()
    script: Optional[str] = None
    region: Optional[str] = None
    for part in parts[1:]:
        if script is None and region is None and _SCRIPT.fullmatch(part):
            script = part[0].upper() + part[1:].lower()
        elif region is None and _REGION.fullmatch(part):
            region = part.upper()
        else:
            break
    return "_".join(p for p in (language, script, region) if p)


def _candidates(code: str) -> List[str]:
    parts = code.split("_")
    language = parts[0]
    script = next((p for p in parts[1:] if len(p) == 4), None)
    region = next((p for p in parts[1:] if len(p) != 4), None)
    result: List[str] = []
    for lang in (language, _ALIASES.get(language)):
        if lang is None:
            continue
        if script and region:
            result.append(f"{lang}_{script}_{region}")
        if script:
            result.append(f"{lang}_{script}")
        if region:
            result.append(f"{lang}_{region}")
        result.append(lang)
    return result


def parse_accept_language(header: str) -> List[str]:
    """The language tags of an HTTP ``Accept-Language`` header, best first:
    ``"fr-CH, fr;q=0.9, en;q=0.8, *;q=0.5"`` -> ``["fr-CH", "fr", "en"]``.

    A ``q`` value must be a plain decimal number (``0.8``, ``1``, ``.5``);
    values above 1 count as 1, anything else as 0. Tags with ``q=0`` and the
    wildcard ``*`` are dropped; equal weights keep their order.
    """
    weighted: List[Tuple[float, int, str]] = []
    for index, item in enumerate(header.split(",")):
        tag, _, params = item.partition(";")
        tag = tag.strip(_WHITESPACE)
        if not tag or tag == "*":
            continue
        quality = 1.0
        for param in params.split(";"):
            name, _, value = param.partition("=")
            if name.strip(_WHITESPACE) in ("q", "Q"):
                value = value.strip(_WHITESPACE)
                quality = min(float(value), 1.0) if _QUALITY.fullmatch(value) else 0.0
        if not quality > 0:
            continue
        weighted.append((-quality, index, tag))
    weighted.sort()
    return [tag for _, _, tag in weighted]


def negotiate_locale(
    requested: Union[str, Sequence[str], None],
    supported: Sequence[str],
    default: str,
) -> str:
    """Picks the best of ``supported`` for ``requested``.

    ``requested`` is one tag (``pt-BR``), an ``Accept-Language`` header
    (anything with ``,`` or ``;``), a sequence of tags, best first, or
    ``None``. Every requested tag (see :func:`normalize_locale`) is tried
    with its fallbacks (``zh_Hant_TW`` -> ``zh_Hant`` -> ``zh_TW`` -> ``zh``,
    then the same for the current code of a deprecated language: ``iw`` ->
    ``he``); then the first supported locale of any requested language
    (``pt`` -> ``pt_BR``); then ``default``.
    """
    if requested is None:
        return default
    if isinstance(requested, str):
        tags = (
            parse_accept_language(requested)
            if "," in requested or ";" in requested
            else [requested]
        )
    else:
        tags = list(requested)
    available = set(supported)
    codes = [c for c in (normalize_locale(t) for t in tags) if c is not None]
    for code in codes:
        for candidate in _candidates(code):
            if candidate in available:
                return candidate
    for code in codes:
        languages = {code.split("_")[0], _ALIASES.get(code.split("_")[0])}
        for locale in supported:
            if locale.split("_")[0] in languages:
                return locale
    return default
