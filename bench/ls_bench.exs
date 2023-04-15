defmodule LsBench do
  use BencheeDsl.Benchmark

  @title "Benchmark GlobEx.ls/1"

  @description """
  Comparing `GlobEx.ls/1` with `Path.wildcard/2`.
  """

  formatter Benchee.Formatters.Markdown,
    file: Path.join([__DIR__, "reports", Macro.underscore(__MODULE__) <> ".md"]),
    description: @description

  setup do
    cwd = File.cwd!()
    File.cd("tmp/bench")

    on_exit(fn ->
      File.cd(cwd)
    end)
  end

  inputs do
    globs = [
      "{lib,test}/**/*.{ex,exs}",
      "{lib,test}/**/*.java",
      "**/enum.ex",
      "**/enum*",
      "mix.exs"
    ]

    Enum.into(globs, %{}, fn input -> {input, input} end)
  end

  job "GlobEx.ls/1", glob do
    glob |> GlobEx.compile!() |> GlobEx.ls()
  end

  job "Path.wildcard/2", glob do
    Path.wildcard(glob)
  end
end
