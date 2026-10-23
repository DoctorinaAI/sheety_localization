# This file is generated, do not edit it manually!
# ruff: noqa
"""Messages of the sheet "backend-billing" in ru.

0 of 2 messages use a fallback text.
"""

from __future__ import annotations

from types import MappingProxyType as _MappingProxyType

from .._runtime import to_str as _to_str
from . import BackendBillingLocalization

__all__ = ["BackendBillingLocalizationRu", "LOCALIZATION"]


class BackendBillingLocalizationRu(BackendBillingLocalization):
    """backend-billing in ru."""

    __slots__ = ()

    LOCALE = "ru"
    TEMPLATES = _MappingProxyType(
        {
            "billing_price": "Всего {{price}} в месяц ({{unit_price}} за место)",
            "billing_title": "Напишите {team}",
        }
    )
    FALLBACK_KEYS = frozenset()

    def billing_price(self, *, price: object, unit_price: object) -> str:
        return f"Всего {_to_str(price)} в месяц ({_to_str(unit_price)} за место)"

    @property
    def billing_title(self) -> str:
        return "Напишите {team}"


#: The (stateless) instance returned by ``get()``.
LOCALIZATION = BackendBillingLocalizationRu()
