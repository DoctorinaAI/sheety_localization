# This file is generated, do not edit it manually!
# ruff: noqa
"""Messages of the sheet "backend-monetization" in ru.

0 of 2 messages use a fallback text.
"""

from __future__ import annotations

from types import MappingProxyType as _MappingProxyType

from .._runtime import to_str as _to_str
from . import BackendMonetizationLocalization

__all__ = ["BackendMonetizationLocalizationRu", "LOCALIZATION"]


class BackendMonetizationLocalizationRu(BackendMonetizationLocalization):
    """backend-monetization in ru."""

    __slots__ = ()

    LOCALE = "ru"
    TEMPLATES = _MappingProxyType(
        {
            "monetization_price": "Всего {{price}} в месяц ({{avg_cost}} в среднем)",
            "monetization_title": "Поддержите {consult}",
        }
    )
    FALLBACK_KEYS = frozenset()

    def monetization_price(self, *, avg_cost: object, price: object) -> str:
        return f"Всего {_to_str(price)} в месяц ({_to_str(avg_cost)} в среднем)"

    @property
    def monetization_title(self) -> str:
        return "Поддержите {consult}"


#: The (stateless) instance returned by ``get()``.
LOCALIZATION = BackendMonetizationLocalizationRu()
