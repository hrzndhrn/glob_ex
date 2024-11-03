defmodule GlobExTest do
  use ExUnit.Case

  import GlobEx.Sigils
  import Prove

  alias GlobEx.CompileError

  doctest GlobEx
  doctest GlobEx.Sigils

  setup context do
    cwd = File.cwd!()

    if Map.has_key?(context, :tmp_dir) do
      File.cd!(context[:tmp_dir])
    end

    on_exit(fn -> File.cd!(cwd) end)

    context
  end

  describe "compile/2" do
    test "with match_dot: false" do
      assert GlobEx.compile("foo") ==
               {:ok, %GlobEx{source: "foo", compiled: [exact: ~c"foo"], match_dot: false}}
    end

    test "with match_dot: true" do
      assert GlobEx.compile("foo", match_dot: true) ==
               {:ok, %GlobEx{source: "foo", compiled: [exact: ~c"foo"], match_dot: true}}
    end

    test "returns error tuple" do
      assert GlobEx.compile("") == {:error, %CompileError{reason: :empty}}

      assert GlobEx.compile("[") ==
               {:error, %CompileError{reason: {:missing_delimiter, 1}, input: "["}}

      assert GlobEx.compile("foo/b[r") ==
               {:error, %CompileError{reason: {:missing_delimiter, 6}, input: "foo/b[r"}}

      assert GlobEx.compile("foo/b{r") ==
               {:error, %CompileError{reason: {:missing_delimiter, 6}, input: "foo/b{r"}}

      assert GlobEx.compile("b{r/}") ==
               {:error, %CompileError{reason: {:missing_delimiter, 2}, input: "b{r/}"}}

      assert GlobEx.compile("b[r/]") ==
               {:error, %CompileError{reason: {:missing_delimiter, 2}, input: "b[r/]"}}
    end
  end

  describe "compile!/2" do
    test "with match_dot: false" do
      assert GlobEx.compile!("foo") ==
               %GlobEx{source: "foo", compiled: [exact: ~c"foo"], match_dot: false}
    end

    test "with match_dot: true" do
      assert GlobEx.compile!("foo", match_dot: true) ==
               %GlobEx{source: "foo", compiled: [exact: ~c"foo"], match_dot: true}
    end

    test "returns error" do
      assert_raise CompileError, "invalid empty glob", fn ->
        GlobEx.compile!("")
      end

      assert_raise CompileError, "missing terminator for delimiter opened at 6", fn ->
        GlobEx.compile!("foo/b[r")
      end
    end
  end

  describe "sigil_g/2" do
    test "without modifier d" do
      assert ~g|foo| == GlobEx.compile!("foo")

      o = "o"
      assert ~g|f#{o}o| == GlobEx.compile!("foo")
    end

    test "with modifier d" do
      assert ~g|foo|d == GlobEx.compile!("foo", match_dot: true)
    end

    test "with escape" do
      glob = ~S"a[\[]"
      assert GlobEx.compile!(glob) == ~g|a[\[]|

      assert GlobEx.match?(~g|f\#{i,a}|, "f#i") == true
      assert GlobEx.match?(~g|f\#{i,a}|, "f#a") == true
      assert GlobEx.match?(~g|f\#{i,a}|, "f#o") == false

      assert ~g|f\ao| == GlobEx.compile!("f\ao")
      assert ~g|f\fo| == GlobEx.compile!("f\fo")
      assert ~g|f\no| == GlobEx.compile!("f\no")
      assert ~g|f\ro| == GlobEx.compile!("f\ro")
      assert ~g|f\to| == GlobEx.compile!("f\to")
      assert ~g|f\vo| == GlobEx.compile!("f\vo")

      assert ~g"""
             foo\
             """ == GlobEx.compile!("foo")
    end

    test "inspect" do
      assert inspect(~g|foo|) == "~g|foo|"
      assert inspect(~g|\[|) == "~g|\\[|"
      assert inspect(~g|{lib,test}/**/*.{ex,exs}|) == "~g|{lib,test}/**/*.{ex,exs}|"
      assert inspect(~g|\||) == "~g|\\||"
      assert inspect(~g"|") == "~g|\\||"
      assert inspect(~g"\\") == "~g|\\\\|"
    end
  end

  describe "sigil_G/2" do
    test "without modifier d" do
      assert ~G|foo| == GlobEx.compile!("foo")

      assert ~G|f#{o}o| == GlobEx.compile!("f\#{o}o")

      assert GlobEx.match?(~G|f#{i,a}|, "f#i") == true
      assert GlobEx.match?(~G|f#{i,a}|, "f#a") == true
      assert GlobEx.match?(~G|f#{i,a}|, "f#o") == false
    end

    test "with modifier d" do
      assert ~G|foo|d == GlobEx.compile!("foo", match_dot: true)
    end

    test "inspect" do
      assert inspect(~G|foo|) == "~g|foo|"
      assert inspect(~G|f#{o,u}o|) == "~g|f\\\#{o,u}o|"
      assert inspect(~G"|") == "~g|\\||"
    end
  end

  describe "ls/1" do
    @describetag :tmp_dir

    test "literal match (simple)" do
      mkfiles([".xyz", "abc", "abcdef", "glurf"])

      assert GlobEx.ls(~g|abcdef|) == ["abcdef"]
      assert GlobEx.ls(~g|.xyz|) == [".xyz"]
    end

    test "literal match from root" do
      file = "test.xyz"
      mkfiles([file])

      path = Path.join(File.cwd!(), file)

      assert ls(path) == [path]
    end

    test "glob with UTF-8" do
      mkfiles(["héllò"])

      assert GlobEx.ls(~g|héllò|) == ["héllò"]
    end

    test "matching with pattern * and ** (simple)" do
      mkfiles([".xyz", "abc", "abcdef", "glurf"])

      assert ls("*", match_dot: true) == [".xyz", "abc", "abcdef", "glurf"]
      assert ls("*") == ["abc", "abcdef", "glurf"]
      assert ls("abcdef") == ["abcdef"]
      assert ls("a*") == ["abc", "abcdef"]
      assert ls("abc*") == ["abc", "abcdef"]
      assert ls("abcd*") == ["abcdef"]
      assert ls("*def") == ["abcdef"]
      assert ls("ab*ef") == ["abcdef"]
      assert ls("a*f") == ["abcdef"]

      assert ls("**", match_dot: true) == [".xyz", "abc", "abcdef", "glurf"]
      assert ls("**") == ["abc", "abcdef", "glurf"]
    end

    test "matching with pattern * from root" do
      files = ["a", "b", "c"]
      mkfiles(files)

      glob = File.cwd!() <> "/*"
      paths = Enum.map(files, fn file -> Path.join(File.cwd!(), file) end)

      assert ls(glob) == paths
    end

    test "matching with pattern ? (simple)" do
      mkfiles([".xyz", "abc", "abcdef", "glurf"])

      assert ls("abcdef") == ["abcdef"]
      assert ls("ab?") == ["abc"]
      assert ls("ab???") == []
      assert ls("ab????") == ["abcdef"]
      assert ls("?xyz") == []
      assert ls("?xyz", match_dot: true) == [".xyz"]
    end

    test "matching with pattern {} (simple)" do
      mkfiles([".xyz", "abc", "abcdef", "glurf"])

      assert ls("abcdef") == ["abcdef"]
      assert ls("{abc,abcdef}") == ["abc", "abcdef"]
      assert ls("{*def,gl*}") == ["abcdef", "glurf"]
      assert ls("a*{def,}") == ["abc", "abcdef"]
      assert ls("a*{,def}") == ["abc", "abcdef"]
      assert ls("a*{def,urf}") == ["abcdef"]
      assert ls("a*{d?f,urf}") == ["abcdef"]
      assert ls("a*{cd,xy}ef") == ["abcdef"]
    end

    test "matching with pattern {} and ?" do
      mkfiles(["bar/foo.json", "foo/foo.json", "foo/foo.xml", "foo/foo.yaml"])
      assert ls("foo/*.{json,y?ml}") == ["foo/foo.json", "foo/foo.yaml"]
    end

    test "matching with pattern [] (simple)" do
      mkfiles([".xyz", "abc", "abcdef", "glurf"])

      assert ls("a[a-c]cdef") == ["abcdef"]
      assert ls("abcd[a-c]f") == []
    end

    test "matching with pattern [] for a compoent" do
      mkfiles(["a/x/c", "a/z/c", "a/xyz/c"])

      assert ls("a/[a-z]/c") == ["a/x/c", "a/z/c"]
      assert ls("a/[xyz]/c") == ["a/x/c", "a/z/c"]
      assert ls("a/[uvw]/c") == []
      assert ls("a/[y-z]/c") == ["a/z/c"]
      assert ls("a/[x-y]/c") == ["a/x/c"]
    end

    test "matching with pattern [] (character sets)" do
      all = ["a01", "a02", "a03", "b00", "c02", "d19"]
      mkfiles(all)

      assert ls("[a-z]*") == all
      assert ls("[a-d]*") == all
      assert ls("[abcd]*") == all
      assert ls("[a-c]*") == ["a01", "a02", "a03", "b00", "c02"]
      assert ls("[abc]*") == ["a01", "a02", "a03", "b00", "c02"]
      assert ls("?[0-9][0-9]") == all
      assert ls("?[0-1][0-39]") == all
      assert ls("?[0-1][0-29]") == ["a01", "a02", "b00", "c02", "d19"]
      assert ls("[abcdef][10][01239]") == all
      assert ls("[bcdef][10][01239]") == ["b00", "c02", "d19"]
      assert ls("[bcdef][10][0123]") == ["b00", "c02"]
      assert ls("[a-z]0[0123]") == ["a01", "a02", "a03", "b00", "c02"]
      assert ls("[a-z][0-19]") == []
      assert ls("[a-z][0-19][0-19]") == ["a01", "b00", "d19"]
      assert ls("a[0-9][0-9]") == ["a01", "a02", "a03"]
      assert ls("a[]3") == []
      assert ls("a[]03") == []
      assert ls("[]*") == []

      # [diff] Path.wildcard/2 vs GlobEx
      #        checked with python, perl and zsh
      assert GlobEx.ls(~g|[c-a]*|) == []
      assert Path.wildcard("[c-a]*") == ["a01", "a02", "a03", "c02"]
    end

    test "matching with pattern [] (tricky characters)" do
      all =
        if unix?() do
          ["a-", "aA", "aB", "aC", "a[", "a\\", "a]"]
        else
          ["a-", "aA", "aB", "aC", "a[", "a]"]
        end

      mkfiles(all)

      if unix?() do
        # [diff] Path.wildcard/2 vs GlobEx
        #        checked with python, perl and zsh
        assert GlobEx.ls(~g|a\\|) == ["a\\"]
        assert Path.wildcard("a\\") == []
      end

      assert ls("*") == all

      assert ls("a[]") == []
      assert ls("a[A-C]") == ["aA", "aB", "aC"]
      assert ls("a[A-C-]") == ["a-", "aA", "aB", "aC"]
      assert ls("a[A-C[]-]") == []

      assert ls(~S"a[\[]") == ["a["]
      assert ls(~S"a[\[\]-]") == ["a-", "a[", "a]"]
      assert ls(~S"a[\[\]\-]") == ["a-", "a[", "a]"]
      assert ls(~S"a[\-]") == ["a-"]
      assert ls(~S"a[\-\[]") == ["a-", "a["]
      assert ls(~S"a[\-\[\]]") == ["a-", "a[", "a]"]
      assert ls(~S"a[A\]\[]") == ["aA", "a[", "a]"]
      assert ls("a[][A-C-]") == ["a-", "aA", "aB", "aC", "a[", "a]"]
    end

    test "no matching (simple)" do
      mkfiles([".xyz", "abc", "abcdef", "glurf"])

      assert ls("b*") == []
      assert ls("a*z") == []
      assert ls("bufflig") == []
    end

    test "matching with pattern *" do
      all = ["Date", "DateTime"]
      mkfiles(all)

      assert ls("D*") == all
      assert ls("Date*") == all
    end

    test "matches with * and ** (simple paths)" do
      mkfiles([".aaa/susi", "blurf/nisse", "xa/arne", "xa/kalle", "yyy/.knut", "yyy/arne"])

      assert ls("*") == ["blurf", "xa", "yyy"]
      assert ls("*", match_dot: true) == [".aaa", "blurf", "xa", "yyy"]
      double_star = ["blurf", "blurf/nisse", "xa", "xa/arne", "xa/kalle", "yyy", "yyy/arne"]
      assert ls("**") == double_star
      assert ls("**/*") == double_star
      assert ls("**/**") == double_star

      assert ls("**", match_dot: true) == [
               ".aaa",
               ".aaa/susi",
               "blurf",
               "blurf/nisse",
               "xa",
               "xa/arne",
               "xa/kalle",
               "yyy",
               "yyy/.knut",
               "yyy/arne"
             ]

      assert ls("*/*") == ["blurf/nisse", "xa/arne", "xa/kalle", "yyy/arne"]

      assert ls("*/*", match_dot: true) == [
               ".aaa/susi",
               "blurf/nisse",
               "xa/arne",
               "xa/kalle",
               "yyy/.knut",
               "yyy/arne"
             ]
    end

    test "match foo and ** or **/*" do
      mkfiles(["foo/bar.txt", "foo/bar/baz.txt"])

      assert ls("foo") == ["foo"]
      assert ls("foo/") == ["foo"]
      assert ls("foo/**") == ["foo/bar", "foo/bar.txt", "foo/bar/baz.txt"]
      assert ls("foo/**/*") == ["foo/bar", "foo/bar.txt", "foo/bar/baz.txt"]
    end

    test "match foo and ** or **/* with file foo" do
      mkfiles(["foo"])

      assert ls("foo") == ["foo"]
      assert ls("foo/") == ["foo"]
      assert ls("foo/**") == []
      assert ls("foo/**/*") == []
    end

    test "literal match (simple paths)" do
      mkfiles([".aaa/susi", "blurf/nisse", "xa/arne", "xa/kalle", "yyy/.knut", "yyy/arne"])

      assert ls("xa/arne") == ["xa/arne"]
      assert ls("*/arne") == ["xa/arne", "yyy/arne"]
      assert ls("xa/*") == ["xa/arne", "xa/kalle"]
      assert ls("*/nisse") == ["blurf/nisse"]
      assert ls("*/gurka") == []
      assert ls("gurka/*") == []
    end

    test "matching ** and literal" do
      mkfiles([
        "a/foo.txt",
        "a/bar.txt",
        "a/.baz.txt",
        "b/bar.txt",
        "c/foo.txt",
        "c/bar.txt",
        "c/d/foo.txt",
        "c/d/bar.txt",
        "c/d/e/foo.txt",
        "c/d/f/bar.txt",
        "c/.z/foo.txt"
      ])

      assert ls("a/**") == ["a/bar.txt", "a/foo.txt"]
      assert ls("a/**/") == ["a/bar.txt", "a/foo.txt"]
      assert ls("**/foo.txt") == ["a/foo.txt", "c/d/e/foo.txt", "c/d/foo.txt", "c/foo.txt"]
      assert ls("c/d*/foo.txt") == ["c/d/foo.txt"]
      assert ls("c/d**/foo.txt") == ["c/d/foo.txt"]
      assert ls("c**/foo.txt") == ["c/foo.txt"]
      assert ls("{a,c**}/foo.txt") == ["a/foo.txt", "c/foo.txt"]

      assert ls("a/**", match_dot: true) == ["a/.baz.txt", "a/bar.txt", "a/foo.txt"]

      assert ls("**/foo.txt", match_dot: true) == [
               "a/foo.txt",
               "c/.z/foo.txt",
               "c/d/e/foo.txt",
               "c/d/foo.txt",
               "c/foo.txt"
             ]

      assert ls("{a,c**}/foo.txt", match_dot: true) == ["a/foo.txt", "c/foo.txt"]
    end

    test "matching ** in different deeps" do
      mkfiles([
        "a1/abc/foo/x1",
        "a1/abc/def/ghi",
        "a2/def/bar/foo",
        "a2/def/foo/bar",
        "a3/def/foo"
      ])

      assert ls("{a1,a2}/**/*{oo,ar}") == [
               "a1/abc/foo",
               "a2/def/bar",
               "a2/def/bar/foo",
               "a2/def/foo",
               "a2/def/foo/bar"
             ]
    end

    test "star dot star" do
      mkfiles(["xbin/a.x", "xbin/b.x", "xbin/c.x", "xbin/.d.x", ".ybin/a.x"])

      assert ls("**") == ["xbin", "xbin/a.x", "xbin/b.x", "xbin/c.x"]

      assert ls("**", match_dot: true) == [
               ".ybin",
               ".ybin/a.x",
               "xbin",
               "xbin/.d.x",
               "xbin/a.x",
               "xbin/b.x",
               "xbin/c.x"
             ]

      assert ls("*") == ["xbin"]
      assert ls("*", match_dot: true) == [".ybin", "xbin"]
      assert ls("*/*") == ["xbin/a.x", "xbin/b.x", "xbin/c.x"]

      assert ls("*/*", match_dot: true) == [
               ".ybin/a.x",
               "xbin/.d.x",
               "xbin/a.x",
               "xbin/b.x",
               "xbin/c.x"
             ]

      assert ls("xbin/*") == ["xbin/a.x", "xbin/b.x", "xbin/c.x"]
      assert ls("xbin/*", match_dot: true) == ["xbin/.d.x", "xbin/a.x", "xbin/b.x", "xbin/c.x"]
      assert ls("xbin/*.*") == ["xbin/a.x", "xbin/b.x", "xbin/c.x"]
      assert ls("xbin/*.*", match_dot: true) == ["xbin/.d.x", "xbin/a.x", "xbin/b.x", "xbin/c.x"]
      assert ls(".ybin/*", match_dot: true) == [".ybin/a.x"]
      assert ls("*/.d.x") == []
      assert ls("*/.d.x", match_dot: true) == ["xbin/.d.x"]
      assert ls("**in/*") == ["xbin/a.x", "xbin/b.x", "xbin/c.x"]

      assert ls("**in/*", match_dot: true) == [
               ".ybin/a.x",
               "xbin/.d.x",
               "xbin/a.x",
               "xbin/b.x",
               "xbin/c.x"
             ]

      assert ls(".ybin/*") == [".ybin/a.x"]
    end

    test "matching with pattern * and ** (deep)" do
      mkfiles(["blurf/nisse/baz", "xa/arne", "xa/kalle", "yyy/arne"])

      assert ls("**") == [
               "blurf",
               "blurf/nisse",
               "blurf/nisse/baz",
               "xa",
               "xa/arne",
               "xa/kalle",
               "yyy",
               "yyy/arne"
             ]

      assert ls("**/*") == [
               "blurf",
               "blurf/nisse",
               "blurf/nisse/baz",
               "xa",
               "xa/arne",
               "xa/kalle",
               "yyy",
               "yyy/arne"
             ]

      assert ls("**/arne") == ["xa/arne", "yyy/arne"]
      assert ls("**/nisse") == ["blurf/nisse"]
      assert ls("**/foo") == []
      assert ls("foo/**") == []
    end

    test "matching with pattern * and ** (deeper)" do
      all = ["blurf/nisse/a/1.txt", "blurf/nisse/b/2.txt", "blurf/nisse/b/3.txt"]
      mkfiles(all)

      assert ls("**/blurf/**/*.txt") == all
    end

    test "escape characters using \\" do
      mkfiles(["{abc}", "abc", "def", "---", "z--", "@a,b", "@c"])

      assert ls(~S"\{a*") == ["{abc}"]
      assert ls(~S"\{abc}") == ["{abc}"]
      assert ls("[a-z]*") == ["abc", "def", "z--"]
      assert ls(~S"[a\-z]*") == ["---", "abc", "z--"]
      assert ls(~S"@{a\,b,c}") == ["@a,b", "@c"]
      assert ls("@{a,b,c}") == ["@c"]

      if unix?() do
        # '?' is allowed in file names on Unix, but not on Windows.
        mkfiles(["?q"])

        assert ls(~S"\?*") == ["?q"]
      end
    end

    test "with '@/..' and '..'" do
      mkfiles(["@/", "@dir/", "dir@/", "@a", "b@", "x", "y", "z"])
      all = ["@", "@a", "@dir", "b@", "dir@", "x", "y", "z"]

      assert ls("*") == all
      assert ls("**") == all
      assert ls("@") == ["@"]
      assert ls("@*") == ["@", "@a", "@dir"]

      # The following globs doesn't work with Path.wildcard/2.
      assert GlobEx.ls(~g|@*/../@*|) == [
               "@/../@",
               "@/../@a",
               "@/../@dir",
               "@dir/../@",
               "@dir/../@a",
               "@dir/../@dir"
             ]

      assert GlobEx.ls(~g|@*/..|) == ["@/..", "@dir/.."]
    end

    test "matching in an Elixir project" do
      mkfiles([
        "mix.exs",
        "test/hello_world_test.exs",
        "test/test_helper.exs",
        "README.md",
        ".gitignore",
        "lib/hello_world/say_it.ex",
        "lib/hello_world.ex",
        ".formatter.exs"
      ])

      assert ls("{mix,.formatter}.exs") == ["mix.exs"]
      assert ls("{mix,.formatter}.exs", match_dot: true) == [".formatter.exs", "mix.exs"]

      assert ls("{config,lib,test}/**/*.{ex,exs}") == [
               "lib/hello_world.ex",
               "lib/hello_world/say_it.ex",
               "test/hello_world_test.exs",
               "test/test_helper.exs"
             ]
    end

    test "dir and file" do
      mkfiles(["bar/", "baz"])

      assert File.dir?("bar") == true
      assert File.dir?("baz") == false

      assert ls("b*/") == ["bar", "baz"]
      assert ls("b*") == ["bar", "baz"]

      assert ls("bar/../baz") == ["bar/../baz"]
      assert ls("bar/../foo") == []
      assert ls("baz/../bar") == []
    end

    test "check for the match?/2 proves" do
      mkfiles([".foo/.bar/.baz", ".foo/.bar/zab", "oof/.bar/zab", ".c1"])

      assert ls(".foo/.bar/.baz") == [".foo/.bar/.baz"]
      assert ls(".foo/.bar/.baz", match_dot: true) == [".foo/.bar/.baz"]

      assert ls(".foo/.bar/*", match_dot: true) == [".foo/.bar/.baz", ".foo/.bar/zab"]
      assert ls("*/.bar/.baz") == []
      assert ls("*/.bar/.baz", match_dot: true) == [".foo/.bar/.baz"]
      assert ls(".[a-c][0-5]") == []
      assert ls(".[a-c][0-5]", match_dot: true) == [".c1"]

      # Path.wildcard returns files in hiden folders when the glob starts with
      # exact components. But not when the glob starts with other options.
      assert ls("*/.bar/*") == []

      assert ls("*/.bar/*", match_dot: true) == [
               ".foo/.bar/.baz",
               ".foo/.bar/zab",
               "oof/.bar/zab"
             ]

      assert ls(".foo/.bar/*", match_dot: true) == [".foo/.bar/.baz", ".foo/.bar/zab"]
      assert ls(".foo/.bar/*") == [".foo/.bar/zab"]
    end

    test "with an explicit .file in glob" do
      mkfiles([".foo.txt", "bar/.foo.txt", "bar/baz/.foo.txt"])

      assert ls(".foo.txt") == [".foo.txt"]
      assert ls("*/.foo.txt") == []
      assert ls("**/.foo.txt") == []
      assert ls("bar/.foo.txt") == ["bar/.foo.txt"]

      cwd = File.cwd!()
      assert ls(Path.join(cwd, ".foo.txt")) == [Path.join(cwd, ".foo.txt")]
      assert ls(Path.join(cwd, "*/.foo.txt")) == []
      assert ls(Path.join(cwd, "**/.foo.txt")) == []
      assert ls(Path.join(cwd, "bar/.foo.txt")) == [Path.join(cwd, "bar/.foo.txt")]
    end
  end

  batch "match?/2" do
    prove GlobEx.match?(~g|foo|, "foo") == true
    prove GlobEx.match?(~g|.foo|, ".foo") == true
    prove GlobEx.match?(~g|foo|, "FOO") == false
    prove GlobEx.match?(~g|héllò|, "héllò") == true
    prove GlobEx.match?(~g|foo/bar/baz|, "foo/bar/baz") == true
    prove GlobEx.match?(~g|.foo/.bar/.baz|, ".foo/.bar/.baz") == true
    prove GlobEx.match?(~g|.foo/.bar/.baz|d, ".foo/.bar/.baz") == true
    prove GlobEx.match?(~g|.foo/.bar/*|, ".foo/.bar/.baz") == false
    prove GlobEx.match?(~g|.foo/.bar/*|d, ".foo/.bar/.baz") == true
    prove GlobEx.match?(~g|.foo/.bar/*|, ".foo/.bar/zab") == true
    prove GlobEx.match?(~g|*/.bar/*|, "oof/.bar/zab") == false

    prove GlobEx.match?(~g|a?c|, "abc") == true
    prove GlobEx.match?(~g|a?c/|, "abc") == true
    prove GlobEx.match?(~g|a?c|, "abc/") == true
    prove GlobEx.match?(~g|a?c/|, "abc/") == true
    prove GlobEx.match?(~g|a?c|, "def") == false
    prove GlobEx.match?(~g|??c|, "abc") == true
    prove GlobEx.match?(~g|??c|, "def") == false
    prove GlobEx.match?(~g|???|, "abc") == true
    prove GlobEx.match?(~g|???|, "def") == true
    prove GlobEx.match?(~g|???|, "abcdef") == false
    prove GlobEx.match?(~g|ab?cd|, "ab/cd") == false
    prove GlobEx.match?(~g|abc?|, "abc") == false
    prove GlobEx.match?(~g|?abc|, "abc") == false
    prove GlobEx.match?(~g|?abc|, ".abc") == false
    prove GlobEx.match?(~g|?abc|d, ".abc") == true

    prove GlobEx.match?(~g|*|, "foo") == true
    prove GlobEx.match?(~g|*|, ".foo") == false
    prove GlobEx.match?(~g|*|d, ".foo") == true
    prove GlobEx.match?(~g|*|, "foo/bar") == false
    prove GlobEx.match?(~g|*/*|, "foo/bar") == true
    prove GlobEx.match?(~g|*/*|, "foo") == false
    prove GlobEx.match?(~g|*/*|, "foo/bar/baz") == false
    prove GlobEx.match?(~g|abc/*|, "abc/def") == true
    prove GlobEx.match?(~g|abc/*|, "def/abc") == false
    prove GlobEx.match?(~g|*/def|, "abc/def") == true
    prove GlobEx.match?(~g|*/def|, "def/abc") == false

    prove GlobEx.match?(~g|**|, "foo") == true
    prove GlobEx.match?(~g|**|, ".foo") == false
    prove GlobEx.match?(~g|**|d, ".foo") == true
    prove GlobEx.match?(~g|**|, "foo/bar") == true
    prove GlobEx.match?(~g|**|, "foo/bar/baz") == true
    prove GlobEx.match?(~g|**|, "foo/.bar") == false
    prove GlobEx.match?(~g|**|d, "foo/.bar") == true
    prove GlobEx.match?(~g|**/**|, "foo") == true
    prove GlobEx.match?(~g|**/**|, ".foo") == false
    prove GlobEx.match?(~g|**/**|d, ".foo") == true
    prove GlobEx.match?(~g|**/**|, "foo/bar") == true
    prove GlobEx.match?(~g|**/**|, "foo/bar/baz") == true
    prove GlobEx.match?(~g|**/**|, "foo/.bar") == false
    prove GlobEx.match?(~g|**/**|d, "foo/.bar") == true
    prove GlobEx.match?(~g|**/**/*.txt|, "foo/bar.txt") == true
    prove GlobEx.match?(~g|**/**/*.txt|, "foo/.bar.txt") == false
    prove GlobEx.match?(~g|**/**/*.txt|d, "foo/.bar.txt") == true
    prove GlobEx.match?(~g|**/**/*.txt|, "foo/bar.json") == false
    prove GlobEx.match?(~g|**/**/*.txt|, "foo/.zzz/bar.txt") == false
    prove GlobEx.match?(~g|**/**/*.txt|d, "foo/.zzz/bar.txt") == true
    prove GlobEx.match?(~g|a/**|, "a/b/c") == true
    prove GlobEx.match?(~g|c/d**/foo.txt|, "c/d/foo.txt") == true
    prove GlobEx.match?(~g|c/d**/foo.txt|, "c/d/e/foo.txt") == false
    prove GlobEx.match?(~g|c/d*/foo.txt|, "c/d/foo.txt") == true
    prove GlobEx.match?(~g|c/d*/foo.txt|, "c/d/e/foo.txt") == false

    prove GlobEx.match?(~g|foo|, "foo") == true
    prove GlobEx.match?(~g|foo|, "foo/") == true
    prove GlobEx.match?(~g|foo/|, "foo") == true
    prove GlobEx.match?(~g|foo/|, "foo/") == true
    prove GlobEx.match?(~g|foo/**|, "foo") == false
    prove GlobEx.match?(~g|foo/**|, "foo/") == false
    prove GlobEx.match?(~g|foo/**/*|, "foo") == false
    prove GlobEx.match?(~g|foo/**/*|, "foo/") == false

    prove GlobEx.match?(~g|[a-c]z|, "az") == true
    prove GlobEx.match?(~g|[a-c]z|, "zz") == false
    prove GlobEx.match?(~g|[a-c][0-5]|, "b5") == true
    prove GlobEx.match?(~g|[a-c][0-5]|, "b6") == false
    prove GlobEx.match?(~g|[a-c][0-5]|, "c1") == true
    prove GlobEx.match?(~g|[a-c][0-5]|, ".c1") == false
    prove GlobEx.match?(~g|.[a-c][0-5]|d, ".c1") == true
    prove GlobEx.match?(~g|a[0-23]|d, "a0") == true
    prove GlobEx.match?(~g|a[0-23]|d, "a1") == true
    prove GlobEx.match?(~g|a[0-23]|d, "a2") == true
    prove GlobEx.match?(~g|a[0-23]|d, "a3") == true
    prove GlobEx.match?(~g|a[0-23]|d, "a4") == false
    prove GlobEx.match?(~g|a[0-23]|d, "a23") == false
    prove GlobEx.match?(~g|a[b,c]|d, "a,") == true
    prove GlobEx.match?(~g|a[b,c]|d, "ac") == true
    prove GlobEx.match?(~g|a[b,c]|d, "az") == false

    prove GlobEx.match?(~g|{abc,def}|, "abc") == true
    prove GlobEx.match?(~g|{abc,def}|, "def") == true
    prove GlobEx.match?(~g|{abc,def}|, "ghi") == false
    prove GlobEx.match?(~g|z{abc,def}z|, "zabcz") == true
    prove GlobEx.match?(~g|z{abc,def}z|, "zdefz") == true
    prove GlobEx.match?(~g|z{abc,def}z|, "zghiz") == false

    # Elixir project
    prove GlobEx.match?(~g|{lib,test}/**/*.{ex,exs}|, "test/elixir/calendar/holocene.exs") == true
    prove GlobEx.match?(~g|{lib,test}/**/*.{ex,exs}|, "lib/module/types/of.ex") == true
    prove GlobEx.match?(~g|{lib,test}/**/*.{ex,exs}|, "scripts/foo.ex") == false
    prove GlobEx.match?(~g|{lib,test}/**/*.{ex,exs}|, "lib/foo/go.java") == false

    # related to test "matching with pattern [] for a compoent"
    prove GlobEx.match?(~g|a/[a-z]/c|, "a/x/c") == true
    prove GlobEx.match?(~g|a/[a-z]/c|, "a/z/c") == true
    prove GlobEx.match?(~g|a/[a-z]/c|, "a/xyz/c") == false
    prove GlobEx.match?(~g|a/[xyz]/c|, "a/x/c") == true
    prove GlobEx.match?(~g|a/[xyz]/c|, "a/z/c") == true
    prove GlobEx.match?(~g|a/[xyz]/c|, "a/xyz/c") == false
    prove GlobEx.match?(~g|a/[y-z]/c|, "a/z/c") == true
    prove GlobEx.match?(~g|a/[y-z]/c|, "a/x/c") == false

    # related to test "matching with pattern [] (tricky characters)"
    prove GlobEx.match?(~g|a[]|, "aA") == false
    prove GlobEx.match?(~g|a[A-C-]|, "aA") == true
    prove GlobEx.match?(~g|a[A-C-]|, "a-") == true
    prove GlobEx.match?(~g|a[\[]|, "a[") == true
    prove GlobEx.match?(~g|a[\[\]-]|, "a-") == true
    prove GlobEx.match?(~g|a[\[\]-]|, "a[") == true
    prove GlobEx.match?(~g|a[\[\]-]|, "a]") == true
    prove GlobEx.match?(~g|a[\[\]-]|, "aA") == false
    prove GlobEx.match?(~g|a[][A-C-]|, "a-") == true
    prove GlobEx.match?(~g|a[][A-C-]|, "aA") == true
    prove GlobEx.match?(~g|a[][A-C-]|, "aD") == false
    prove GlobEx.match?(~g|a[][A-C-]|, "a[") == true
    prove GlobEx.match?(~g|a[][A-C-]|, "a]") == true
    prove GlobEx.match?(~g|a[\-]|, "a-") == true

    # related to test "mathcing ** in different deeps"
    prove GlobEx.match?(~g|{a1,a2}/**/*{oo,ar}|, "a1/abc/foo") == true
    prove GlobEx.match?(~g|{a1,a2}/**/*{oo,ar}|, "a2/def/bar") == true
    prove GlobEx.match?(~g|{a1,a2}/**/*{oo,ar}|, "a2/def/bar/foo") == true
    prove GlobEx.match?(~g|{a1,a2}/**/*{oo,ar}|, "a2/def/foo") == true
    prove GlobEx.match?(~g|{a1,a2}/**/*{oo,ar}|, "a2/def/foo/bar") == true
    prove GlobEx.match?(~g|{a1,a2}/**/*{oo,ar}|, "a2/abc/def/ghi") == false

    # related to test "escape characters using \\"
    prove GlobEx.match?(~g|\{a*|, "{abc}") == true
    prove GlobEx.match?(~g|\{a*|, "[abc]") == false
    prove GlobEx.match?(~g|\{abc}|, "{abc}") == true
    prove GlobEx.match?(~g|\{abc}|, "{abc]") == false
    prove GlobEx.match?(~g|[a-z]*|, "z---") == true
    prove GlobEx.match?(~g|[a-z]*|, "----") == false
    prove GlobEx.match?(~g|[a\-z]*|, "----") == true
    prove GlobEx.match?(~g|@{a\,b,c}|, "@a") == false
    prove GlobEx.match?(~g|@{a\,b,c}|, "@a,b") == true
    prove GlobEx.match?(~g|@{a\,b,c}|, "@c") == true
    prove GlobEx.match?(~g|@{a,b,c}|, "@a") == true

    # related to test "with '@/..' and '..'"
    prove GlobEx.match?(~g|@*/../@*|, "@/../@") == true
    prove GlobEx.match?(~g|@*/../@*|, "@foo/../@bar") == true
    prove GlobEx.match?(~g|@*/../@*|, "@foo/../../@bar") == false

    # starting with root
    prove GlobEx.match?(~g|/user/*|, "/user/karlo") == true
    prove GlobEx.match?(~g|/user/*|, "/kater/karlo") == false
    prove GlobEx.match?(~g|/*/karlo|, "/kater/karlo") == true
    prove GlobEx.match?(~g|/*/karlo|, "kater/karlo") == false
    prove GlobEx.match?(~g|/*/karlo|, "/gustav/gans") == false
    prove GlobEx.match?(~g|/a/**|d, "/a/b") == true
    prove GlobEx.match?(~g|/a/**|d, "/a/b/c") == true

    # partly exact path
    prove GlobEx.match?(~g|a/b/**|, "a/b/c") == true
    prove GlobEx.match?(~g|a/b/**|, "a/b/c/d") == true
    prove GlobEx.match?(~g|a/b/**|, "a/x/c/d") == false
    prove GlobEx.match?(~g|a/b/**|, "x/b/c/d") == false
    prove GlobEx.match?(~g|a/*/c/d|, "a/x/c/d") == true
    prove GlobEx.match?(~g|a/*/c/d|, "a/x/c/x") == false

    # related to test "with an explicit .file in glob" 
    prove GlobEx.match?(~g|.foo.txt|, ".foo.txt") == true
    prove GlobEx.match?(~g|*/.foo.txt|, ".foo.txt") == false
    prove GlobEx.match?(~g|*/.foo.txt|, "bar/.foo.txt") == false
    prove GlobEx.match?(~g|**/.foo.txt|, ".foo.txt") == false
    prove GlobEx.match?(~g|**/.foo.txt|, "bar/.foo.txt") == false
    prove GlobEx.match?(~g|bar/.foo.txt|, "bar/.foo.txt") == true
    prove GlobEx.match?(~g|/.foo.txt|, "/.foo.txt") == true
    prove GlobEx.match?(~g|/*/.foo.txt|, "/.foo.txt") == false
    prove GlobEx.match?(~g|/*/.foo.txt|, "/bar/.foo.txt") == false
    prove GlobEx.match?(~g|/**/.foo.txt|, "/.foo.txt") == false
    prove GlobEx.match?(~g|/**/.foo.txt|, "/bar/.foo.txt") == false
    prove GlobEx.match?(~g|/bar/.foo.txt|, "/bar/.foo.txt") == true
  end

  defp ls(glob, opts \\ []) do
    match_dot = Keyword.get(opts, :match_dot, false)
    wildcard_files = Path.wildcard(glob, match_dot: match_dot)
    ls_files = glob |> GlobEx.compile!(match_dot: match_dot) |> GlobEx.ls()

    # update wildcard_files for glob '**/**' to hide a bug in OTP 22.3
    wildcard_files = if glob == "**/**", do: Enum.uniq(wildcard_files), else: wildcard_files

    if wildcard_files != ls_files do
      raise """
      Path.wildcard/2 != GlobEx.ls/2
      glob: #{inspect(glob)}
      wc: #{inspect(wildcard_files)}
      ls: #{inspect(ls_files)}
      """
    end

    ls_files
  end

  defp mkfiles(files) do
    Enum.each(files, fn file ->
      dirname = Path.dirname(file)
      File.mkdir_p!(dirname)
      File.touch(file)
    end)
  end

  defp unix? do
    case :os.type() do
      {:unix, _} -> true
      _ -> false
    end
  end
end
