# This file is generated, do not edit it manually!
# ruff: noqa
"""Messages of the sheet "backend-2026-09-23-country-names" in ru.

0 of 3 messages use a fallback text.
"""

from __future__ import annotations

from types import MappingProxyType as _MappingProxyType

from . import Backend20260923CountryNamesLocalization

__all__ = ["Backend20260923CountryNamesLocalizationRu", "LOCALIZATION"]


class Backend20260923CountryNamesLocalizationRu(Backend20260923CountryNamesLocalization):
    """backend-2026-09-23-country-names in ru."""

    __slots__ = ()

    LOCALE = "ru"
    TEMPLATES = _MappingProxyType(
        {
            "country_name_ad": "Андорра",
            "country_name_br": "Бразилия",
            "country_name_us": "США",
        }
    )
    FALLBACK_KEYS = frozenset()

    @property
    def country_name_ad(self) -> str:
        return "Андорра"

    @property
    def country_name_br(self) -> str:
        return "Бразилия"

    @property
    def country_name_us(self) -> str:
        return "США"


#: The (stateless) instance returned by ``get()``.
LOCALIZATION = Backend20260923CountryNamesLocalizationRu()
