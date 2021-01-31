defmodule Vite.Manifest do
  @moduledoc """
  Basic and incomplete parser for Vite.js manifests
  See for more details:
  - https://vitejs.dev/guide/backend-integration.html
  - https://github.com/vitejs/vite/blob/main/packages/vite/src/node/plugins/manifest.ts

  """
  alias Vite.PhxManifestReader
  require Logger

  @spec read() :: map()
  def read() do
    PhxManifestReader.read()
  end

  def entries() do
  end

  @spec get_file(binary()) :: binary()
  def get_file(file) do
    read() |> get_in([file, "file"]) |> raise_missing(file) |> prepend_slash()
  end

  @spec get_css(binary()) :: [binary()]
  def get_css(file) do
    read() |> get_in([file, "css"]) |> raise_missing(file) |> Enum.map(&prepend_slash/1)
  end

  @spec get_imports(binary()) :: list(binary())
  def get_imports(file) do
    entries = read() |> get_in([file, "imports"])

    cond do
      entries == nil -> raise_missing(nil, file)
      is_list(entries) -> entries |> Enum.map(&get_file/1)
    end
  end

  @spec prepend_slash(binary()) :: binary()
  defp prepend_slash(result) do
    "/" <> result
  end

  @spec raise_missing(binary() | nil, binary()) :: binary()
  defp raise_missing(check, file) do
    if is_nil(check) do
      raise("Could not find an entry for #{file} in the manifest!")
    else
      check
    end
  end
end
