defmodule Vite.Cache do
  @cache_key {:vite, "cache_manifest"}

  @spec get() :: any()
  def get() do
    :persistent_term.get(@cache_key, nil)
  end

  @spec put(any()) :: any()
  def put(v) do
    :persistent_term.put(@cache_key, v)
  end

  @spec purge() :: boolean()
  def purge() do
    :persistent_term.erase(@cache_key)
  end
end
