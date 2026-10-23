# This file is generated, do not edit it manually!
# ruff: noqa
"""Messages of the sheet "app" in pt (no column of its own, copied from pt_BR).

0 of 6 messages use a fallback text.
"""

from __future__ import annotations

from types import MappingProxyType as _MappingProxyType

from .._runtime import cardinal_pt as _rule, plural_case as _plural_case, select_case as _select_case, to_str as _to_str
from . import AppLocalization

__all__ = ["AppLocalizationPt", "LOCALIZATION"]


class AppLocalizationPt(AppLocalization):
    """app in pt."""

    __slots__ = ()

    LOCALE = "pt"
    TEMPLATES = _MappingProxyType(
        {
            "title": "Notas Sheety",
            "greeting": "Olá, {name}!",
            "notes": "{count, plural, =0{Nenhuma nota} one{Uma nota} many{{count} de notas} other{{count} notas}}",
            "sharedBy": "{gender, select, male{{name} compartilhou a nota dele} female{{name} compartilhou a nota dela} other{{name} compartilhou uma nota}}",
            "terms": "Aceito os <b>termos</b>",
            "lastSync": "Sincronizado {time}",
        }
    )
    FALLBACK_KEYS = frozenset()

    @property
    def title(self) -> str:
        return "Notas Sheety"

    def greeting(self, *, name: str) -> str:
        return f"Olá, {_to_str(name)}!"

    def notes(self, *, count: int) -> str:
        _c0 = _plural_case(count, _rule, ("zero", "one", "many", "other"))
        if _c0 == "zero":
            _t0 = "Nenhuma nota"
        elif _c0 == "one":
            _t0 = "Uma nota"
        elif _c0 == "many":
            _t0 = f"{_to_str(count)} de notas"
        else:
            _t0 = f"{_to_str(count)} notas"
        return _t0

    def shared_by(self, *, gender: str, name: str) -> str:
        _c0 = _select_case(gender, ("male", "female", "other"))
        if _c0 == "male":
            _t0 = f"{_to_str(name)} compartilhou a nota dele"
        elif _c0 == "female":
            _t0 = f"{_to_str(name)} compartilhou a nota dela"
        else:
            _t0 = f"{_to_str(name)} compartilhou uma nota"
        return _t0

    @property
    def terms(self) -> str:
        return "Aceito os <b>termos</b>"

    def last_sync(self, *, time: object) -> str:
        return f"Sincronizado {_to_str(time)}"


#: The (stateless) instance returned by ``get()``.
LOCALIZATION = AppLocalizationPt()
