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

  @doc """
  # copy from
  - `defp cache_static_manifest(endpoint)` in Phoenix.Endpoint.Supervisor
  - https://github.com/phoenixframework/phoenix/blob/a206768ff4d02585cda81a2413e922e1dc19d556/lib/phoenix/endpoint/supervisor.ex#L411
  """
  def read(:prod) do
    endpoint = Config.endpoint()

    if inner = endpoint.config(:cache_static_manifest) do
      {app, inner} =
        case inner do
          {_, _} = inner -> inner
          inner when is_binary(inner) -> {endpoint.config(:otp_app), inner}
          _ -> raise ArgumentError, ":cache_static_manifest must be a binary or a tuple"
        end

      outer = Application.app_dir(app, inner)

      if File.exists?(outer) do
        outer |> File.read!() |> Phoenix.json_library().decode!()
      else
        Logger.error(
          "Could not find static manifest at #{inspect(outer)}. " <>
            "Run \"mix phx.digest\" after building your static files " <>
            "or remove the configuration from \"config/prod.exs\"."
        )
      end
    else
      %{}
    end
  end

  def read(_) do
    File.read!(Config.manifest_path()) |> Phoenix.json_library().decode!()
  end
end
