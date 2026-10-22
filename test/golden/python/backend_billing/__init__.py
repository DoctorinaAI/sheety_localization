# This file is generated, do not edit it manually!
# ruff: noqa
"""Messages of the sheet "backend-billing\".

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
    "BackendBillingLocalization",
    "get",
    "resolve_locale",
]

#: Scope name (sanitized sheet title).
SCOPE = "backend_billing"
#: Title of the sheet.
SHEET_TITLE = "backend-billing"
#: Message syntax of the sheet: ``icu`` or ``mustache``.
SYNTAX = "mustache"
#: Base locale (the fourth column of the sheet).
BASE_LOCALE = "en"
#: Locales, in sheet order (synthetic parents last).
LOCALES: _typing.Tuple[str, ...] = ("en", "ru")


class BackendBillingLocalization(Localization):
    """Messages of the sheet "backend-billing" (base locale en)."""

    __slots__ = ()

    SCOPE = "backend_billing"
    BASE_LOCALE = "en"
    MESSAGES: _typing.ClassVar[_typing.Tuple[Message, ...]] = (
        Message(
            key="billing_price",
            attribute="billing_price",
            description="Mustache placeholders",
            placeholders=(
                Placeholder(
                    name="price",
                    parameter="price",
                    type="Object",
                    example=None,
                    description=None,
                ),
                Placeholder(
                    name="unit_price",
                    parameter="unit_price",
                    type="Object",
                    example=None,
                    description=None,
                ),
            ),
        ),
        Message(
            key="billing_title",
            attribute="billing_title",
            description="Single braces are text in mustache",
            placeholders=(),
        ),
    )
    _MESSAGES_BY_KEY = _MappingProxyType({m.key: m for m in MESSAGES})

    @_abc.abstractmethod
    def billing_price(self, *, price: object, unit_price: object) -> str:
        """Mustache placeholders

        Key: ``billing_price``.

        Arguments:
            price (Object)
            unit_price (Object)

        In en: Only {{price}} per month ({{ unit_price }} per seat)
        """

    @property
    @_abc.abstractmethod
    def billing_title(self) -> str:
        """Single braces are text in mustache

        Key: ``billing_title``.

        In en: Contact {team}
        """


#: Message metadata, in sheet order.
MESSAGES = BackendBillingLocalization.MESSAGES

_INSTANCES: _typing.Dict[str, BackendBillingLocalization] = {}


def resolve_locale(requested: _typing.Union[str, _typing.Sequence[str]]) -> str:
    """The best of ``LOCALES`` for a tag (``pt-BR``), a list of tags or an
    ``Accept-Language`` header; ``BASE_LOCALE`` when none matches."""
    return negotiate_locale(requested, LOCALES, BASE_LOCALE)


def get(locale: _typing.Union[str, _typing.Sequence[str]] = BASE_LOCALE) -> BackendBillingLocalization:
    """The localization for ``locale`` (negotiated with :func:`resolve_locale`).

    Locale modules are imported on first use; instances are cached.
    """
    code = resolve_locale(locale)
    instance = _INSTANCES.get(code)
    if instance is None:
        module = _importlib.import_module("._" + code, __name__)
        instance = _typing.cast(BackendBillingLocalization, getattr(module, "LOCALIZATION"))
        _INSTANCES[code] = instance
    return instance
