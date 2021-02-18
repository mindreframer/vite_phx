defmodule Vite.MixProject do
  use Mix.Project

  @version "0.2.1"
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
      package: package()
    ]
  end

  defp package do
    [
      maintainers: ["Roman Heinrich"],
      description: "vite_phx helps to integrate Vite.js into your Phoenix app",
      licenses: ["MIT"],
      links: %{Github: "https://github.com/mindreframer/vite_phx"},
      files: ~w(lib CHANGELOG.md LICENSE.md mix.exs README.md .formatter.exs)
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
      {:phoenix, ">= 0.0.0"},
      {:jason, ">= 0.0.0", optional: true},
      {:dialyxir, "~> 1.0", only: [:dev], runtime: false},

      # Docs dependencies (some for cross references)
      {:ex_doc, "~> 0.22", only: :docs, runtime: false}
    ]
  end

  def docs() do
    [
      source_ref: "v#{@version}",
      extra_section: "GUIDES",
      formatters: ["html", "epub"],
      extras: extras()
    ]
  end

  def extras do
    [
      "guides/introduction.md",
      "guides/setup.md",
      "guides/faq.md"
    ]
  end
end
