defmodule Vite do
  @moduledoc """
  Documentation for `Vite`.
  """
  alias Vite.View

  defdelegate vite_client, to: View
  defdelegate vite_snippet(entry_name), to: View
end
