defmodule Vite.View do
  @moduledoc """
  Help with View integration into Phoenix views
  """
  alias Vite.{Config, Entry}

  @doc """
  The snippet for `@vite/client` during development. Does nothing in :prod env.
  """
  @spec vite_client :: binary() | {:safe, binary()}
  def vite_client() do
    case Config.current_env() do
      :prod ->
        ""

      _ ->
        ~s(<script type="module" src="#{Config.dev_server_address()}/@vite/client"></script>)
        |> as_safe()
    end
  end

  @doc """
  The complete snippet for a single entry-point during prod. Delegates to vite dev-server otherwise. See `:for_entry` for details.
  """
  @spec vite_snippet(binary()) :: binary() | {:safe, binary()}
  def vite_snippet(entry_name) do
    case Config.current_env() do
      :prod ->
        Vite.Manifest.entry(entry_name) |> for_entry() |> as_safe()

      _ ->
        ~s(<script type="module" src="#{Config.dev_server_address()}/#{entry_name}"></script>)
        |> as_safe()
    end
  end

  @doc """
  Generate all links for an entry struct in following order:

    1. styles to prevent FOUC
    2. main entry script
    3. imports

  `
  <link phx-track-static rel="stylesheet" href="/assets/main.34asdfsf.css"/>
  <script type="module" crossorigin defer phx-track-static src="/assets/main.89abc777.js"></script>
  <link rel="modulepreload" href="/assets/_vendor.7788aaa.js">
  `
  """
  @spec for_entry(Entry.t(), binary()) :: binary()
  def for_entry(entry = %Entry{}, prefix \\ "/") do
    script = entry.file |> module_script(prefix)
    imports = entry.imports |> Enum.map(&module_preload(&1, prefix)) |> Enum.join("\n")
    css_files = entry.cssfiles |> Enum.map(&css_link(&1, prefix)) |> Enum.join("\n")
    [css_files, script, imports] |> Enum.join("\n")
  end

  @doc """
  Helper to get HTML for all entry points at once
  """
  @spec for_entries(list(Entry.t())) :: binary()
  def for_entries(entries, prefix \\ "/") do
    entries |> Enum.map(&for_entry(&1, prefix)) |> Enum.join("\n")
  end

  @doc """
  Helper to generate HTML for module preloading, eg:

  `
  <link rel="modulepreload" href="/a-module.js">
  `
  """
  @spec module_preload(binary(), binary()) :: binary()
  def module_preload(href, prefix) do
    ~s(<link rel="modulepreload" href="#{prefix <> href}">)
  end

  @doc """
  Helper to generate HTML for a CSS link with static tracking:

  `
  <link phx-track-static rel="stylesheet" href="/some-styles.css"/>
  `
  """
  @spec css_link(binary(), binary()) :: binary()
  def css_link(href, prefix) do
    ~s{<link phx-track-static rel="stylesheet" href="#{prefix <> href}"/>}
  end

  @doc """
  Helper to generate HTML for JS modules

  Has automatic inclusion of `defer`, `crossorigin` and `phx-track-static` attributes.

  `
  <script type="module" crossorigin defer phx-track-static src="/module.js"></script>
  `
  """
  @spec module_script(binary(), binary()) :: binary()
  def module_script(src, prefix) do
    ~s{<script type="module" crossorigin defer phx-track-static src="#{prefix <> src}"></script>}
  end

  defp as_safe(s), do: {:safe, s}
end
