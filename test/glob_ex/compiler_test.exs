defmodule GlobEx.CompilerTest do
  use ExUnit.Case

  import GlobEx.Compiler

  describe "compile/1" do
    test "returns error for empty string" do
      assert compile("") == {:error, :empty}
    end

    test "exact" do
      assert compile("foo") == {:ok, [exact: 'foo']}
    end

    test "exact path" do
      assert compile("foo/bar/baz") == {:ok, [{:exact, 'foo'}, {:exact, 'bar'}, {:exact, 'baz'}]}
    end

    test "exact path with *" do
      assert compile("foo/bar/baz/*") ==
               {:ok, [{:exact, 'foo'}, {:exact, 'bar'}, {:exact, 'baz'}, :star]}
    end

    test "escape" do
      assert compile(~S"a\*\?\[\]\}\}") == {:ok, [exact: 'a*?[]}}']}
      assert compile(~S"a[A\]]") == {:ok, [seq: [?a, {:one_of, ']A'}]]}
      assert compile(~S"a[A\]\\]") == {:ok, [seq: [?a, {:one_of, '\\]A'}]]}
      assert compile(~S"a[\-\[\]]") == {:ok, [seq: [?a, {:one_of, '][-'}]]}
      assert compile(~S"{a\,b,c}") == {:ok, [alt: [[exact: 'a,b'], [exact: 'c']]]}
    end

    test "ignore last slash" do
      assert compile("foo/bar/") == {:ok, [{:exact, 'foo'}, {:exact, 'bar'}]}
    end

    test "lone *" do
      assert compile("*") == {:ok, [:star]}
    end

    test "a *" do
      assert compile("a*") == {:ok, [{:seq, [?a, :star]}]}
      assert compile("a*f") == {:ok, [{:seq, [?a, :star, ?f]}]}
    end

    test "* and ..." do
      assert compile("*bc") == {:ok, [{:ends_with, 'cb'}]}
      assert compile("*bc?") == {:ok, [seq: [:star, ?b, ?c, :question]]}
    end

    test "any dir" do
      assert compile("abc/*/xyz") ==
               {:ok, [{:exact, 'abc'}, :star, {:exact, 'xyz'}]}
    end

    test "? pattern" do
      assert compile("a?c") == {:ok, [{:seq, [?a, :question, ?c]}]}

      assert compile("a?c/d?f") ==
               {:ok, [{:seq, [?a, :question, ?c]}, {:seq, [?d, :question, ?f]}]}

      assert compile("abc/d?f/ghi") ==
               {:ok, [{:exact, 'abc'}, {:seq, [?d, :question, ?f]}, {:exact, 'ghi'}]}
    end

    test "lone **" do
      assert compile("**") == {:ok, [:double_star]}
    end

    test "double_star" do
      assert compile("a/**") == {:ok, [{:exact, 'a'}, :double_star]}
      assert compile("a/**/") == {:ok, [{:exact, 'a'}, :double_star]}

      assert compile("a/**/z") ==
               {:ok, [{:exact, 'a'}, :double_star, {:exact, 'z'}]}

      assert compile("a/x**/z") ==
               {:ok, [{:exact, 'a'}, {:seq, [?x, :star]}, {:exact, 'z'}]}
    end

    test "double double_star" do
      assert compile("a/**/**/z") ==
               {:ok, [{:exact, 'a'}, :double_star, {:exact, 'z'}]}
    end

    test "** fallbacks to *" do
      compile("**/b")
      assert compile("a**/b") == {:ok, [{:seq, [97, :star]}, {:exact, 'b'}]}
    end

    test "** fallbacks to ends_with" do
      assert compile("**ab") == {:ok, [{:ends_with, 'ba'}]}

      assert compile("a/**xy/z") ==
               {:ok, [{:exact, 'a'}, {:ends_with, 'yx'}, {:exact, 'z'}]}
    end

    test "any of" do
      assert compile("[abc]") == {:ok, [{:one_of, 'cba'}]}
      assert compile("[abc]z") == {:ok, [{:seq, [{:one_of, 'cba'}, ?z]}]}
      assert compile("z[abc]") == {:ok, [{:seq, [?z, {:one_of, 'cba'}]}]}
      assert compile("y/[abc]") == {:ok, [{:exact, 'y'}, {:one_of, 'cba'}]}

      assert compile("y/[abc]/z") ==
               {:ok, [{:exact, 'y'}, {:one_of, 'cba'}, {:exact, 'z'}]}
    end

    test "any of special" do
      assert compile("a[][A-C-]") == {:ok, [seq: [97, {:one_of, '-][CBA'}]]}
    end

    test "any of range" do
      assert compile("[a-c]") == {:ok, [one_of: 'cba']}
      assert compile("[c-a]") == {:ok, [one_of: '']}
      assert compile("[ab-ef]") == {:ok, [one_of: 'faedcb']}
      assert compile("[ab-ef]xy") == {:ok, [{:seq, [{:one_of, 'faedcb'}, ?x, ?y]}]}

      assert compile("y/[ab-ef]/z") ==
               {:ok, [{:exact, 'y'}, {:one_of, 'faedcb'}, {:exact, 'z'}]}
    end

    test "invalid patterns" do
      assert compile("[abc/cd]") == {:error, {:missing_delimiter, 1}}
      assert compile("a/[bcd") == {:error, {:missing_delimiter, 3}}
      assert compile("a/[bcd]/{efg,hij}/[k/l]") == {:error, {:missing_delimiter, 18}}
      assert compile("a/{bc,d/e}") == {:error, {:missing_delimiter, 3}}
      assert compile("a/{bc,de}/[a-z]/{/}") == {:error, {:missing_delimiter, 16}}
      assert compile("foo/b{a/r}") == {:error, {:missing_delimiter, 6}}
      assert compile("foo/b{r") == {:error, {:missing_delimiter, 6}}
    end

    test "just two alternatives with pre/postfix" do
      assert compile("{abc,def}-post") == {:ok, [alt: [[exact: 'abc-post'], [exact: 'def-post']]]}

      assert compile("pre-{abc,def}") ==
               {:ok, [seq: [?p, ?r, ?e, ?-, {:alt, [[exact: 'abc'], [exact: 'def']]}]]}

      assert compile("pre-{abc,def}-post") ==
               {:ok, [seq: [?p, ?r, ?e, ?-, {:alt, [[exact: 'abc-post'], [exact: 'def-post']]}]]}

      assert compile("pre-{a?c,def}-post") ==
               {:ok,
                [
                  {:seq,
                   [
                     ?p,
                     ?r,
                     ?e,
                     ?-,
                     {:alt,
                      [
                        [{:seq, [?a, :question, ?c, ?-, ?p, ?o, ?s, ?t]}],
                        [{:exact, 'def-post'}]
                      ]}
                   ]}
                ]}
    end

    test "two alternatives" do
      assert compile("{abc,def}") ==
               {:ok, [{:alt, [[{:exact, 'abc'}], [{:exact, 'def'}]]}]}

      assert compile("{abc,def}/ghi") ==
               {:ok, [{:alt, [[{:exact, 'abc'}], [{:exact, 'def'}]]}, {:exact, 'ghi'}]}
    end

    test "alternatives with patterns" do
      assert compile("{a?c,d[e-g]h}") ==
               {:ok, [alt: [[seq: [?a, :question, ?c]], [seq: [?d, {:one_of, 'gfe'}, ?h]]]]}
    end

    test "start with alternatives" do
      assert compile("{abc,def}ghi/jkl/*.txt") ==
               {:ok,
                [
                  {:alt, [[{:exact, 'abcghi'}], [{:exact, 'defghi'}]]},
                  {:exact, 'jkl'},
                  {:ends_with, 'txt.'}
                ]}
    end

    test "alternative with post pattern" do
      assert compile("{abc,def}g?i/jkl") ==
               {:ok,
                [
                  alt: [
                    [{:seq, [?a, ?b, ?c, ?g, :question, ?i]}],
                    [{:seq, [?d, ?e, ?f, ?g, :question, ?i]}]
                  ],
                  exact: 'jkl'
                ]}
    end

    test "alternative with stars" do
      assert compile("{a*,b**}/xyz") ==
               {:ok, [alt: [[seq: [?a, :star]], [seq: [?b, :star]]], exact: 'xyz']}
    end

    test "ends_with alternatives" do
      assert compile("foo/*.{json,yaml}") ==
               {:ok, [exact: 'foo', alt: [[ends_with: 'nosj.'], [ends_with: 'lmay.']]]}

      assert compile("foo/*.{json,y?ml}") ==
               {:ok,
                [
                  exact: 'foo',
                  seq: [:star, ?., {:alt, [[exact: 'json'], [seq: [?y, :question, ?m, ?l]]]}]
                ]}
    end

    test "incomplete alternatives" do
      assert compile("a*{def,}") == {:ok, [seq: [?a, :star, {:alt, [[exact: 'def'], :empty]}]]}
    end

    test "{mix,.formatter}.exs" do
      assert compile("{mix,.formatter}.exs") ==
               {:ok,
                [
                  alt: [[exact: 'mix.exs'], [exact: '.formatter.exs']]
                ]}
    end

    test "{config,lib,test}/**/*.{ex,exs}" do
      assert compile("{config,lib,test}/**/*.{ex,exs}") ==
               {:ok,
                [
                  {:alt, [[exact: 'config'], [exact: 'lib'], [exact: 'test']]},
                  :double_star,
                  {:alt, [[{:ends_with, 'xe.'}], [{:ends_with, 'sxe.'}]]}
                ]}
    end

    test "windows root" do
      assert compile("x:/foo/*") == {:ok, [{:root, 'x:/'}, {:exact, 'foo'}, :star]}
    end
  end
end
