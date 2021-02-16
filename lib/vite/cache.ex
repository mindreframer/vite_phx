defmodule Vite.Cache do
  @spec get(any()) :: any()
  def get(key) do
    :persistent_term.get(namespaced(key), nil)
  end

  @spec put(any(), any()) :: any()
  def put(key, value) do
    :persistent_term.put(namespaced(key), value)
  end

  @spec purge(any()) :: boolean()
  def purge(key) do
    :persistent_term.erase(namespaced(key))
  end

  defp namespaced(key), do: {:vite, key}
end
