defmodule Vite.Config do
  alias Vite.Cache
  require Logger

  def all() do
    %{
      release_app: release_app(),
      current_env: current_env(),
      vite_manifest: vite_manifest(),
      phx_manifest: phx_manifest(),
      json_library: json_library(),
      dev_server_address: dev_server_address(),
      full_vite_manifest: full_vite_manifest(),
      full_phx_manifest: full_phx_manifest()
    }
  end

  def release_app() do
    Application.get_env(:vite_phx, :release_app) ||
      Logger.error(
        "Configuration for Vite release_app missing! Provide via: `config :vite_phx, :release_app, :my_app`"
      )
  end

  def current_env() do
    Application.get_env(:vite_phx, :environment, :dev)
  end

  def phx_manifest() do
    Application.get_env(:vite_phx, :phx_manifest) || "priv/static/cache_manifest.json"
  end

  def phx_manifest(file) do
    Application.put_env(:vite_phx, :phx_manifest, file)
    Cache.purge(:phx_manifest)
  end

  def vite_manifest() do
    Application.get_env(:vite_phx, :vite_manifest) || "priv/static/manifest.json"
  end

  def vite_manifest(file) do
    Application.put_env(:vite_phx, :vite_manifest, file)
    Cache.purge(:vite_manifest)
  end

  def dev_server_address() do
    Application.get_env(:vite_phx, :dev_server_address) || "http://localhost:3000"
  end

  def json_library() do
    Application.get_env(:vite_phx, :json_library, Phoenix.json_library())
  end

  def full_vite_manifest() do
    in_release_path(vite_manifest())
  end

  def full_phx_manifest() do
    in_release_path(phx_manifest())
  end

  def in_release_path(file) do
    Application.app_dir(release_app(), file)
  end
end
