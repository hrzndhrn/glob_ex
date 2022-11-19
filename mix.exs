defmodule GlobEx.MixProject do
  use Mix.Project

  def project do
    [
      app: :glob_ex,
      version: "0.1.0",
      elixir: "~> 1.11",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      preferred_cli_env: preferred_cli_env(),
      aliases: aliases(),
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: preferred_cli_env()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp preferred_cli_env do
    [
      carp: :test,
      coveralls: :test,
      "coveralls.detail": :test,
      "coveralls.post": :test,
      "coveralls.html": :test
    ]
  end

  defp aliases do
    [
      carp: ["test --seed 0 --max-failures 1"]
    ]
  end

  defp deps do
    [
      # only dev/test
      {:benchee_dsl, "~> 0.3", only: [:dev, :test]},
      {:benchee_markdown, "~> 0.1", only: :dev},
      {:credo, "~> 1.6", only: :dev, runtime: false},
      {:ex_doc, "~> 0.21", only: :dev, runtime: false},
      {:excoveralls, "~> 0.10", only: :test, runtime: false},
      {:path_glob, "~> 0.2", only: :dev},
      {:prove, "~> 0.1.3", only: [:dev, :test]}
    ]
  end
end
