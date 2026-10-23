# This file is generated, do not edit it manually!
# ruff: noqa
"""Messages of the sheet "backend-mail" in de.

0 of 2 messages use a fallback text.
"""

from __future__ import annotations

from types import MappingProxyType as _MappingProxyType

from .._runtime import to_str as _to_str
from . import BackendMailLocalization

__all__ = ["BackendMailLocalizationDe", "LOCALIZATION"]


class BackendMailLocalizationDe(BackendMailLocalization):
    """backend-mail in de."""

    __slots__ = ()

    LOCALE = "de"
    TEMPLATES = _MappingProxyType(
        {
            "welcome_subject": "Willkommen bei Sheety Notes, {{name}}!",
            "trial_ends": "Ihre Testphase endet in {{days}} Tag(en) {siehe Tarife}",
        }
    )
    FALLBACK_KEYS = frozenset()

    def welcome_subject(self, *, name: str) -> str:
        return f"Willkommen bei Sheety Notes, {_to_str(name)}!"

    def trial_ends(self, *, days: int) -> str:
        return f"Ihre Testphase endet in {_to_str(days)} Tag(en) {{siehe Tarife}}"


#: The (stateless) instance returned by ``get()``.
LOCALIZATION = BackendMailLocalizationDe()
