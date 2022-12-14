defmodule GlobEx do
  @moduledoc """
  Provides glob expressions for Elixir.

  A glob expression looks like an ordinary path, except that the following
  "wildcard characters" are interpreted in a special way:

    * `?` - matches one character.
    * `*` - matches any number of characters up to the end of the filename, the
      next dot, or the next slash.
    * `**` - two adjacent `*`'s used as a single pattern will match all
      files and zero or more directories and subdirectories.
    * `[char1,char2,...]` - matches any of the characters listed; two
      characters separated by a hyphen will match a range of characters.
      Do not add spaces before and after the comma as it would then match
      paths containing the space character itself.
    * `{item1,item2,...}` - matches one of the alternatives.
      Do not add spaces before and after the comma as it would then match
      paths containing the space character itself.

  Other characters represent themselves. Only paths that have
  exactly the same character in the same position will match. Note
  that matching is case-sensitive: `"a"` will not match `"A"`.

  Directory separators must always be written as `/`, even on Windows.
  You may call `Path.expand/1` to normalize the path before invoking
  this function.

  A character preceded by \ loses its special meaning.
  Note that \ must be written as \\ in a string literal.
  For example, "\\?*" will match any filename starting with ?.

  Glob expressions in can be created using `compile/2`, `compile!/2` or the
  sigils ~g (see `GlobEx.Sigils.sigil_g/2`) or ~G (see
  `GlobEx.Sigils.sigil_G/2`).

  ```elixir
  # A simple glob expressions matching all `.exs` files in a tree. By default,
  # the patterns `*` and `?` do not match files starting with a `.`.
  ~g|**/*.exs|

  # The modifier `d` let the glob treat files starting with a `.` as any other
  # file.
  ~g|**/*.exs|d
  ```
  """

  alias GlobEx.CompileError
  alias GlobEx.Compiler

  defstruct source: "", match_dot: false, compiled: []

  @type t :: %__MODULE__{source: binary(), match_dot: boolean(), compiled: [term()]}

  @cwd '.'

  @doc """
  Compiles the glob expression and raises GlobEx.CompileError in case of errors.

  See the module documentation for how to write a glob expression and
  `compile/2` for the available options.
  """
  @spec compile!(binary(), keyword()) :: t()
  def compile!(glob, opts \\ []) do
    case compile(glob, opts) do
      {:ok, glob} -> glob
      {:error, exception} -> raise exception
    end
  end

  @doc """
  Compiles the glob expression.

  It returns `{:ok, regex}` in case of success, `{:error, reason}` otherwise.

  See the module documentation for how to write a glob expression.

  By default, the patterns `*` and `?` do not match files starting with a `.`.
  This behaviour can be change with the option `:match_dot`.

  ## Options

    * `:match_dot` - (boolean) if `false`, the special wildcard characters `*` and `?`
      will not match files starting with a `.`. If `true`, files starting with
      a `.` will not be treated specially. Defaults to `false`.

  ## Examples

      iex> GlobEx.compile("src/**/?oo.ex")
      {:ok, ~g|src/**/?oo.ex|}

      iex> GlobEx.compile("src/{a,b/?oo.ex")
      {:error, %GlobEx.CompileError{reason: {:missing_delimiter, 5}}}
  """
  @spec compile(binary(), keyword()) :: {:ok, t()} | {:error, CompileError.t()}
  def compile(glob, opts \\ []) do
    match_dot = Keyword.get(opts, :match_dot, false)

    case Compiler.compile(glob) do
      {:ok, compiled} ->
        {:ok, %GlobEx{source: glob, compiled: compiled, match_dot: match_dot}}

      {:error, reason} ->
        {:error, %CompileError{reason: reason}}
    end
  end

  @doc """
  Traverses paths according to the given `glob` expression and returns a list of
  matches.

  See the module documentation for how to write a glob expression.

  ## Examples

      iex> GlobEx.ls(~g|{lib,test}/**/*.{ex,exs}|)
      [
        "lib/glob_ex.ex",
        "lib/glob_ex/compiler.ex",
        "lib/glob_ex/compiler_error.ex",
        "lib/glob_ex/sigils.ex",
        "test/glob_ex/compiler_test.exs",
        "test/glob_ex_test.exs",
        "test/test_helper.exs"
      ]
  """
  @spec ls(t()) :: [Path.t()]
  def ls(%GlobEx{compiled: compiled, match_dot: match_dot}) do
    compiled
    |> list(match_dot, [@cwd])
    |> Enum.map(&IO.chardata_to_string/1)
    |> Enum.sort()
  end

  @doc """
  Returns a boolean indicating whether there was a match or not.

  See the module documentation for how to write a glob expression.

  ## Examples

      iex> GlobEx.match?(~g|{lib,test}/**/*.{ex,exs}|, "lib/foo/bar.ex")
      true

      iex> GlobEx.match?(~g|{lib,test}/**/*.{ex,exs}|, "lib/foo/bar.java")
      false
  """
  @spec match?(t(), Path.t()) :: boolean()
  def match?(%GlobEx{compiled: compiled, match_dot: match_dot}, path) do
    path = split(path, [[]])
    match?(compiled, match_dot, path)
  end

  defp match?([{:exact, '..'} | glob], match_dot, [comp | path]) do
    if '..' == comp, do: match?(glob, match_dot, path), else: false
  end

  defp match?([:double_star], _match_dot, []) do
    true
  end

  defp match?([:double_star], true, _path) do
    true
  end

  defp match?([:double_star] = glob, false, [comp | path]) do
    comp = Enum.reverse(comp)

    if hd(comp) == ?., do: false, else: match?(glob, false, path)
  end

  defp match?([:double_star, pattern | rest] = glob, match_dot, [comp | path]) do
    comp = Enum.reverse(comp)

    with true <- match_dot?(comp, match_dot) do
      case match_comp?(comp, pattern) do
        true -> match?(rest, match_dot, path) or match?(glob, match_dot, path)
        false -> match?(glob, match_dot, path)
      end
    end
  end

  defp match?([{:exact, exact}], _match_dot, path) do
    path = Enum.map(path, &Enum.reverse/1) |> :filename.join()

    exact == path
  end

  defp match?([], _match_dot, []) do
    true
  end

  defp match?([], _match_dot, _path) do
    false
  end

  defp match?(_glob, _match_dot, []) do
    false
  end

  defp match?([pattern | glob], match_dot, [comp | path]) do
    comp = Enum.reverse(comp)

    with true <- match_comp?(comp, match_dot, pattern) do
      match?(glob, match_dot, path)
    end
  end

  defp list([], _match_dot, result) do
    result
  end

  defp list([:double_star], match_dot, matches) do
    trees(matches, match_dot)
  end

  defp list([:double_star, :star | glob], match_dot, matches) do
    list([:double_star | glob], match_dot, matches)
  end

  defp list([:double_star, next | glob], match_dot, matches) do
    matches = double_star_matches(matches, match_dot, next, [])
    list(glob, match_dot, matches)
  end

  defp list([{:exact, '..'} | glob], match_dot, matches) do
    matches =
      Enum.reduce(matches, [], fn match, acc ->
        case :filelib.is_dir(match) do
          true -> [join(match, '..') | acc]
          false -> acc
        end
      end)

    list(glob, match_dot, matches)
  end

  defp list([{:exact, file} | glob], match_dot, [@cwd]) do
    case file_exists?(file) do
      true -> list(glob, match_dot, [file])
      false -> []
    end
  end

  defp list([pattern | glob], match_dot, matches) do
    matches = matches(matches, match_dot, pattern)
    list(glob, match_dot, matches)
  end

  defp matches(matches, match_dot, pattern) do
    Enum.reduce(matches, [], fn match, acc ->
      match
      |> list_dir()
      |> Enum.reduce([], fn comp, acc ->
        case match_comp?(comp, match_dot, pattern) do
          true -> [join(match, comp) | acc]
          false -> acc
        end
      end)
      |> Enum.concat(acc)
    end)
  end

  defp match_comp?([?. | _rest], false, _pattern) do
    false
  end

  defp match_comp?(comp, _match_dot, pattern) do
    match_comp?(comp, pattern)
  end

  defp match_comp?(comp, {:exact, exact}) do
    exact == comp
  end

  defp match_comp?(_comp, :star) do
    true
  end

  defp match_comp?(comp, {:seq, seq}) do
    seq?(seq, comp)
  end

  defp match_comp?(comp, {:ends_with, ends_with}) do
    ends_with?(comp, ends_with)
  end

  defp match_comp?(comp, {:alt, alt}) do
    Enum.any?(alt, fn
      :empty -> true
      [pattern] -> match_comp?(comp, pattern)
    end)
  end

  defp match_comp?([comp], {:one_of, one_of}) do
    comp in one_of
  end

  defp match_comp?(_comp, {:one_of, _one_of}) do
    false
  end

  defp match_dot?([?. | _charlist], false) do
    false
  end

  defp match_dot?(_charlist, _match_dot) do
    true
  end

  defp join(@cwd, right) do
    right
  end

  defp join(left, right) do
    left ++ '/' ++ right
  end

  defp seq?([:star], _file) do
    true
  end

  defp seq?([x | seq], [x | file]) do
    seq?(seq, file)
  end

  defp seq?([:question | seq], [_x | file]) do
    seq?(seq, file)
  end

  defp seq?([], []) do
    true
  end

  defp seq?([_ | _], []) do
    false
  end

  defp seq?([:star, next | seq], [next | file]) do
    seq?(seq, file)
  end

  defp seq?([:star, next | _rest] = seq, [_char | file]) when is_integer(next) do
    seq?(seq, file)
  end

  defp seq?([:star | seq], file) do
    with false <- seq?(seq, file) do
      seq?([:star | seq], tl(file))
    end
  end

  defp seq?([{:alt, _alt} = pattern], file) do
    match_comp?(file, pattern)
  end

  defp seq?([{:one_of, one_of} | seq], [char | file]) do
    with true <- char in one_of do
      seq?(seq, file)
    end
  end

  defp seq?(_seq, _file) do
    false
  end

  defp ends_with?(a, b) do
    a |> Enum.reverse() |> do_ends_with(b)
  end

  defp do_ends_with(_a, []) do
    true
  end

  defp do_ends_with([x | as], [x | bs]) do
    do_ends_with(as, bs)
  end

  defp do_ends_with(_a, _b) do
    false
  end

  defp list_dir(cwd) do
    case :file.list_dir(cwd) do
      {:ok, files} -> files
      {:error, _reason} -> []
    end
  end

  defp trees(dirs, match_dot) do
    trees(dirs, match_dot, [])
  end

  defp trees([], _match_dot, acc) do
    acc
  end

  defp trees(dirs, match_dot, acc) do
    dirs = dirs(dirs, match_dot)
    trees(dirs, match_dot, dirs ++ acc)
  end

  defp dirs(dirs, match_dot) do
    Enum.reduce(dirs, [], fn dir, acc ->
      case list_dir(dir) do
        [] -> acc
        list -> sub_dirs(list, dir, match_dot, acc)
      end
    end)
  end

  defp sub_dirs(sub_dirs, dir, match_dot, acc) do
    sub_dirs
    |> Enum.reduce([], fn sub_dir, sub_dirs ->
      case match_dot?(sub_dir, match_dot) do
        true -> [join(dir, sub_dir) | sub_dirs]
        false -> sub_dirs
      end
    end)
    |> Enum.concat(acc)
  end

  defp double_star_matches([], _match_dot, _pattern, acc), do: acc

  defp double_star_matches(matches, match_dot, pattern, acc) do
    {matches, acc} =
      Enum.reduce(matches, {[], acc}, fn match, {matches, acc} ->
        match
        |> list_dir()
        |> Enum.reduce({matches, acc}, fn item, {matches, acc} ->
          double_star_match(item, match_dot, pattern, match, matches, acc)
        end)
      end)

    double_star_matches(matches, match_dot, pattern, acc)
  end

  defp double_star_match([?. | _rest], false, _pattern, _match, matches, acc) do
    {matches, acc}
  end

  defp double_star_match(item, _match_dot, pattern, match, matches, acc) do
    path = join(match, item)

    case match_comp?(item, pattern) do
      true -> {[path | matches], [path | acc]}
      false -> {[path | matches], acc}
    end
  end

  defp split(<<>>, acc) do
    Enum.reverse(acc)
  end

  defp split(<<?/>>, acc) do
    Enum.reverse(acc)
  end

  defp split(<<?/, rest::binary>>, acc) do
    split(rest, [[] | acc])
  end

  defp split(<<char::utf8, rest::binary>>, [comp | acc]) do
    split(rest, [[char | comp] | acc])
  end

  defp file_exists?(file) do
    # On Windows, "pathname/.." will seem to exist even if pathname does not
    # refer to a directory.
    case :os.type() do
      {:win32, _} -> do_file_exists?(file)
      _else -> File.exists?(file)
    end
  end

  defp do_file_exists?(file) do
    file
    |> IO.chardata_to_string()
    |> split([[]])
    |> do_file_exists?(@cwd)
  end

  defp do_file_exists?([comp, '..' | path], acc) do
    dir = :filename.join(acc, Enum.reverse(comp))

    case :filelib.is_dir(dir) do
      true -> do_file_exists?(path, :filename.join(dir, '..'))
      false -> false
    end
  end

  defp do_file_exists?([comp | path], acc) do
    acc = :filename.join(acc, Enum.reverse(comp))
    do_file_exists?(path, acc)
  end

  defp do_file_exists?([], acc), do: File.exists?(acc)

  @doc false
  # Unescape map function used by Macro.unescape_string.
  def unescape_map(:newline), do: true
  def unescape_map(?f), do: ?\f
  def unescape_map(?n), do: ?\n
  def unescape_map(?r), do: ?\r
  def unescape_map(?t), do: ?\t
  def unescape_map(?v), do: ?\v
  def unescape_map(?a), do: ?\a
  def unescape_map(_), do: false

  defimpl Inspect do
    def inspect(%{source: source, match_dot: match_dot}, _opts) do
      modifier = if match_dot, do: "d", else: ""

      {escaped, _} =
        source
        |> normalize(<<>>)
        |> Code.Identifier.escape(?|, :infinity, &escape_map/1)

      IO.iodata_to_binary([?~, ?g, ?|, escaped, ?|, modifier])
    end

    defp normalize(<<?\\, ?\\, rest::binary>>, acc),
      do: normalize(rest, <<acc::binary, ?\\, ?\\>>)

    defp normalize(<<?\\, ?|, rest::binary>>, acc), do: normalize(rest, <<acc::binary, ?|>>)
    defp normalize(<<char, rest::binary>>, acc), do: normalize(rest, <<acc::binary, char>>)
    defp normalize(<<>>, acc), do: acc

    defp escape_map(?\a), do: [?\\, ?a]
    defp escape_map(?\f), do: [?\\, ?f]
    defp escape_map(?\n), do: [?\\, ?n]
    defp escape_map(?\r), do: [?\\, ?r]
    defp escape_map(?\t), do: [?\\, ?t]
    defp escape_map(?\v), do: [?\\, ?v]
    defp escape_map(_), do: false
  end
end
