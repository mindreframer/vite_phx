defmodule Vite do
  @moduledoc """
  Documentation for `Vite`.
  """
  alias Vite.View
  alias Vite.React

  defdelegate vite_client, to: View
  defdelegate vite_snippet(entry_name), to: View
  defdelegate inlined_phx_manifest, to: View
  defdelegate react_refresh_snippet, to: React

  def is_prod() do
    Vite.Config.current_env() == :prod
  end
end
