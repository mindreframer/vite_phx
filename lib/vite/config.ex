defmodule Vite.Config do
  alias Vite.Cache
  require Logger

  @doc """
  specified in vite.config.js in build.rollupOptions.input
  """
  def main_file() do
    Application.get_env(:vite, :main_file) || "src/main.tsx"
  end

  def endpoint() do
    Application.get_env(:vite, :endpoint) ||
      Logger.error(
        "Configuration for Vite endpoint missing! Provide via: `config :vite, :endpoint, MyAppWeb.Endpoint`"
      )
  end

  def current_env() do
    Application.get_env(:vite, :environment, :dev)
  end

  def json_library() do
    Application.get_env(:vite, :json_library, Phoenix.json_library())
  end

  def manifest_path() do
    Application.get_env(:vite, :cache_static_manifest) ||
      endpoint().config(:cache_static_manifest) || "priv/static/cache_manifest.json"
  end

  def manifest_path(file) do
    Application.put_env(:vite, :cache_static_manifest, file)
    Cache.purge()
  end
end
