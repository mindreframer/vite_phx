defmodule Vite.ManifestReader do
  @moduledoc """
  Finds `manifest.json` in releases, keeps the content in-memory
  """
  alias Vite.{Cache, Config}
  require Logger

  def read() do
    case Cache.get() do
      nil ->
        res = read(Config.current_env())
        Cache.put(res)
        res

      res ->
        res
    end
  end

  def read(:prod) do
    full_manifest_path = Config.full_vite_manifest()

    if File.exists?(full_manifest_path) do
      full_manifest_path |> File.read!() |> Phoenix.json_library().decode!()
    else
      Logger.error(
        "Could not find static manifest at #{inspect(full_manifest_path)}. " <>
          "Run \"mix phx.digest\" after building your static files " <>
          "or remove the configuration from \"config/prod.exs\"."
      )
    end
  end

  def read(_) do
    File.read!(Config.vite_manifest()) |> Config.json_library().decode!()
  end
end
