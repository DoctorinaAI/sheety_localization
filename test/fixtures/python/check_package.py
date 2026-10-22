"""Exercises a generated localization package and dumps what it renders.

Usage: python3 -I check_package.py <sys.path root> <package> <cases.json> <out.json>

Imports the package the way a backend does (as a sub-package of another
package), renders every case through the dynamic ``format()`` and the typed
API (they must agree), checks the metadata, the error behaviour and the
runtime helpers, and writes the results as JSON for the Dart side to compare
with its reference rendering.
"""

import importlib
import json
import pickle
import sys


def main() -> None:
    root, package, cases_path, out_path = sys.argv[1:5]
    sys.path.insert(0, root)
    pkg = importlib.import_module(package)
    runtime = importlib.import_module(package + "._runtime")
    with open(cases_path, encoding="utf-8") as f:
        cases = json.load(f)

    rendered = []
    for scope, locale, key, args in cases["render"]:
        loc = pkg.get(scope, locale)
        assert loc.LOCALE == locale, (scope, locale, loc.LOCALE)
        text = loc.format(key, **args)
        message = {m.key: m for m in loc.MESSAGES}[key]
        member = getattr(loc, message.attribute)
        if message.placeholders:
            typed = member(**{p.parameter: args[p.name] for p in message.placeholders})
        else:
            typed = member
        assert typed == text, (scope, locale, key, typed, text)
        rendered.append(text)

    meta = {}
    for scope_name in pkg.SCOPES:
        scope = importlib.import_module(package + "." + scope_name)
        base_class = getattr(scope, [n for n in scope.__all__ if n.endswith("Localization")][0])
        keys = [m.key for m in scope.MESSAGES]
        assert len(set(keys)) == len(keys), scope_name
        assert scope.get() is scope.get(scope.BASE_LOCALE)
        locales = {}
        for code in scope.LOCALES:
            loc = scope.get(code)
            assert isinstance(loc, base_class), (scope_name, code)
            assert isinstance(loc, pkg.Localization)
            assert loc is scope.get(code), "instances are cached"
            assert loc.LOCALE == code and loc.SCOPE == scope_name
            assert list(loc.TEMPLATES) == keys, (scope_name, code)
            assert loc.FALLBACK_KEYS <= set(keys)
            assert repr(loc) == "<%s %s/%s>" % (type(loc).__name__, scope_name, code)
            locales[code] = {
                "templates": dict(loc.TEMPLATES),
                "fallback": sorted(loc.FALLBACK_KEYS),
            }
        meta[scope_name] = {"locales": locales, "keys": keys}

    # Errors of the dynamic API.
    first_scope = pkg.SCOPES[0] if pkg.SCOPES else None
    if first_scope is not None:
        loc = pkg.get(first_scope)
        try:
            loc.format("no such key")
            raise AssertionError("unknown key accepted")
        except KeyError:
            pass
        for m in loc.MESSAGES:
            if m.placeholders:
                try:
                    loc.format(m.key)
                    raise AssertionError("missing argument accepted")
                except TypeError:
                    pass
                break
        plain = [m for m in loc.MESSAGES if not m.placeholders]
        if plain:
            try:
                loc.format(plain[0].key, unexpected=1)
                raise AssertionError("unexpected argument accepted")
            except TypeError:
                pass
        try:
            pkg.get("no such scope")
            raise AssertionError("unknown scope accepted")
        except KeyError:
            pass
        message = loc.MESSAGES[0]
        assert pickle.loads(pickle.dumps(message)) == message
        try:
            message.key = "x"
            raise AssertionError("Message is mutable")
        except AttributeError:
            pass

    for scope, locale, label, args, expected in cases.get("labels", []):
        assert pkg.get(scope, locale).format(label, **args) == expected, label

    out = {
        "render": rendered,
        "meta": meta,
        "scopes": list(pkg.SCOPES),
        "supported": list(pkg.SUPPORTED_LOCALES),
        "base": pkg.BASE_LOCALE,
        "plural": {
            locale: [pkg.plural_category(locale, n) for n in cases["numbers"]]
            for locale in pkg.SUPPORTED_LOCALES
        },
        "to_str": [runtime.to_str(v) for v in cases["values"]],
        "negotiate": [
            pkg.resolve_locale(requested) for requested in cases.get("negotiate", [])
        ],
        "accept_language": [
            pkg.parse_accept_language(header) for header in cases.get("accept_language", [])
        ],
    }
    with open(out_path, "w", encoding="utf-8") as f:
        # ASCII escapes: a rendered text may hold a lone surrogate (kept from
        # the sheet), which UTF-8 cannot encode.
        json.dump(out, f, ensure_ascii=True)


if __name__ == "__main__":
    main()
