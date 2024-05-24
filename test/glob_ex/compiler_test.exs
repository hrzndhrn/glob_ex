defmodule GlobEx.CompilerTest do
  use ExUnit.Case

  import GlobEx.Compiler

  describe "compile/1" do
    test "returns error for empty string" do
      assert compile("") == {:error, :empty}
    end

    test "exact" do
      assert compile("foo") == {:ok, [exact: ~c"foo"]}
    end

    test "exact path" do
      assert compile("foo/bar/baz") ==
               {:ok, [{:exact, ~c"foo"}, {:exact, ~c"bar"}, {:exact, ~c"baz"}]}
    end

    test "exact path with *" do
      assert compile("foo/bar/baz/*") ==
               {:ok, [{:exact, ~c"foo"}, {:exact, ~c"bar"}, {:exact, ~c"baz"}, :star]}
    end

    test "escape" do
      assert compile(~S"a\*\?\[\]\}\}") == {:ok, [exact: ~c"a*?[]}}"]}
      assert compile(~S"a[A\]]") == {:ok, [seq: [?a, {:one_of, ~c"]A"}]]}
      assert compile(~S"a[A\]\\]") == {:ok, [seq: [?a, {:one_of, ~c"\\]A"}]]}
      assert compile(~S"a[\-\[\]]") == {:ok, [seq: [?a, {:one_of, ~c"][-"}]]}
      assert compile(~S"{a\,b,c}") == {:ok, [alt: [[exact: ~c"a,b"], [exact: ~c"c"]]]}
    end

    test "ignore last slash" do
      assert compile("foo/bar/") == {:ok, [{:exact, ~c"foo"}, {:exact, ~c"bar"}]}
    end

    test "lone *" do
      assert compile("*") == {:ok, [:star]}
    end

    test "a *" do
      assert compile("a*") == {:ok, [{:seq, [?a, :star]}]}
      assert compile("a*f") == {:ok, [{:seq, [?a, :star, ?f]}]}
    end

    test "* and ..." do
      assert compile("*bc") == {:ok, [{:ends_with, ~c"cb"}]}
      assert compile("*bc?") == {:ok, [seq: [:star, ?b, ?c, :question]]}
    end

    test "any dir" do
      assert compile("abc/*/xyz") ==
               {:ok, [{:exact, ~c"abc"}, :star, {:exact, ~c"xyz"}]}
    end

    test "? pattern" do
      assert compile("a?c") == {:ok, [{:seq, [?a, :question, ?c]}]}

      assert compile("a?c/d?f") ==
               {:ok, [{:seq, [?a, :question, ?c]}, {:seq, [?d, :question, ?f]}]}

      assert compile("abc/d?f/ghi") ==
               {:ok, [{:exact, ~c"abc"}, {:seq, [?d, :question, ?f]}, {:exact, ~c"ghi"}]}
    end

    test "lone **" do
      assert compile("**") == {:ok, [:double_star]}
    end

    test "double_star" do
      assert compile("a/**") == {:ok, [{:exact, ~c"a"}, :double_star]}
      assert compile("a/**/") == {:ok, [{:exact, ~c"a"}, :double_star]}

      assert compile("a/**/z") ==
               {:ok, [{:exact, ~c"a"}, :double_star, {:exact, ~c"z"}]}

      assert compile("a/x**/z") ==
               {:ok, [{:exact, ~c"a"}, {:seq, [?x, :star]}, {:exact, ~c"z"}]}
    end

    test "double double_star" do
      assert compile("a/**/**/z") ==
               {:ok, [{:exact, ~c"a"}, :double_star, {:exact, ~c"z"}]}
    end

    test "** fallbacks to *" do
      compile("**/b")
      assert compile("a**/b") == {:ok, [{:seq, [97, :star]}, {:exact, ~c"b"}]}
    end

    test "** fallbacks to ends_with" do
      assert compile("**ab") == {:ok, [{:ends_with, ~c"ba"}]}

      assert compile("a/**xy/z") ==
               {:ok, [{:exact, ~c"a"}, {:ends_with, ~c"yx"}, {:exact, ~c"z"}]}
    end

    test "any of" do
      assert compile("[abc]") == {:ok, [{:one_of, ~c"cba"}]}
      assert compile("[abc]z") == {:ok, [{:seq, [{:one_of, ~c"cba"}, ?z]}]}
      assert compile("z[abc]") == {:ok, [{:seq, [?z, {:one_of, ~c"cba"}]}]}
      assert compile("y/[abc]") == {:ok, [{:exact, ~c"y"}, {:one_of, ~c"cba"}]}

      assert compile("y/[abc]/z") ==
               {:ok, [{:exact, ~c"y"}, {:one_of, ~c"cba"}, {:exact, ~c"z"}]}
    end

    test "any of special" do
      assert compile("a[][A-C-]") == {:ok, [seq: [97, {:one_of, ~c"-][CBA"}]]}
    end

    test "any of range" do
      assert compile("[a-c]") == {:ok, [one_of: ~c"cba"]}
      assert compile("[c-a]") == {:ok, [one_of: ~c""]}
      assert compile("[ab-ef]") == {:ok, [one_of: ~c"faedcb"]}
      assert compile("[ab-ef]xy") == {:ok, [{:seq, [{:one_of, ~c"faedcb"}, ?x, ?y]}]}

      assert compile("y/[ab-ef]/z") ==
               {:ok, [{:exact, ~c"y"}, {:one_of, ~c"faedcb"}, {:exact, ~c"z"}]}
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
      assert compile("{abc,def}-post") ==
               {:ok, [alt: [[exact: ~c"abc-post"], [exact: ~c"def-post"]]]}

      assert compile("pre-{abc,def}") ==
               {:ok, [seq: [?p, ?r, ?e, ?-, {:alt, [[exact: ~c"abc"], [exact: ~c"def"]]}]]}

      assert compile("pre-{abc,def}-post") ==
               {:ok,
                [seq: [?p, ?r, ?e, ?-, {:alt, [[exact: ~c"abc-post"], [exact: ~c"def-post"]]}]]}

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
                        [{:exact, ~c"def-post"}]
                      ]}
                   ]}
                ]}
    end

    test "two alternatives" do
      assert compile("{abc,def}") ==
               {:ok, [{:alt, [[{:exact, ~c"abc"}], [{:exact, ~c"def"}]]}]}

      assert compile("{abc,def}/ghi") ==
               {:ok, [{:alt, [[{:exact, ~c"abc"}], [{:exact, ~c"def"}]]}, {:exact, ~c"ghi"}]}
    end

    test "alternatives with patterns" do
      assert compile("{a?c,d[e-g]h}") ==
               {:ok, [alt: [[seq: [?a, :question, ?c]], [seq: [?d, {:one_of, ~c"gfe"}, ?h]]]]}
    end

    test "start with alternatives" do
      assert compile("{abc,def}ghi/jkl/*.txt") ==
               {:ok,
                [
                  {:alt, [[{:exact, ~c"abcghi"}], [{:exact, ~c"defghi"}]]},
                  {:exact, ~c"jkl"},
                  {:ends_with, ~c"txt."}
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
                  exact: ~c"jkl"
                ]}
    end

    test "alternative with stars" do
      assert compile("{a*,b**}/xyz") ==
               {:ok, [alt: [[seq: [?a, :star]], [seq: [?b, :star]]], exact: ~c"xyz"]}
    end

    test "ends_with alternatives" do
      assert compile("foo/*.{json,yaml}") ==
               {:ok, [exact: ~c"foo", alt: [[ends_with: ~c"nosj."], [ends_with: ~c"lmay."]]]}

      assert compile("foo/*.{json,y?ml}") ==
               {:ok,
                [
                  exact: ~c"foo",
                  seq: [:star, ?., {:alt, [[exact: ~c"json"], [seq: [?y, :question, ?m, ?l]]]}]
                ]}
    end

    test "incomplete alternatives" do
      assert compile("a*{def,}") == {:ok, [seq: [?a, :star, {:alt, [[exact: ~c"def"], :empty]}]]}
    end

    test "{mix,.formatter}.exs" do
      assert compile("{mix,.formatter}.exs") ==
               {:ok,
                [
                  alt: [[exact: ~c"mix.exs"], [exact: ~c".formatter.exs"]]
                ]}
    end

    test "{config,lib,test}/**/*.{ex,exs}" do
      assert compile("{config,lib,test}/**/*.{ex,exs}") ==
               {:ok,
                [
                  {:alt, [[exact: ~c"config"], [exact: ~c"lib"], [exact: ~c"test"]]},
                  :double_star,
                  {:alt, [[{:ends_with, ~c"xe."}], [{:ends_with, ~c"sxe."}]]}
                ]}
    end

    test "windows root" do
      assert compile("x:/foo/*") == {:ok, [{:root, ~c"x:/"}, {:exact, ~c"foo"}, :star]}
    end
  end
end
