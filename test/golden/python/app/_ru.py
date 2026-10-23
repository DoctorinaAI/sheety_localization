# This file is generated, do not edit it manually!
# ruff: noqa
"""Messages of the sheet "app" in ru.

1 of 15 messages use a fallback text.
"""

from __future__ import annotations

from types import MappingProxyType as _MappingProxyType

from .._runtime import cardinal_ru as _rule, plural_case as _plural_case, select_case as _select_case, to_str as _to_str
from . import AppLocalization

__all__ = ["AppLocalizationRu", "LOCALIZATION"]


class AppLocalizationRu(AppLocalization):
    """app in ru."""

    __slots__ = ()

    LOCALE = "ru"
    TEMPLATES = _MappingProxyType(
        {
            "title": "Пример",
            "greeting": "Привет, {userName}!",
            "items": "{count, plural, =0{Нет товаров} one{{count} товар} few{{count} товара} many{{count} товаров} other{{count} товара}}",
            "distance": "{km, plural, one{{km} километр} few{{km} километра} many{{km} километров} other{{km} километра}}",
            "pronoun": "{gender, select, male{У него {count, plural, one{{count} кошка} few{{count} кошки} other{{count} кошек}}} other{У них {count, plural, one{{count} кошка} few{{count} кошки} other{{count} кошек}}}}",
            "nestedPlural": "{files, plural, =0{No files} one{One file in {folders, plural, one{one folder} other{{folders} folders}}} other{{files} files in {folders, plural, one{one folder} other{{folders} folders}}}}",
            "terms": "Примите <b>условия</b> и <a>политику</a><br/>",
            "special": "Это \"цитата\" — 'апостроф' \\ $5 #",
            "lastSeen": "Был(а) {when}",
            "getHTTPError": "Ошибка HTTP {statusCode}",
            "type": "Тип {id}",
            "step2Title": "Шаг 2",
            "badge": "{count, plural, =0{} other{{count}}}",
            "role": "{role, select, admin{Администратор} other{Пользователь}}",
            "price": "Цена: {amount}",
        }
    )
    FALLBACK_KEYS = frozenset(("nestedPlural",))

    @property
    def title(self) -> str:
        return "Пример"

    def greeting(self, *, user_name: str) -> str:
        return f"Привет, {_to_str(user_name)}!"

    def items(self, *, count: int) -> str:
        _c0 = _plural_case(count, _rule, ("zero", "one", "few", "many", "other"))
        if _c0 == "zero":
            _t0 = "Нет товаров"
        elif _c0 == "one":
            _t0 = f"{_to_str(count)} товар"
        elif _c0 == "few":
            _t0 = f"{_to_str(count)} товара"
        elif _c0 == "many":
            _t0 = f"{_to_str(count)} товаров"
        else:
            _t0 = f"{_to_str(count)} товара"
        return _t0

    def distance(self, *, km: float) -> str:
        _c0 = _plural_case(km, _rule, ("one", "few", "many", "other"))
        if _c0 == "one":
            _t0 = f"{_to_str(km)} километр"
        elif _c0 == "few":
            _t0 = f"{_to_str(km)} километра"
        elif _c0 == "many":
            _t0 = f"{_to_str(km)} километров"
        else:
            _t0 = f"{_to_str(km)} километра"
        return _t0

    def pronoun(self, *, gender: str, count: int) -> str:
        _c0 = _select_case(gender, ("male", "other"))
        if _c0 == "male":
            _c1 = _plural_case(count, _rule, ("one", "few", "other"))
            if _c1 == "one":
                _t1 = f"{_to_str(count)} кошка"
            elif _c1 == "few":
                _t1 = f"{_to_str(count)} кошки"
            else:
                _t1 = f"{_to_str(count)} кошек"
            _t0 = f"У него {_t1}"
        else:
            _c2 = _plural_case(count, _rule, ("one", "few", "other"))
            if _c2 == "one":
                _t2 = f"{_to_str(count)} кошка"
            elif _c2 == "few":
                _t2 = f"{_to_str(count)} кошки"
            else:
                _t2 = f"{_to_str(count)} кошек"
            _t0 = f"У них {_t2}"
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
        return "Примите <b>условия</b> и <a>политику</a><br/>"

    @property
    def special(self) -> str:
        return "Это \"цитата\" — 'апостроф' \\ $5 #"

    def last_seen(self, *, when: object) -> str:
        return f"Был(а) {_to_str(when)}"

    def get_http_error(self, *, status_code: int) -> str:
        return f"Ошибка HTTP {_to_str(status_code)}"

    def type(self, *, id: str) -> str:
        return f"Тип {_to_str(id)}"

    @property
    def step2_title(self) -> str:
        return "Шаг 2"

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
            _t0 = "Администратор"
        else:
            _t0 = "Пользователь"
        return _t0

    def price(self, *, amount: float) -> str:
        return f"Цена: {_to_str(amount)}"


#: The (stateless) instance returned by ``get()``.
LOCALIZATION = AppLocalizationRu()
