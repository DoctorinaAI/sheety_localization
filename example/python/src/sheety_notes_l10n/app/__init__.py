# This file is generated, do not edit it manually!
# ruff: noqa
"""Messages of the sheet "app\".

Base locale: en. Locales: en, de, ru, pt_BR, ar, ar_EG, pt.
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
    "AppLocalization",
    "get",
    "resolve_locale",
]

#: Scope name (sanitized sheet title).
SCOPE = "app"
#: Title of the sheet.
SHEET_TITLE = "app"
#: Message syntax of the sheet: ``icu`` or ``mustache``.
SYNTAX = "icu"
#: Base locale (the fourth column of the sheet).
BASE_LOCALE = "en"
#: Locales, in sheet order (synthetic parents last).
LOCALES: _typing.Tuple[str, ...] = ("en", "de", "ru", "pt_BR", "ar", "ar_EG", "pt")


class AppLocalization(Localization):
    """Messages of the sheet "app" (base locale en)."""

    __slots__ = ()

    SCOPE = "app"
    BASE_LOCALE = "en"
    MESSAGES: _typing.ClassVar[_typing.Tuple[Message, ...]] = (
        Message(
            key="title",
            attribute="title",
            description="Application title",
            placeholders=(),
        ),
        Message(
            key="greeting",
            attribute="greeting",
            description="Greets the user on the home screen",
            placeholders=(
                Placeholder(
                    name="name",
                    parameter="name",
                    type="String",
                    example="Alice",
                    description="First name of the user",
                ),
            ),
        ),
        Message(
            key="notes",
            attribute="notes",
            description="Number of notes in the list",
            placeholders=(
                Placeholder(
                    name="count",
                    parameter="count",
                    type="int",
                    example="3",
                    description=None,
                ),
            ),
        ),
        Message(
            key="sharedBy",
            attribute="shared_by",
            description="Who shared a note",
            placeholders=(
                Placeholder(
                    name="gender",
                    parameter="gender",
                    type="String",
                    example="female",
                    description=None,
                ),
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
            key="terms",
            attribute="terms",
            description="Inline markup is passed through as text",
            placeholders=(),
        ),
        Message(
            key="lastSync",
            attribute="last_sync",
            description="Undeclared placeholder: typed Object",
            placeholders=(
                Placeholder(
                    name="time",
                    parameter="time",
                    type="Object",
                    example=None,
                    description=None,
                ),
            ),
        ),
    )
    _MESSAGES_BY_KEY = _MappingProxyType({m.key: m for m in MESSAGES})

    @property
    @_abc.abstractmethod
    def title(self) -> str:
        """Application title

        Key: ``title``.

        In en: Sheety Notes
        """

    @_abc.abstractmethod
    def greeting(self, *, name: str) -> str:
        """Greets the user on the home screen

        Key: ``greeting``.

        Arguments:
            name (String): First name of the user. Example: ``Alice``.

        In en: Hello, {name}!
        """

    @_abc.abstractmethod
    def notes(self, *, count: int) -> str:
        """Number of notes in the list

        Key: ``notes``.

        Arguments:
            count (int): Example: ``3``.

        In en: {count, plural, =0{No notes} one{One note} other{{count} notes}}
        """

    @_abc.abstractmethod
    def shared_by(self, *, gender: str, name: str) -> str:
        """Who shared a note

        Key: ``sharedBy``.

        Arguments:
            gender (String): Example: ``female``.
            name (String): Example: ``Alice``.

        In en: {gender, select, male{{name} shared his note} female{{name} shared her note} other{{name} shared their note}}
        """

    @property
    @_abc.abstractmethod
    def terms(self) -> str:
        """Inline markup is passed through as text

        Key: ``terms``.

        In en: I accept the <b>terms</b>
        """

    @_abc.abstractmethod
    def last_sync(self, *, time: object) -> str:
        """Undeclared placeholder: typed Object

        Key: ``lastSync``.

        Arguments:
            time (Object)

        In en: Last synced {time}
        """


#: Message metadata, in sheet order.
MESSAGES = AppLocalization.MESSAGES

_INSTANCES: _typing.Dict[str, AppLocalization] = {}


def resolve_locale(requested: _typing.Union[str, _typing.Sequence[str]]) -> str:
    """The best of ``LOCALES`` for a tag (``pt-BR``), a list of tags or an
    ``Accept-Language`` header; ``BASE_LOCALE`` when none matches."""
    return negotiate_locale(requested, LOCALES, BASE_LOCALE)


def get(locale: _typing.Union[str, _typing.Sequence[str]] = BASE_LOCALE) -> AppLocalization:
    """The localization for ``locale`` (negotiated with :func:`resolve_locale`).

    Locale modules are imported on first use; instances are cached.
    """
    code = resolve_locale(locale)
    instance = _INSTANCES.get(code)
    if instance is None:
        module = _importlib.import_module("._" + code, __name__)
        instance = _typing.cast(AppLocalization, getattr(module, "LOCALIZATION"))
        _INSTANCES[code] = instance
    return instance
