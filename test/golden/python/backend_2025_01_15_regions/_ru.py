# This file is generated, do not edit it manually!
# ruff: noqa
"""Messages of the sheet "backend-2025-01-15-regions" in ru.

0 of 3 messages use a fallback text.
"""

from __future__ import annotations

from types import MappingProxyType as _MappingProxyType

from . import Backend20250115RegionsLocalization

__all__ = ["Backend20250115RegionsLocalizationRu", "LOCALIZATION"]


class Backend20250115RegionsLocalizationRu(Backend20250115RegionsLocalization):
    """backend-2025-01-15-regions in ru."""

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
LOCALIZATION = Backend20250115RegionsLocalizationRu()
