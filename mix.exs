defmodule Vite.MixProject do
  use Mix.Project

  @version "0.1.0"
  @elixir_requirement "~> 1.9"


  def project do
    [
      app: :vite_phx,
      version: @version,
      elixir: @elixir_requirement,
      start_permanent: Mix.env() == :prod,
      preferred_cli_env: [docs: :docs],
      deps: deps(),
      docs: docs(),
      package: package(),
    ]
  end

  defp package do
    [
      maintainers: ["Roman Heinrich"],
      licenses: ["MIT"],
      links: %{github: "https://github.com/mindreframer/vite_phx"},
      files:
        ~w(lib priv CHANGELOG.md LICENSE.md mix.exs README.md .formatter.exs)
    ]
  end

  def application do
    [
      extra_applications: [:logger],
      mod: {Vite.Application, []}
    ]
  end

  defp deps do
    [
      {:phoenix, ">= 0.0.0", only: [:dev, :test]},
      {:jason, ">= 0.0.0", only: [:dev, :test]},
      {:dialyxir, "~> 1.0", only: [:dev], runtime: false},

      # Docs dependencies (some for cross references)
      {:ex_doc, "~> 0.22", only: :docs},
    ]
  end
end
