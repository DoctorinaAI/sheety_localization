# This file is generated, do not edit it manually!
# ruff: noqa
"""Messages of the sheet "app" in de.

0 of 6 messages use a fallback text.
"""

from __future__ import annotations

from types import MappingProxyType as _MappingProxyType

from .._runtime import cardinal_de as _rule, plural_case as _plural_case, select_case as _select_case, to_str as _to_str
from . import AppLocalization

__all__ = ["AppLocalizationDe", "LOCALIZATION"]


class AppLocalizationDe(AppLocalization):
    """app in de."""

    __slots__ = ()

    LOCALE = "de"
    TEMPLATES = _MappingProxyType(
        {
            "title": "Sheety Notizen",
            "greeting": "Hallo, {name}!",
            "notes": "{count, plural, =0{Keine Notizen} one{Eine Notiz} other{{count} Notizen}}",
            "sharedBy": "{gender, select, male{{name} hat seine Notiz geteilt} female{{name} hat ihre Notiz geteilt} other{{name} hat eine Notiz geteilt}}",
            "terms": "Ich akzeptiere die <b>Bedingungen</b>",
            "lastSync": "Zuletzt synchronisiert {time}",
        }
    )
    FALLBACK_KEYS = frozenset()

    @property
    def title(self) -> str:
        return "Sheety Notizen"

    def greeting(self, *, name: str) -> str:
        return f"Hallo, {_to_str(name)}!"

    def notes(self, *, count: int) -> str:
        _c0 = _plural_case(count, _rule, ("zero", "one", "other"))
        if _c0 == "zero":
            _t0 = "Keine Notizen"
        elif _c0 == "one":
            _t0 = "Eine Notiz"
        else:
            _t0 = f"{_to_str(count)} Notizen"
        return _t0

    def shared_by(self, *, gender: str, name: str) -> str:
        _c0 = _select_case(gender, ("male", "female", "other"))
        if _c0 == "male":
            _t0 = f"{_to_str(name)} hat seine Notiz geteilt"
        elif _c0 == "female":
            _t0 = f"{_to_str(name)} hat ihre Notiz geteilt"
        else:
            _t0 = f"{_to_str(name)} hat eine Notiz geteilt"
        return _t0

    @property
    def terms(self) -> str:
        return "Ich akzeptiere die <b>Bedingungen</b>"

    def last_sync(self, *, time: object) -> str:
        return f"Zuletzt synchronisiert {_to_str(time)}"


#: The (stateless) instance returned by ``get()``.
LOCALIZATION = AppLocalizationDe()
