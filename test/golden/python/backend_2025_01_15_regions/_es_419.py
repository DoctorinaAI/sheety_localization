# This file is generated, do not edit it manually!
# ruff: noqa
"""Messages of the sheet "backend-2025-01-15-regions" in es_419.

1 of 3 messages use a fallback text.
"""

from __future__ import annotations

from types import MappingProxyType as _MappingProxyType

from . import Backend20250115RegionsLocalization

__all__ = ["Backend20250115RegionsLocalizationEs419", "LOCALIZATION"]


class Backend20250115RegionsLocalizationEs419(Backend20250115RegionsLocalization):
    """backend-2025-01-15-regions in es_419."""

    __slots__ = ()

    LOCALE = "es_419"
    TEMPLATES = _MappingProxyType(
        {
            "country_name_ad": "Andorra",
            "country_name_br": "Brasil",
            "country_name_us": "United States",
        }
    )
    FALLBACK_KEYS = frozenset(("country_name_us",))

    @property
    def country_name_ad(self) -> str:
        return "Andorra"

    @property
    def country_name_br(self) -> str:
        return "Brasil"

    @property
    def country_name_us(self) -> str:
        return "United States"


#: The (stateless) instance returned by ``get()``.
LOCALIZATION = Backend20250115RegionsLocalizationEs419()
