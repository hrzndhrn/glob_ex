# GlobEx

[![Hex.pm versions](https://img.shields.io/hexpm/v/glob_ex.svg?style=flat-square)](https://hex.pm/packages/glob_ex)
[![GitHub: CI status](https://img.shields.io/github/workflow/status/hrzndhrn/glob_ex/CI?style=flat-square)](https://github.com/hrzndhrn/glob_ex/actions)
[![Coveralls: coverage](https://img.shields.io/coveralls/github/hrzndhrn/glob_ex?style=flat-square)](https://coveralls.io/github/hrzndhrn/glob_ex)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg?style=flat-square)](https://github.com/hrzndhrn/glob_ex/blob/main/LICENSE.md)

An implementation of `glob`.

GlobEx offers among others the functions `GlobEx.ls/1` and `GlobEx.match?/2`.
Furthermore, the sigil `~g||` is provided.

The function `GlobEx.ls/1` returns the same result as `Path.wildcard/2`.
`GlobEx.match?/2` can be used to check whether a `path` is matching a given
`glob`.

## Example

```elixir
iex(1)> import GlobEx.Sigils
GlobEx.Sigils
iex(2)> GlobEx.match?(~g|{lib,test}/**/*.{ex,exs}|, "test/test_helper.exs")
true
iex(3)> GlobEx.match?(~g|{lib,test}/**/*.{ex,exs}|, "test/unknown.exs")
true
iex(4)> GlobEx.match?(~g|{lib,test}/**/*.{ex,exs}|, "test/unknown.foo")
false
iex(5)> GlobEx.ls(~g|{lib,test}/**/*.{ex,exs}|)
["lib/glob_ex.ex", "lib/glob_ex/compiler.ex", "lib/glob_ex/compiler_error.ex",
 "lib/glob_ex/sigils.ex", "test/glob_ex/compiler_test.exs",
 "test/glob_ex_test.exs", "test/test_helper.exs"]
```
