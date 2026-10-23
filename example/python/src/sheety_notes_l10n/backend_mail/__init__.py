# This file is generated, do not edit it manually!
# ruff: noqa
"""Messages of the sheet "backend-mail\".

Base locale: en. Locales: en, de, ru.
"""

from __future__ import annotations

import abc as _abc
import importlib as _importlib
import typing as _typing
from types import MappingProxyType as _MappingProxyType

from .._runtime import Localization, Message, Placeholder, negotiate_locale

__all__ = [
    "BASE_LOCALE",
    "LOCALES",
    "MESSAGES",
    "SCOPE",
    "SHEET_TITLE",
    "SYNTAX",
    "BackendMailLocalization",
    "get",
    "resolve_locale",
]

#: Scope name (sanitized sheet title).
SCOPE = "backend_mail"
#: Title of the sheet.
SHEET_TITLE = "backend-mail"
#: Message syntax of the sheet: ``icu`` or ``mustache``.
SYNTAX = "mustache"
#: Base locale (the fourth column of the sheet).
BASE_LOCALE = "en"
#: Locales, in sheet order (synthetic parents last).
LOCALES: _typing.Tuple[str, ...] = ("en", "de", "ru")


class BackendMailLocalization(Localization):
    """Messages of the sheet "backend-mail" (base locale en)."""

    __slots__ = ()

    SCOPE = "backend_mail"
    BASE_LOCALE = "en"
    MESSAGES: _typing.ClassVar[_typing.Tuple[Message, ...]] = (
        Message(
            key="welcome_subject",
            attribute="welcome_subject",
            description="Subject of the welcome e-mail",
            placeholders=(
                Placeholder(
                    name="name",
                    parameter="name",
                    type="String",
                    example="Alice",
                    description=None,
                ),
            ),
        ),
        Message(
            key="trial_ends",
            attribute="trial_ends",
            description="Single braces are plain text in mustache sheets",
            placeholders=(
                Placeholder(
                    name="days",
                    parameter="days",
                    type="int",
                    example="7",
                    description=None,
                ),
            ),
        ),
    )
    _MESSAGES_BY_KEY = _MappingProxyType({m.key: m for m in MESSAGES})

    @_abc.abstractmethod
    def welcome_subject(self, *, name: str) -> str:
        """Subject of the welcome e-mail

        Key: ``welcome_subject``.

        Arguments:
            name (String): Example: ``Alice``.

        In en: Welcome to Sheety Notes, {{name}}!
        """

    @_abc.abstractmethod
    def trial_ends(self, *, days: int) -> str:
        """Single braces are plain text in mustache sheets

        Key: ``trial_ends``.

        Arguments:
            days (int): Example: ``7``.

        In en: Your trial ends in {{days}} day(s) {see plans}
        """


#: Message metadata, in sheet order.
MESSAGES = BackendMailLocalization.MESSAGES

_INSTANCES: _typing.Dict[str, BackendMailLocalization] = {}


def resolve_locale(requested: _typing.Union[str, _typing.Sequence[str]]) -> str:
    """The best of ``LOCALES`` for a tag (``pt-BR``), a list of tags or an
    ``Accept-Language`` header; ``BASE_LOCALE`` when none matches."""
    return negotiate_locale(requested, LOCALES, BASE_LOCALE)


def get(locale: _typing.Union[str, _typing.Sequence[str]] = BASE_LOCALE) -> BackendMailLocalization:
    """The localization for ``locale`` (negotiated with :func:`resolve_locale`).

    Locale modules are imported on first use; instances are cached.
    """
    code = resolve_locale(locale)
    instance = _INSTANCES.get(code)
    if instance is None:
        module = _importlib.import_module("._" + code, __name__)
        instance = _typing.cast(BackendMailLocalization, getattr(module, "LOCALIZATION"))
        _INSTANCES[code] = instance
    return instance
