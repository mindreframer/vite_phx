defmodule Vite.Config do
  alias Vite.Cache
  require Logger

  def all() do
    %{
      endpoint: endpoint(),
      main_file: main_file(),
      current_env: current_env(),
      json_library: json_library(),
      manifest_path: manifest_path(),
      dev_server_address: dev_server_address()
    }
  end

  @doc """
  specified in vite.config.js in build.rollupOptions.input
  """
  def main_file() do
    Application.get_env(:vite_phx, :main_file) || "src/main.tsx"
  end

  def dev_server_address() do
    Application.get_env(:vite_phx, :dev_server_address) || "http://localhost:3000"
  end

  def endpoint() do
    Application.get_env(:vite_phx, :endpoint) ||
      Logger.error(
        "Configuration for Vite endpoint missing! Provide via: `config :vite_phx, :endpoint, MyAppWeb.Endpoint`"
      )
  end

  def current_env() do
    Application.get_env(:vite_phx, :environment, :dev)
  end

  def json_library() do
    Application.get_env(:vite_phx, :json_library, Phoenix.json_library())
  end

  def manifest_path() do
    Application.get_env(:vite_phx, :cache_static_manifest) ||
      endpoint().config(:cache_static_manifest) || "priv/static/cache_manifest.json"
  end

  def manifest_path(file) do
    Application.put_env(:vite_phx, :cache_static_manifest, file)
    Cache.purge()
  end
end
