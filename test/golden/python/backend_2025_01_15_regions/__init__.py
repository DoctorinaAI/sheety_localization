# This file is generated, do not edit it manually!
# ruff: noqa
"""Messages of the sheet "backend-2025-01-15-regions\".

Base locale: en. Locales: en, ru, pt, pt_BR, es_419, es.
"""

from __future__ import annotations

import abc as _abc
import importlib as _importlib
import typing as _typing
from types import MappingProxyType as _MappingProxyType

from .._runtime import Localization, Message, negotiate_locale

__all__ = [
    "BASE_LOCALE",
    "LOCALES",
    "MESSAGES",
    "SCOPE",
    "SHEET_TITLE",
    "SYNTAX",
    "Backend20250115RegionsLocalization",
    "get",
    "resolve_locale",
]

#: Scope name (sanitized sheet title).
SCOPE = "backend_2025_01_15_regions"
#: Title of the sheet.
SHEET_TITLE = "backend-2025-01-15-regions"
#: Message syntax of the sheet: ``icu`` or ``mustache``.
SYNTAX = "icu"
#: Base locale (the fourth column of the sheet).
BASE_LOCALE = "en"
#: Locales, in sheet order (synthetic parents last).
LOCALES: _typing.Tuple[str, ...] = ("en", "ru", "pt", "pt_BR", "es_419", "es")


class Backend20250115RegionsLocalization(Localization):
    """Messages of the sheet "backend-2025-01-15-regions" (base locale en)."""

    __slots__ = ()

    SCOPE = "backend_2025_01_15_regions"
    BASE_LOCALE = "en"
    MESSAGES: _typing.ClassVar[_typing.Tuple[Message, ...]] = (
        Message(
            key="country_name_ad",
            attribute="country_name_ad",
            description="Country name",
            placeholders=(),
        ),
        Message(
            key="country_name_br",
            attribute="country_name_br",
            description="Country name",
            placeholders=(),
        ),
        Message(
            key="country_name_us",
            attribute="country_name_us",
            description="Country name",
            placeholders=(),
        ),
    )
    _MESSAGES_BY_KEY = _MappingProxyType({m.key: m for m in MESSAGES})

    @property
    @_abc.abstractmethod
    def country_name_ad(self) -> str:
        """Country name

        Key: ``country_name_ad``.

        In en: Andorra
        """

    @property
    @_abc.abstractmethod
    def country_name_br(self) -> str:
        """Country name

        Key: ``country_name_br``.

        In en: Brazil
        """

    @property
    @_abc.abstractmethod
    def country_name_us(self) -> str:
        """Country name

        Key: ``country_name_us``.

        In en: United States
        """


#: Message metadata, in sheet order.
MESSAGES = Backend20250115RegionsLocalization.MESSAGES

_INSTANCES: _typing.Dict[str, Backend20250115RegionsLocalization] = {}


def resolve_locale(requested: _typing.Union[str, _typing.Sequence[str]]) -> str:
    """The best of ``LOCALES`` for a tag (``pt-BR``), a list of tags or an
    ``Accept-Language`` header; ``BASE_LOCALE`` when none matches."""
    return negotiate_locale(requested, LOCALES, BASE_LOCALE)


def get(locale: _typing.Union[str, _typing.Sequence[str]] = BASE_LOCALE) -> Backend20250115RegionsLocalization:
    """The localization for ``locale`` (negotiated with :func:`resolve_locale`).

    Locale modules are imported on first use; instances are cached.
    """
    code = resolve_locale(locale)
    instance = _INSTANCES.get(code)
    if instance is None:
        module = _importlib.import_module("._" + code, __name__)
        instance = _typing.cast(Backend20250115RegionsLocalization, getattr(module, "LOCALIZATION"))
        _INSTANCES[code] = instance
    return instance
