# This file is generated, do not edit it manually!
# ruff: noqa
"""Messages of the sheet "backend-monetization\".

Base locale: en. Locales: en, ru.
"""

from __future__ import annotations

import abc as _abc
import importlib as _importlib
import typing as _typing
from types import MappingProxyType as _MappingProxyType

from .._runtime import Localization, Message, Placeholder, negotiate_locale

__all__ = [
    "BASE_LOCALE",
    "LOCALES",
    "MESSAGES",
    "SCOPE",
    "SHEET_TITLE",
    "SYNTAX",
    "BackendMonetizationLocalization",
    "get",
    "resolve_locale",
]

#: Scope name (sanitized sheet title).
SCOPE = "backend_monetization"
#: Title of the sheet.
SHEET_TITLE = "backend-monetization"
#: Message syntax of the sheet: ``icu`` or ``mustache``.
SYNTAX = "mustache"
#: Base locale (the fourth column of the sheet).
BASE_LOCALE = "en"
#: Locales, in sheet order (synthetic parents last).
LOCALES: _typing.Tuple[str, ...] = ("en", "ru")


class BackendMonetizationLocalization(Localization):
    """Messages of the sheet "backend-monetization" (base locale en)."""

    __slots__ = ()

    SCOPE = "backend_monetization"
    BASE_LOCALE = "en"
    MESSAGES: _typing.ClassVar[_typing.Tuple[Message, ...]] = (
        Message(
            key="monetization_price",
            attribute="monetization_price",
            description="Mustache placeholders",
            placeholders=(
                Placeholder(
                    name="avg_cost",
                    parameter="avg_cost",
                    type="Object",
                    example=None,
                    description=None,
                ),
                Placeholder(
                    name="price",
                    parameter="price",
                    type="Object",
                    example=None,
                    description=None,
                ),
            ),
        ),
        Message(
            key="monetization_title",
            attribute="monetization_title",
            description="Single braces are text in mustache",
            placeholders=(),
        ),
    )
    _MESSAGES_BY_KEY = _MappingProxyType({m.key: m for m in MESSAGES})

    @_abc.abstractmethod
    def monetization_price(self, *, avg_cost: object, price: object) -> str:
        """Mustache placeholders

        Key: ``monetization_price``.

        Arguments:
            avg_cost (Object)
            price (Object)

        In en: Only {{price}} per month ({{ avg_cost }} on average)
        """

    @property
    @_abc.abstractmethod
    def monetization_title(self) -> str:
        """Single braces are text in mustache

        Key: ``monetization_title``.

        In en: Support {consult}
        """


#: Message metadata, in sheet order.
MESSAGES = BackendMonetizationLocalization.MESSAGES

_INSTANCES: _typing.Dict[str, BackendMonetizationLocalization] = {}


def resolve_locale(requested: _typing.Union[str, _typing.Sequence[str]]) -> str:
    """The best of ``LOCALES`` for a tag (``pt-BR``), a list of tags or an
    ``Accept-Language`` header; ``BASE_LOCALE`` when none matches."""
    return negotiate_locale(requested, LOCALES, BASE_LOCALE)


def get(locale: _typing.Union[str, _typing.Sequence[str]] = BASE_LOCALE) -> BackendMonetizationLocalization:
    """The localization for ``locale`` (negotiated with :func:`resolve_locale`).

    Locale modules are imported on first use; instances are cached.
    """
    code = resolve_locale(locale)
    instance = _INSTANCES.get(code)
    if instance is None:
        module = _importlib.import_module("._" + code, __name__)
        instance = _typing.cast(BackendMonetizationLocalization, getattr(module, "LOCALIZATION"))
        _INSTANCES[code] = instance
    return instance
