# This file is generated, do not edit it manually!
# ruff: noqa
"""Generated localization package.

Scopes (one sub-package per sheet): app, backend_mail.

Use a scope directly (``from .app import get``) or by name
(``get("app", "pt-BR")``).
"""

from __future__ import annotations

import typing as _typing

from ._runtime import (
    CLDR_VERSION,
    Localization,
    Message,
    Placeholder,
    negotiate_locale,
    parse_accept_language,
    plural_category,
    sanitize_key as _sanitize_key,
)
from . import app
from . import backend_mail
from .app import AppLocalization
from .backend_mail import BackendMailLocalization

__all__ = [
    "AppLocalization",
    "BASE_LOCALE",
    "BackendMailLocalization",
    "CLDR_VERSION",
    "Localization",
    "Message",
    "Placeholder",
    "SCOPES",
    "SUPPORTED_LOCALES",
    "app",
    "backend_mail",
    "get",
    "negotiate_locale",
    "parse_accept_language",
    "plural_category",
    "resolve_locale",
]

#: Every scope (sheet), in sheet order.
SCOPES: _typing.Tuple[str, ...] = ("app", "backend_mail")
#: Every locale of any scope, in order of first appearance.
SUPPORTED_LOCALES: _typing.Tuple[str, ...] = ("en", "de", "ru", "pt_BR", "ar", "ar_EG", "pt")
#: The base locale shared by the scopes (that of the first scope if they differ).
BASE_LOCALE = "en"

_GETTERS: _typing.Mapping[
    str, _typing.Callable[[_typing.Union[str, _typing.Sequence[str]]], Localization]
] = {
    "app": app.get,
    "backend_mail": backend_mail.get,
}


def resolve_locale(requested: _typing.Union[str, _typing.Sequence[str]]) -> str:
    """The best of ``SUPPORTED_LOCALES`` for a tag, a list of tags or an
    ``Accept-Language`` header; ``BASE_LOCALE`` when none matches."""
    return negotiate_locale(requested, SUPPORTED_LOCALES, BASE_LOCALE)


def get(
    scope: str, locale: _typing.Union[str, _typing.Sequence[str]] = BASE_LOCALE
) -> Localization:
    """The localization of ``scope`` (name or sheet title) for ``locale``
    (negotiated within the scope's own locales)."""
    getter = _GETTERS.get(scope) or _GETTERS.get(_sanitize_key(scope))
    if getter is None:
        raise KeyError(f"Unknown localization scope {scope!r}")
    return getter(locale)
