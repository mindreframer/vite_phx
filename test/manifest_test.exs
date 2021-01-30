defmodule Vite.ManifestTest do
  use ExUnit.Case
  alias Vite.Manifest
  alias Vite.Config

  describe "read" do
    test "delegatees to PhxManifestReader" do
      Config.manifest_path("test/fixtures/basic01.json")
      assert is_map(Manifest.read())
    end
  end

  describe "get_file/1" do
    test "will return the corresponding file subkey for a top-level entry" do
      Config.manifest_path("test/fixtures/basic01.json")
      assert Manifest.get_file("src/main.tsx") == "/assets/main.046c02cc.js"
    end

    test "raises on missing keys" do
      Config.manifest_path("test/fixtures/basic01.json")

      assert_raise RuntimeError,
                   "Could not find an entry for src/nope.tsx in the manifest!",
                   fn ->
                     Manifest.get_file("src/nope.tsx")
                   end
    end
  end

  describe "get_css/1" do
    test "will return the corresponding file subkey for a top-level entry" do
      Config.manifest_path("test/fixtures/basic01.json")
      assert Manifest.get_css("src/main.tsx") == "/assets/main.54797e95.css"
    end

    test "raises on missing keys" do
      Config.manifest_path("test/fixtures/basic01.json")

      assert_raise RuntimeError,
                   "Could not find an entry for src/nope.tsx in the manifest!",
                   fn ->
                     Manifest.get_css("src/nope.tsx")
                   end
    end
  end

  describe "get_imports/1" do
    test "will return the corresponding file subkey for a top-level entry" do
      Config.manifest_path("test/fixtures/basic01.json")
      assert Manifest.get_imports("src/main.tsx") == ["/assets/vendor.ef08aed3.js"]
    end

    test "raises on missing keys" do
      Config.manifest_path("test/fixtures/basic01.json")

      assert_raise RuntimeError,
                   "Could not find an entry for src/nope.tsx in the manifest!",
                   fn ->
                     Manifest.get_imports("src/nope.tsx")
                   end
    end
  end
end
