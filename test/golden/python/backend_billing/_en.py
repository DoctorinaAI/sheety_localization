# This file is generated, do not edit it manually!
# ruff: noqa
"""Messages of the sheet "backend-billing" in en.

0 of 2 messages use a fallback text.
"""

from __future__ import annotations

from types import MappingProxyType as _MappingProxyType

from .._runtime import to_str as _to_str
from . import BackendBillingLocalization

__all__ = ["BackendBillingLocalizationEn", "LOCALIZATION"]


class BackendBillingLocalizationEn(BackendBillingLocalization):
    """backend-billing in en."""

    __slots__ = ()

    LOCALE = "en"
    TEMPLATES = _MappingProxyType(
        {
            "billing_price": "Only {{price}} per month ({{ unit_price }} per seat)",
            "billing_title": "Contact {team}",
        }
    )
    FALLBACK_KEYS = frozenset()

    def billing_price(self, *, price: object, unit_price: object) -> str:
        return f"Only {_to_str(price)} per month ({_to_str(unit_price)} per seat)"

    @property
    def billing_title(self) -> str:
        return "Contact {team}"


#: The (stateless) instance returned by ``get()``.
LOCALIZATION = BackendBillingLocalizationEn()
