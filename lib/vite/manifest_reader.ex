defmodule Vite.ManifestReader do
  @moduledoc """
  Finds `manifest.json` in releases, keeps the content in-memory
  """
  alias Vite.{Cache, Config}

  defmodule ManifestNotFoundError do
    defexception [:manifest_file]

    @impl true
    def message(e) do
      """
      Could not find static manifest at #{inspect(e.manifest_file)}.
        Run "mix phx.digest" after building your static files
        or remove the configuration from "config/prod.exs".
      """
    end
  end

  def read_vite() do
    case Cache.get(:vite_manifest) do
      nil ->
        res = read_vite(Config.current_env())
        Cache.put(:vite_manifest, res)
        res

      res ->
        res
    end
  end

  def read_vite(:prod) do
    full_vite_manifest = Config.full_vite_manifest()

    if File.exists?(full_vite_manifest) do
      full_vite_manifest |> File.read!() |> Config.json_library().decode!()
    else
      raise ManifestNotFoundError, manifest_file: full_vite_manifest
    end
  end

  def read_vite(_) do
    File.read!(Config.vite_manifest()) |> Config.json_library().decode!()
  end

  def read_phx() do
    case Cache.get(:phx_manifest) do
      nil ->
        res = read_phx(Config.current_env())
        Cache.put(:phx_manifest, res)
        res

      res ->
        res
    end
  end

  def read_phx(:prod) do
    File.read!(Config.full_phx_manifest()) |> Config.json_library().decode!()
  end

  def read_phx(_) do
    ""
  end
end
