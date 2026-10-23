# This file is generated, do not edit it manually!
# ruff: noqa
"""Messages of the sheet "backend-mail" in ru.

0 of 2 messages use a fallback text.
"""

from __future__ import annotations

from types import MappingProxyType as _MappingProxyType

from .._runtime import to_str as _to_str
from . import BackendMailLocalization

__all__ = ["BackendMailLocalizationRu", "LOCALIZATION"]


class BackendMailLocalizationRu(BackendMailLocalization):
    """backend-mail in ru."""

    __slots__ = ()

    LOCALE = "ru"
    TEMPLATES = _MappingProxyType(
        {
            "welcome_subject": "Добро пожаловать в Sheety Notes, {{ name }}!",
            "trial_ends": "Пробный период закончится через {{days}} дн. {см. тарифы}",
        }
    )
    FALLBACK_KEYS = frozenset()

    def welcome_subject(self, *, name: str) -> str:
        return f"Добро пожаловать в Sheety Notes, {_to_str(name)}!"

    def trial_ends(self, *, days: int) -> str:
        return f"Пробный период закончится через {_to_str(days)} дн. {{см. тарифы}}"


#: The (stateless) instance returned by ``get()``.
LOCALIZATION = BackendMailLocalizationRu()
