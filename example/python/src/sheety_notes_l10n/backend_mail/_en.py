# This file is generated, do not edit it manually!
# ruff: noqa
"""Messages of the sheet "backend-mail" in en.

0 of 2 messages use a fallback text.
"""

from __future__ import annotations

from types import MappingProxyType as _MappingProxyType

from .._runtime import to_str as _to_str
from . import BackendMailLocalization

__all__ = ["BackendMailLocalizationEn", "LOCALIZATION"]


class BackendMailLocalizationEn(BackendMailLocalization):
    """backend-mail in en."""

    __slots__ = ()

    LOCALE = "en"
    TEMPLATES = _MappingProxyType(
        {
            "welcome_subject": "Welcome to Sheety Notes, {{name}}!",
            "trial_ends": "Your trial ends in {{days}} day(s) {see plans}",
        }
    )
    FALLBACK_KEYS = frozenset()

    def welcome_subject(self, *, name: str) -> str:
        return f"Welcome to Sheety Notes, {_to_str(name)}!"

    def trial_ends(self, *, days: int) -> str:
        return f"Your trial ends in {_to_str(days)} day(s) {{see plans}}"


#: The (stateless) instance returned by ``get()``.
LOCALIZATION = BackendMailLocalizationEn()
