defmodule Vite.PhxManifestReader do
  @moduledoc """
  Finding proper path for `cache_manifest.json` in releases is a non-trivial operation,
  so we keep this logic in a dedicated module
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
    app = Config.release_app()
    vite_manifest = Config.vite_manifest()
    full_manifest_path = Application.app_dir(app, vite_manifest)

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
