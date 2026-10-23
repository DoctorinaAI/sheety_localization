# This file is generated, do not edit it manually!
# ruff: noqa
"""Messages of the sheet "backend-2025-01-15-regions" in pt_BR.

2 of 3 messages use a fallback text.
"""

from __future__ import annotations

from types import MappingProxyType as _MappingProxyType

from . import Backend20250115RegionsLocalization

__all__ = ["Backend20250115RegionsLocalizationPtBr", "LOCALIZATION"]


class Backend20250115RegionsLocalizationPtBr(Backend20250115RegionsLocalization):
    """backend-2025-01-15-regions in pt_BR."""

    __slots__ = ()

    LOCALE = "pt_BR"
    TEMPLATES = _MappingProxyType(
        {
            "country_name_ad": "Andorra",
            "country_name_br": "Brasil",
            "country_name_us": "Estados Unidos",
        }
    )
    FALLBACK_KEYS = frozenset(("country_name_br", "country_name_us"))

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
LOCALIZATION = Backend20250115RegionsLocalizationPtBr()
