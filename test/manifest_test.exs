defmodule Vite.ManifestTest do
  use ExUnit.Case
  alias Vite.Manifest
  alias Vite.Config

  describe "read" do
    test "delegatees to PhxManifestReader" do
      Config.manifest_path("test/fixtures/basic-2.0.0-beta.58.json")
      assert is_map(Manifest.read())
    end
  end

  describe "get_file/1" do
    test "will return the corresponding file subkey for a top-level entry" do
      Config.manifest_path("test/fixtures/basic-2.0.0-beta.58.json")
      assert Manifest.get_file("src/main.tsx") == "/assets/main.9160cfe1.js"
    end

    test "raises on missing keys" do
      Config.manifest_path("test/fixtures/basic-2.0.0-beta.58.json")

      assert_raise RuntimeError,
                   "Could not find an entry for src/nope.tsx in the manifest!",
                   fn ->
                     Manifest.get_file("src/nope.tsx")
                   end
    end
  end

  describe "get_css/1" do
    test "will return the corresponding file subkey for a top-level entry" do
      Config.manifest_path("test/fixtures/basic-2.0.0-beta.58.json")
      assert Manifest.get_css("src/main.tsx") == ["/assets/main.c14674d5.css"]
    end

    test "raises on missing keys" do
      Config.manifest_path("test/fixtures/basic-2.0.0-beta.58.json")

      assert_raise RuntimeError,
                   "Could not find an entry for src/nope.tsx in the manifest!",
                   fn ->
                     Manifest.get_css("src/nope.tsx")
                   end
    end
  end

  describe "get_imports/1" do
    test "will return the corresponding file subkey for a top-level entry" do
      Config.manifest_path("test/fixtures/basic-2.0.0-beta.58.json")
      assert Manifest.get_imports("src/main.tsx") == ["/assets/vendor.3b127d10.js"]
    end

    test "raises on missing keys" do
      Config.manifest_path("test/fixtures/basic-2.0.0-beta.58.json")

      assert_raise RuntimeError,
                   "Could not find an entry for src/nope.tsx in the manifest!",
                   fn ->
                     Manifest.get_imports("src/nope.tsx")
                   end
    end
  end
end
