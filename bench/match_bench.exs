defmodule MatchBench do
  use BencheeDsl.Benchmark

  @title "Benchmark GlobEx.match?/2"
  @description """
  Comparing `GlobEx.match?/2` with `PathGlob.match?/2`.

  [PathGlob](https://hex.pm/packages/path_glob) is a great package to check if a
  glob expression matches a path. The approach here is to transform the glob into
  a regex.
  """

  formatter Benchee.Formatters.Markdown,
    file: Path.join([__DIR__, "reports", Macro.underscore(__MODULE__) <> ".md"]),
    description: @description

  @repetition 1..10_000
  @path "lib/module/types/of.ex"
  @glob "{lib,test}/**/*.{ex,exs}"

  job "GlobEx.match?/2" do
    for _ <- @repetition do
      @glob |> GlobEx.compile!() |> GlobEx.match?(@path)
    end
  end

  job "PathGlob.match?/2" do
    for _ <- @repetition do
      PathGlob.match?(@path, @glob)
    end
  end
end
