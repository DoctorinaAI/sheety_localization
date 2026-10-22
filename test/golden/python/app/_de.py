# This file is generated, do not edit it manually!
# ruff: noqa
"""Messages of the sheet "app" in de.

4 of 15 messages use a fallback text.
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
            "title": "Beispiel",
            "greeting": "Hallo, {userName}!",
            "items": "{count, plural, =0{Keine Artikel} one{Ein Artikel} other{{count} Artikel}}",
            "distance": "{km, plural, one{{km} Kilometer} other{{km} Kilometer}}",
            "pronoun": "{gender, select, male{Er hat {count} Katzen} female{Sie hat {count} Katzen} other{Sie haben {count} Katzen}}",
            "nestedPlural": "{files, plural, =0{No files} one{One file in {folders, plural, one{one folder} other{{folders} folders}}} other{{files} files in {folders, plural, one{one folder} other{{folders} folders}}}}",
            "terms": "Akzeptieren Sie die <b>Bedingungen</b> und die <a>Richtlinie</a><br/>",
            "special": "It's \"quoted\" \\ backslash $5 100% #1\nsecond line\ttab \u2028 end 👋🏽 ‮",
            "lastSeen": "Zuletzt {when}",
            "getHTTPError": "HTTP-Fehler {statusCode}",
            "type": "Typ {id}",
            "step2Title": "Schritt 2",
            "badge": "{count, plural, =0{} other{{count}}}",
            "role": "{role, select, admin{Administrator} other{User}}",
            "price": "Preis: {amount}",
        }
    )
    FALLBACK_KEYS = frozenset(("nestedPlural", "special", "badge", "role"))

    @property
    def title(self) -> str:
        return "Beispiel"

    def greeting(self, *, user_name: str) -> str:
        return f"Hallo, {_to_str(user_name)}!"

    def items(self, *, count: int) -> str:
        _c0 = _plural_case(count, _rule, ("zero", "one", "other"))
        if _c0 == "zero":
            _t0 = "Keine Artikel"
        elif _c0 == "one":
            _t0 = "Ein Artikel"
        else:
            _t0 = f"{_to_str(count)} Artikel"
        return _t0

    def distance(self, *, km: float) -> str:
        _c0 = _plural_case(km, _rule, ("one", "other"))
        if _c0 == "one":
            _t0 = f"{_to_str(km)} Kilometer"
        else:
            _t0 = f"{_to_str(km)} Kilometer"
        return _t0

    def pronoun(self, *, gender: str, count: int) -> str:
        _c0 = _select_case(gender, ("male", "female", "other"))
        if _c0 == "male":
            _t0 = f"Er hat {_to_str(count)} Katzen"
        elif _c0 == "female":
            _t0 = f"Sie hat {_to_str(count)} Katzen"
        else:
            _t0 = f"Sie haben {_to_str(count)} Katzen"
        return _t0

    def nested_plural(self, *, files: int, folders: int) -> str:
        _c0 = _plural_case(files, _rule, ("zero", "one", "other"))
        if _c0 == "zero":
            _t0 = "No files"
        elif _c0 == "one":
            _c1 = _plural_case(folders, _rule, ("one", "other"))
            if _c1 == "one":
                _t1 = "one folder"
            else:
                _t1 = f"{_to_str(folders)} folders"
            _t0 = f"One file in {_t1}"
        else:
            _c2 = _plural_case(folders, _rule, ("one", "other"))
            if _c2 == "one":
                _t2 = "one folder"
            else:
                _t2 = f"{_to_str(folders)} folders"
            _t0 = f"{_to_str(files)} files in {_t2}"
        return _t0

    @property
    def terms(self) -> str:
        return "Akzeptieren Sie die <b>Bedingungen</b> und die <a>Richtlinie</a><br/>"

    @property
    def special(self) -> str:
        return "It's \"quoted\" \\ backslash $5 100% #1\nsecond line\ttab \u2028 end 👋🏽 ‮"

    def last_seen(self, *, when: object) -> str:
        return f"Zuletzt {_to_str(when)}"

    def get_http_error(self, *, status_code: int) -> str:
        return f"HTTP-Fehler {_to_str(status_code)}"

    def type(self, *, id: str) -> str:
        return f"Typ {_to_str(id)}"

    @property
    def step2_title(self) -> str:
        return "Schritt 2"

    def badge(self, *, count: int) -> str:
        _c0 = _plural_case(count, _rule, ("zero", "other"))
        if _c0 == "zero":
            _t0 = ""
        else:
            _t0 = _to_str(count)
        return _t0

    def role(self, *, role: str) -> str:
        _c0 = _select_case(role, ("admin", "other"))
        if _c0 == "admin":
            _t0 = "Administrator"
        else:
            _t0 = "User"
        return _t0

    def price(self, *, amount: float) -> str:
        return f"Preis: {_to_str(amount)}"


#: The (stateless) instance returned by ``get()``.
LOCALIZATION = AppLocalizationDe()
