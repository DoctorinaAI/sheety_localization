# This file is generated, do not edit it manually!
# ruff: noqa
"""Messages of the sheet "app" in en.

0 of 6 messages use a fallback text.
"""

from __future__ import annotations

from types import MappingProxyType as _MappingProxyType

from .._runtime import cardinal_en as _rule, plural_case as _plural_case, select_case as _select_case, to_str as _to_str
from . import AppLocalization

__all__ = ["AppLocalizationEn", "LOCALIZATION"]


class AppLocalizationEn(AppLocalization):
    """app in en."""

    __slots__ = ()

    LOCALE = "en"
    TEMPLATES = _MappingProxyType(
        {
            "title": "Sheety Notes",
            "greeting": "Hello, {name}!",
            "notes": "{count, plural, =0{No notes} one{One note} other{{count} notes}}",
            "sharedBy": "{gender, select, male{{name} shared his note} female{{name} shared her note} other{{name} shared their note}}",
            "terms": "I accept the <b>terms</b>",
            "lastSync": "Last synced {time}",
        }
    )
    FALLBACK_KEYS = frozenset()

    @property
    def title(self) -> str:
        return "Sheety Notes"

    def greeting(self, *, name: str) -> str:
        return f"Hello, {_to_str(name)}!"

    def notes(self, *, count: int) -> str:
        _c0 = _plural_case(count, _rule, ("zero", "one", "other"))
        if _c0 == "zero":
            _t0 = "No notes"
        elif _c0 == "one":
            _t0 = "One note"
        else:
            _t0 = f"{_to_str(count)} notes"
        return _t0

    def shared_by(self, *, gender: str, name: str) -> str:
        _c0 = _select_case(gender, ("male", "female", "other"))
        if _c0 == "male":
            _t0 = f"{_to_str(name)} shared his note"
        elif _c0 == "female":
            _t0 = f"{_to_str(name)} shared her note"
        else:
            _t0 = f"{_to_str(name)} shared their note"
        return _t0

    @property
    def terms(self) -> str:
        return "I accept the <b>terms</b>"

    def last_sync(self, *, time: object) -> str:
        return f"Last synced {_to_str(time)}"


#: The (stateless) instance returned by ``get()``.
LOCALIZATION = AppLocalizationEn()
