# This file is generated, do not edit it manually!
# ruff: noqa
"""Messages of the sheet "app" in ar.

2 of 6 messages use a fallback text.
"""

from __future__ import annotations

from types import MappingProxyType as _MappingProxyType

from .._runtime import cardinal_ar as _rule, plural_case as _plural_case, select_case as _select_case, to_str as _to_str
from . import AppLocalization

__all__ = ["AppLocalizationAr", "LOCALIZATION"]


class AppLocalizationAr(AppLocalization):
    """app in ar."""

    __slots__ = ()

    LOCALE = "ar"
    TEMPLATES = _MappingProxyType(
        {
            "title": "ملاحظات Sheety",
            "greeting": "مرحبا {name}!",
            "notes": "{count, plural, zero{لا ملاحظات} one{ملاحظة واحدة} two{ملاحظتان} few{{count} ملاحظات} many{{count} ملاحظة} other{{count} ملاحظة}}",
            "sharedBy": "{gender, select, male{{name} shared his note} female{{name} shared her note} other{{name} shared their note}}",
            "terms": "أوافق على <b>الشروط</b>",
            "lastSync": "Last synced {time}",
        }
    )
    FALLBACK_KEYS = frozenset(("sharedBy", "lastSync"))

    @property
    def title(self) -> str:
        return "ملاحظات Sheety"

    def greeting(self, *, name: str) -> str:
        return f"مرحبا {_to_str(name)}!"

    def notes(self, *, count: int) -> str:
        _c0 = _plural_case(count, _rule, ("zero", "one", "two", "few", "many", "other"))
        if _c0 == "zero":
            _t0 = "لا ملاحظات"
        elif _c0 == "one":
            _t0 = "ملاحظة واحدة"
        elif _c0 == "two":
            _t0 = "ملاحظتان"
        elif _c0 == "few":
            _t0 = f"{_to_str(count)} ملاحظات"
        elif _c0 == "many":
            _t0 = f"{_to_str(count)} ملاحظة"
        else:
            _t0 = f"{_to_str(count)} ملاحظة"
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
        return "أوافق على <b>الشروط</b>"

    def last_sync(self, *, time: object) -> str:
        return f"Last synced {_to_str(time)}"


#: The (stateless) instance returned by ``get()``.
LOCALIZATION = AppLocalizationAr()
