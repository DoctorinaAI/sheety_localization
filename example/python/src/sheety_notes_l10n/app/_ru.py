# This file is generated, do not edit it manually!
# ruff: noqa
"""Messages of the sheet "app" in ru.

0 of 6 messages use a fallback text.
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
            "title": "Заметки Sheety",
            "greeting": "Привет, {name}!",
            "notes": "{count, plural, =0{Нет заметок} one{{count} заметка} few{{count} заметки} many{{count} заметок} other{{count} заметки}}",
            "sharedBy": "{gender, select, male{{name} поделился заметкой} female{{name} поделилась заметкой} other{{name} поделились заметкой}}",
            "terms": "Я принимаю <b>условия</b>",
            "lastSync": "Синхронизировано {time}",
        }
    )
    FALLBACK_KEYS = frozenset()

    @property
    def title(self) -> str:
        return "Заметки Sheety"

    def greeting(self, *, name: str) -> str:
        return f"Привет, {_to_str(name)}!"

    def notes(self, *, count: int) -> str:
        _c0 = _plural_case(count, _rule, ("zero", "one", "few", "many", "other"))
        if _c0 == "zero":
            _t0 = "Нет заметок"
        elif _c0 == "one":
            _t0 = f"{_to_str(count)} заметка"
        elif _c0 == "few":
            _t0 = f"{_to_str(count)} заметки"
        elif _c0 == "many":
            _t0 = f"{_to_str(count)} заметок"
        else:
            _t0 = f"{_to_str(count)} заметки"
        return _t0

    def shared_by(self, *, gender: str, name: str) -> str:
        _c0 = _select_case(gender, ("male", "female", "other"))
        if _c0 == "male":
            _t0 = f"{_to_str(name)} поделился заметкой"
        elif _c0 == "female":
            _t0 = f"{_to_str(name)} поделилась заметкой"
        else:
            _t0 = f"{_to_str(name)} поделились заметкой"
        return _t0

    @property
    def terms(self) -> str:
        return "Я принимаю <b>условия</b>"

    def last_sync(self, *, time: object) -> str:
        return f"Синхронизировано {_to_str(time)}"


#: The (stateless) instance returned by ``get()``.
LOCALIZATION = AppLocalizationRu()
