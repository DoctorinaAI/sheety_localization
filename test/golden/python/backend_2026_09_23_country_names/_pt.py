# This file is generated, do not edit it manually!
# ruff: noqa
"""Messages of the sheet "backend-2026-09-23-country-names" in pt.

0 of 3 messages use a fallback text.
"""

from __future__ import annotations

from types import MappingProxyType as _MappingProxyType

from . import Backend20260923CountryNamesLocalization

__all__ = ["Backend20260923CountryNamesLocalizationPt", "LOCALIZATION"]


class Backend20260923CountryNamesLocalizationPt(Backend20260923CountryNamesLocalization):
    """backend-2026-09-23-country-names in pt."""

    __slots__ = ()

    LOCALE = "pt"
    TEMPLATES = _MappingProxyType(
        {
            "country_name_ad": "Andorra",
            "country_name_br": "Brasil",
            "country_name_us": "Estados Unidos",
        }
    )
    FALLBACK_KEYS = frozenset()

    @property
    def country_name_ad(self) -> str:
        return "Andorra"

    @property
    def country_name_br(self) -> str:
        return "Brasil"

    @property
    def country_name_us(self) -> str:
        return "Estados Unidos"


#: The (stateless) instance returned by ``get()``.
LOCALIZATION = Backend20260923CountryNamesLocalizationPt()
