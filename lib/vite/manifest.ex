defmodule Vite.Manifest do
  @moduledoc """
  Basic parser for Vite.js manifests
  See for more details:
  - https://vitejs.dev/guide/backend-integration.html
  - https://github.com/vitejs/vite/blob/main/packages/vite/src/node/plugins/manifest.ts

  """
  alias Vite.ManifestReader
  alias Vite.Entry
  require Logger

  @type entry_value :: binary() | list(binary()) | nil

  @spec read() :: map()
  def read() do
    ManifestReader.read_vite()
  end

  @spec entries() :: [Entry.t()]
  def entries() do
    read()
    |> Enum.filter(&isEntry/1)
    |> Enum.map(fn {_, value} -> value end)
    |> Enum.map(&from_raw/1)
  end

  @spec entry(binary()) :: Entry.t()
  def entry(entry_name) do
    Enum.find(entries(), &(&1.name == entry_name))
  end

  @spec isEntry({any, map()}) :: boolean()
  defp isEntry({_key, value}) do
    Map.get(value, "isEntry") == true
  end

  # %{
  #   "css" => ["assets/main.c14674d5.css"],
  #   "file" => "assets/main.9160cfe1.js",
  #   "imports" => ["_vendor.3b127d10.js"],
  #   "isEntry" => true,
  #   "src" => "src/main.tsx"
  # }
  defp from_raw(raw) do
    %Entry{
      name: Map.get(raw, "src"),
      file: Map.get(raw, "file"),
      cssfiles: Map.get(raw, "css"),
      imports: Map.get(raw, "imports", []) |> Enum.map(&get_file/1)
    }
  end

  @spec get_file(binary()) :: entry_value()
  def get_file(file) do
    read() |> get_in([file, "file"]) |> raise_missing(file)
  end

  @spec get_css(binary()) :: entry_value()
  def get_css(file) do
    read() |> get_in([file, "css"]) |> raise_missing(file)
  end

  @spec get_imports(binary()) :: entry_value()
  def get_imports(file) do
    entries = read() |> get_in([file, "imports"])

    cond do
      entries == nil -> raise_missing(nil, file)
      is_list(entries) -> entries |> Enum.map(&get_file/1)
    end
  end

  @spec raise_missing(entry_value(), binary()) :: entry_value()
  defp raise_missing(check, file) do
    if is_nil(check) do
      raise("Could not find an entry for #{file} in the manifest!")
    else
      check
    end
  end
end
