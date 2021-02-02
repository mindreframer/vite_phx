defmodule Vite.View do
  @moduledoc """
  Help with View integration into Phoenix views
  """
  alias Vite.Entry
  alias Vite.Config

  @doc """
  Generate all links for an entry struct in following order:

    1. styles to prevent FOUC
    2. main entry script
    3. imports

  `
  <link phx-track-static rel="stylesheet" href="<%= Vite.Manifest.main_css() %>"/>
  <script type="module" crossorigin defer phx-track-static src="<%=  Vite.Manifest.main_js() %>"></script>
  <link rel="modulepreload" href="<%= Vite.Manifest.vendor_js() %>">
  `
  """
  @spec for_entry(Entry.t(), binary()) :: binary()
  def for_entry(entry = %Entry{}, prefix \\ "/") do
    script = entry.file |> module_script(prefix)
    imports = entry.imports |> Enum.map(&module_preload(&1, prefix)) |> Enum.join("\n")
    css_files = entry.cssfiles |> Enum.map(&css_link(&1, prefix)) |> Enum.join("\n")
    [css_files, script, imports] |> Enum.join("\n")
  end

  @spec for_entries(list(Entry.t())) :: binary()
  def for_entries(entries, prefix \\ "/") do
    entries |> Enum.map(&for_entry(&1, prefix)) |> Enum.join("\n")
  end

  @spec module_preload(binary(), binary()) :: binary()
  def module_preload(href, prefix) do
    ~s(<link rel="modulepreload" href="#{prefix <> href}">)
  end

  @spec css_link(binary(), binary()) :: binary()
  def css_link(href, prefix) do
    ~s{<link phx-track-static rel="stylesheet" href="#{prefix <> href}"/>}
  end

  @spec module_script(binary(), binary()) :: binary()
  def module_script(src, prefix) do
    ~s{<script type="module" crossorigin defer phx-track-static src="#{prefix <> src}"></script>}
  end

  def vite_client() do
    case Config.current_env() do
      :prod -> ""
      _ -> ~s(<script type="module" src="#{Config.dev_server_address()}/@vite/client"></script>) |> as_safe()
    end
  end

  def vite_snippet(entry_name) do
    case Config.current_env() do
      :prod -> Vite.Manifest.entry(entry_name) |> for_entry() |> as_safe()
      _ -> ~s(<script type="module" src="#{Config.dev_server_address()}/#{entry_name}"></script>) |> as_safe()
    end
  end

  defp as_safe(s), do: {:safe, s}
end
