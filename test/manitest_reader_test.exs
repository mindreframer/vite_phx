defmodule Vite.ManifestReaderTest do
  use ExUnit.Case

  alias Vite.ManifestReader
  alias Vite.ManifestReader.ManifestNotFoundError

  describe "read_vite/0" do
    test "to raise on missing file in `:prod` mode" do
      assert_raise ManifestNotFoundError, fn ->
        ManifestReader.read_vite(:prod)
      end
    end
  end
end
