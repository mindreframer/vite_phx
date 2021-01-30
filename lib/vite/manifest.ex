defmodule Vite.Manifest do
  @moduledoc """
  Basic and incomplete parser for Vite.js manifests
  See for more details:
  - https://vitejs.dev/guide/backend-integration.html
  - https://github.com/vitejs/vite/blob/main/packages/vite/src/node/plugins/manifest.ts

  Sample content for the manifest:
  `
  {
    "src/main.tsx": {
      "file": "assets/main.046c02cc.js",
      "src": "src/main.tsx",
      "isEntry": true,
      "imports": [
        "_vendor.ef08aed3.js"
      ],
      "css": "assets/main.54797e95.css"
    },
    "_vendor.ef08aed3.js": {
      "file": "assets/vendor.ef08aed3.js"
    }
  }
  `
  """
  alias Vite.PhxManifestReader
  require Logger

  @spec read() :: map()
  def read() do
    PhxManifestReader.read()
  end

  @spec get_file(binary()) :: binary()
  def get_file(file) do
    read() |> get_in([file, "file"]) |> prepend_slash(file)
  end

  @spec get_css(binary()) :: binary()
  def get_css(file) do
    read() |> get_in([file, "css"]) |> prepend_slash(file)
  end

  @spec get_imports(binary()) :: list(binary())
  def get_imports(file) do
    entries = read() |> get_in([file, "imports"])

    cond do
      entries == nil -> raise("Could not find an entry for #{file} in the manifest!")
      is_list(entries) -> entries |> Enum.map(&get_file/1)
    end
  end

  @spec prepend_slash(binary() | nil, binary()) :: binary()
  defp prepend_slash(result, orig_file) do
    cond do
      result == nil -> raise("Could not find an entry for #{orig_file} in the manifest!")
      true -> "/" <> result
    end
  end
end
