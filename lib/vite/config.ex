defmodule Vite.Config do
  alias Vite.Cache
  require Logger

  def all() do
    %{
      release_app: release_app(),
      current_env: current_env(),
      vite_manifest: vite_manifest(),
      json_library: json_library(),
      dev_server_address: dev_server_address()
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

  def vite_manifest() do
    Application.get_env(:vite_phx, :vite_manifest) || "priv/static/manifest.json"
  end

  def vite_manifest(file) do
    Application.put_env(:vite_phx, :vite_manifest, file)
    Cache.purge()
  end

  def dev_server_address() do
    Application.get_env(:vite_phx, :dev_server_address) || "http://localhost:3000"
  end

  def json_library() do
    Application.get_env(:vite_phx, :json_library, Phoenix.json_library())
  end
end
