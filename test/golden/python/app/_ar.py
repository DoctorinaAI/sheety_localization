# This file is generated, do not edit it manually!
# ruff: noqa
"""Messages of the sheet "app" in ar.

12 of 15 messages use a fallback text.
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
            "title": "مثال",
            "greeting": "مرحبا {userName}",
            "items": "{count, plural, zero{لا عناصر} one{عنصر واحد} two{عنصران} few{{count} عناصر} many{{count} عنصرًا} other{{count} عنصر}}",
            "distance": "{km, plural, one{{km} kilometer} other{{km} kilometers}}",
            "pronoun": "{gender, select, male{He has {count, plural, =1{one cat} other{{count} cats}}} female{She has {count, plural, =1{one cat} other{{count} cats}}} other{They have {count, plural, =1{one cat} other{{count} cats}}}}",
            "nestedPlural": "{files, plural, =0{No files} one{One file in {folders, plural, one{one folder} other{{folders} folders}}} other{{files} files in {folders, plural, one{one folder} other{{folders} folders}}}}",
            "terms": "Accept the <b>terms</b> and the <a>policy</a><br/>",
            "special": "It's \"quoted\" \\ backslash $5 100% #1\nsecond line\ttab \u2028 end 👋🏽 ‮",
            "lastSeen": "Last seen {when}",
            "getHTTPError": "HTTP error {statusCode}",
            "type": "Type {id}",
            "step2Title": "Step 2",
            "badge": "{count, plural, =0{} other{{count}}}",
            "role": "{role, select, admin{Administrator} other{User}}",
            "price": "Price: {amount}",
        }
    )
    FALLBACK_KEYS = frozenset(("distance", "pronoun", "nestedPlural", "terms", "special", "lastSeen", "getHTTPError", "type", "step2Title", "badge", "role", "price"))

    @property
    def title(self) -> str:
        return "مثال"

    def greeting(self, *, user_name: str) -> str:
        return f"مرحبا {_to_str(user_name)}"

    def items(self, *, count: int) -> str:
        _c0 = _plural_case(count, _rule, ("zero", "one", "two", "few", "many", "other"))
        if _c0 == "zero":
            _t0 = "لا عناصر"
        elif _c0 == "one":
            _t0 = "عنصر واحد"
        elif _c0 == "two":
            _t0 = "عنصران"
        elif _c0 == "few":
            _t0 = f"{_to_str(count)} عناصر"
        elif _c0 == "many":
            _t0 = f"{_to_str(count)} عنصرًا"
        else:
            _t0 = f"{_to_str(count)} عنصر"
        return _t0

    def distance(self, *, km: float) -> str:
        _c0 = _plural_case(km, _rule, ("one", "other"))
        if _c0 == "one":
            _t0 = f"{_to_str(km)} kilometer"
        else:
            _t0 = f"{_to_str(km)} kilometers"
        return _t0

    def pronoun(self, *, gender: str, count: int) -> str:
        _c0 = _select_case(gender, ("male", "female", "other"))
        if _c0 == "male":
            _c1 = _plural_case(count, _rule, ("one", "other"))
            if _c1 == "one":
                _t1 = "one cat"
            else:
                _t1 = f"{_to_str(count)} cats"
            _t0 = f"He has {_t1}"
        elif _c0 == "female":
            _c2 = _plural_case(count, _rule, ("one", "other"))
            if _c2 == "one":
                _t2 = "one cat"
            else:
                _t2 = f"{_to_str(count)} cats"
            _t0 = f"She has {_t2}"
        else:
            _c3 = _plural_case(count, _rule, ("one", "other"))
            if _c3 == "one":
                _t3 = "one cat"
            else:
                _t3 = f"{_to_str(count)} cats"
            _t0 = f"They have {_t3}"
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
        return "Accept the <b>terms</b> and the <a>policy</a><br/>"

    @property
    def special(self) -> str:
        return "It's \"quoted\" \\ backslash $5 100% #1\nsecond line\ttab \u2028 end 👋🏽 ‮"

    def last_seen(self, *, when: object) -> str:
        return f"Last seen {_to_str(when)}"

    def get_http_error(self, *, status_code: int) -> str:
        return f"HTTP error {_to_str(status_code)}"

    def type(self, *, id: str) -> str:
        return f"Type {_to_str(id)}"

    @property
    def step2_title(self) -> str:
        return "Step 2"

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
        return f"Price: {_to_str(amount)}"


#: The (stateless) instance returned by ``get()``.
LOCALIZATION = AppLocalizationAr()
