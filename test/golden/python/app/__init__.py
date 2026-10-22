# This file is generated, do not edit it manually!
# ruff: noqa
"""Messages of the sheet "app\".

Base locale: en. Locales: en, ru, pt_BR, ar, sl, he, de, ja, pt.
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
LOCALES: _typing.Tuple[str, ...] = ("en", "ru", "pt_BR", "ar", "sl", "he", "de", "ja", "pt")


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
            description="Greets the user",
            placeholders=(
                Placeholder(
                    name="userName",
                    parameter="user_name",
                    type="String",
                    example="Bob",
                    description="User name",
                ),
            ),
        ),
        Message(
            key="items",
            attribute="items",
            description="Number of items in the cart",
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
            key="distance",
            attribute="distance",
            description="Fractional plural count",
            placeholders=(
                Placeholder(
                    name="km",
                    parameter="km",
                    type="num",
                    example="1.5",
                    description=None,
                ),
            ),
        ),
        Message(
            key="pronoun",
            attribute="pronoun",
            description="Select with a nested plural",
            placeholders=(
                Placeholder(
                    name="gender",
                    parameter="gender",
                    type="String",
                    example="female",
                    description=None,
                ),
                Placeholder(
                    name="count",
                    parameter="count",
                    type="int",
                    example="2",
                    description=None,
                ),
            ),
        ),
        Message(
            key="nestedPlural",
            attribute="nested_plural",
            description="Plural inside a plural",
            placeholders=(
                Placeholder(
                    name="files",
                    parameter="files",
                    type="int",
                    example="2",
                    description=None,
                ),
                Placeholder(
                    name="folders",
                    parameter="folders",
                    type="int",
                    example="1",
                    description=None,
                ),
            ),
        ),
        Message(
            key="terms",
            attribute="terms",
            description="Inline markup",
            placeholders=(),
        ),
        Message(
            key="special",
            attribute="special",
            description="Characters that need escaping: \"quotes\", \\ and\nnewlines",
            placeholders=(),
        ),
        Message(
            key="lastSeen",
            attribute="last_seen",
            description="Undeclared placeholder (typed Object)",
            placeholders=(
                Placeholder(
                    name="when",
                    parameter="when",
                    type="Object",
                    example=None,
                    description=None,
                ),
            ),
        ),
        Message(
            key="getHTTPError",
            attribute="get_http_error",
            description="Acronym in the key",
            placeholders=(
                Placeholder(
                    name="statusCode",
                    parameter="status_code",
                    type="int",
                    example="404",
                    description=None,
                ),
            ),
        ),
        Message(
            key="type",
            attribute="type",
            description="Key and placeholder shadowing Python builtins",
            placeholders=(
                Placeholder(
                    name="id",
                    parameter="id",
                    type="String",
                    example="a1",
                    description=None,
                ),
            ),
        ),
        Message(
            key="step2Title",
            attribute="step2_title",
            description=None,
            placeholders=(),
        ),
        Message(
            key="badge",
            attribute="badge",
            description="Empty plural branch",
            placeholders=(
                Placeholder(
                    name="count",
                    parameter="count",
                    type="int",
                    example="0",
                    description=None,
                ),
            ),
        ),
        Message(
            key="role",
            attribute="role",
            description="Inferred select (String)",
            placeholders=(
                Placeholder(
                    name="role",
                    parameter="role",
                    type="String",
                    example=None,
                    description=None,
                ),
            ),
        ),
        Message(
            key="price",
            attribute="price",
            description="Double placeholder",
            placeholders=(
                Placeholder(
                    name="amount",
                    parameter="amount",
                    type="double",
                    example="9.99",
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

        In en: Example
        """

    @_abc.abstractmethod
    def greeting(self, *, user_name: str) -> str:
        """Greets the user

        Key: ``greeting``.

        Arguments:
            user_name (String, {userName}): User name. Example: ``Bob``.

        In en: Hello, {userName}!
        """

    @_abc.abstractmethod
    def items(self, *, count: int) -> str:
        """Number of items in the cart

        Key: ``items``.

        Arguments:
            count (int): Example: ``3``.

        In en: {count, plural, =0{No items} =1{One item} other{{count} items}}
        """

    @_abc.abstractmethod
    def distance(self, *, km: float) -> str:
        """Fractional plural count

        Key: ``distance``.

        Arguments:
            km (num): Example: ``1.5``.

        In en: {km, plural, one{{km} kilometer} other{{km} kilometers}}
        """

    @_abc.abstractmethod
    def pronoun(self, *, gender: str, count: int) -> str:
        """Select with a nested plural

        Key: ``pronoun``.

        Arguments:
            gender (String): Example: ``female``.
            count (int): Example: ``2``.

        In en: {gender, select, male{He has {count, plural, =1{one cat} other{{count} cats}}} female{She has {count, plural, =1{one cat} other{{count} cats}}} other{They have {count, plural, =1{one cat} other{{count} cats}}}}
        """

    @_abc.abstractmethod
    def nested_plural(self, *, files: int, folders: int) -> str:
        """Plural inside a plural

        Key: ``nestedPlural``.

        Arguments:
            files (int): Example: ``2``.
            folders (int): Example: ``1``.

        In en: {files, plural, =0{No files} one{One file in {folders, plural, one{one folder} other{{folders} folders}}} other{{files} files in {folders, plural, one{one folder} other{{folders} folders}}}}
        """

    @property
    @_abc.abstractmethod
    def terms(self) -> str:
        """Inline markup

        Key: ``terms``.

        In en: Accept the <b>terms</b> and the <a>policy</a><br/>
        """

    @property
    @_abc.abstractmethod
    def special(self) -> str:
        """Characters that need escaping: "quotes", \\ and
        newlines

        Key: ``special``.

        In en: It's "quoted" \\ backslash $5 100% #1
        second line\ttab \u2028 end 👋🏽 ‮
        """

    @_abc.abstractmethod
    def last_seen(self, *, when: object) -> str:
        """Undeclared placeholder (typed Object)

        Key: ``lastSeen``.

        Arguments:
            when (Object)

        In en: Last seen {when}
        """

    @_abc.abstractmethod
    def get_http_error(self, *, status_code: int) -> str:
        """Acronym in the key

        Key: ``getHTTPError``.

        Arguments:
            status_code (int, {statusCode}): Example: ``404``.

        In en: HTTP error {statusCode}
        """

    @_abc.abstractmethod
    def type(self, *, id: str) -> str:
        """Key and placeholder shadowing Python builtins

        Key: ``type``.

        Arguments:
            id (String): Example: ``a1``.

        In en: Type {id}
        """

    @property
    @_abc.abstractmethod
    def step2_title(self) -> str:
        """``step2Title``

        In en: Step 2
        """

    @_abc.abstractmethod
    def badge(self, *, count: int) -> str:
        """Empty plural branch

        Key: ``badge``.

        Arguments:
            count (int): Example: ``0``.

        In en: {count, plural, =0{} other{{count}}}
        """

    @_abc.abstractmethod
    def role(self, *, role: str) -> str:
        """Inferred select (String)

        Key: ``role``.

        Arguments:
            role (String)

        In en: {role, select, admin{Administrator} other{User}}
        """

    @_abc.abstractmethod
    def price(self, *, amount: float) -> str:
        """Double placeholder

        Key: ``price``.

        Arguments:
            amount (double): Example: ``9.99``.

        In en: Price: {amount}
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
