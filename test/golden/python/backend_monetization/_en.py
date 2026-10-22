# This file is generated, do not edit it manually!
# ruff: noqa
"""Messages of the sheet "backend-monetization" in en.

0 of 2 messages use a fallback text.
"""

from __future__ import annotations

from types import MappingProxyType as _MappingProxyType

from .._runtime import to_str as _to_str
from . import BackendMonetizationLocalization

__all__ = ["BackendMonetizationLocalizationEn", "LOCALIZATION"]


class BackendMonetizationLocalizationEn(BackendMonetizationLocalization):
    """backend-monetization in en."""

    __slots__ = ()

    LOCALE = "en"
    TEMPLATES = _MappingProxyType(
        {
            "monetization_price": "Only {{price}} per month ({{ avg_cost }} on average)",
            "monetization_title": "Support {consult}",
        }
    )
    FALLBACK_KEYS = frozenset()

    def monetization_price(self, *, avg_cost: object, price: object) -> str:
        return f"Only {_to_str(price)} per month ({_to_str(avg_cost)} on average)"

    @property
    def monetization_title(self) -> str:
        return "Support {consult}"


#: The (stateless) instance returned by ``get()``.
LOCALIZATION = BackendMonetizationLocalizationEn()
