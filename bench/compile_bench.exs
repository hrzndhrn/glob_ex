defmodule CompileBench do
  use BencheeDsl.Benchmark

  @title "Benchmark GlobEx.ls/1 with compiled glob"

  @description """
  Comparing compiled glob with a glob string.
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

  @glob "{lib,test}/**/*.{ex,exs}"
  @compiled_glob GlobEx.compile!(@glob)

  job glob_string, do: @glob |> GlobEx.compile!() |> GlobEx.ls()

  job compiled_glob, do: GlobEx.ls(@compiled_glob)
end
