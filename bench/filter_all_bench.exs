defmodule FilterAllBench do
  use BencheeDsl.Benchmark

  import GlobEx.Sigils
   
  @title "Benchmark GlobEx.ls/1 with filter all"

  @description """
  TODO
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

  inputs %{"timestamp" => DateTime.utc_now() |> DateTime.to_unix()}

  job "filter with GlobEx.ls/2", now do
    GlobEx.ls(~g|**/*.ex|, fn path ->
      File.dir?(path) || File.stat!(path, time: :posix).mtime > now
    end)
  end

  job "filter after GlobEx.ls/2", now do
    ~g|**/*.ex|
    |> GlobEx.ls()
    |> Enum.filter(fn path -> File.stat!(path, time: :posix).mtime > now end)
  end
end
