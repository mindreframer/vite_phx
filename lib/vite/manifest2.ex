defmodule Vite.Manifest2 do
  alias Vite.ManifestReader
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
    |> Enum.map(fn entry -> convert_item([], entry) end)
  end

  @spec entry(binary()) :: Entry.t()
  def entry(entry_name) do
    Enum.find(entries(), &(Keyword.get(&1, :entry_name) == entry_name))
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
  defp convert_item(acc, raw_data) do
    css = Map.get(raw_data, "css", [])
    entry_name = Map.get(raw_data, "src")
    imports = Map.get(raw_data, "imports", [])
    acc = acc ++ [{:entry_name, entry_name}]
    acc = acc ++ Enum.map(css, fn file -> {:css, file} end)
    acc = acc ++ [{:module, Map.get(raw_data, "file")}]
    acc = Enum.reduce(imports, acc, fn file, innerAcc -> handle_import(innerAcc, file) end)
    acc |> Enum.uniq()
  end

  defp convert_item(acc, raw_data, :import) do
    css = Map.get(raw_data, "css", [])
    imports = Map.get(raw_data, "imports", [])
    acc = acc ++ Enum.map(css, fn file -> {:import_css, file} end)
    acc = acc ++ [{:import_module, Map.get(raw_data, "file")}]
    acc = Enum.reduce(imports, acc, fn file, innerAcc -> handle_import(innerAcc, file) end)
    acc |> Enum.uniq()
  end

  @spec get_file(binary()) :: entry_value()
  def get_file(file) do
    read() |> get_in([file, "file"]) |> raise_missing(file)
  end

  def handle_import(acc, file) do
    raw_data = read() |> Map.get(file)
    convert_item(acc, raw_data, :import)
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
