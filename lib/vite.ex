defmodule Vite do
  @moduledoc """
  Documentation for `Vite`.
  """
  alias Vite.View

  defdelegate vite_client, to: View
  defdelegate vite_snippet(entry_name), to: View
  defdelegate inline_phx_manifest, to: View

  def is_prod() do
    Vite.Config.current_env() == :prod
  end
end
