defmodule Vite.ManifestTest do
  use ExUnit.Case
  alias Vite.Manifest
  alias Vite.Config

  describe "read/0" do
    test "delegatees to PhxManifestReader" do
      Config.vite_manifest("test/fixtures/basic-2.0.0-beta.58.json")
      assert is_map(Manifest.read())
    end
  end

  describe "entries/0" do
    test "will collect only entry items and convert to Entry structs" do
      Config.vite_manifest("test/fixtures/basic-2.0.0-beta.58.json")

      assert Manifest.entries() == [
               %Vite.ManifestItem{
                 cssfiles: ["assets/main.c14674d5.css"],
                 is_entry: true,
                 file: "assets/main.9160cfe1.js",
                 imports: ["assets/vendor.3b127d10.js"],
                 name: "src/main.tsx"
               }
             ]
    end
  end

  describe "get_file/1" do
    test "will return the corresponding file subkey for a top-level entry" do
      Config.vite_manifest("test/fixtures/basic-2.0.0-beta.58.json")
      assert Manifest.get_file("src/main.tsx") == "assets/main.9160cfe1.js"
    end

    test "raises on missing keys" do
      Config.vite_manifest("test/fixtures/basic-2.0.0-beta.58.json")

      assert_raise RuntimeError,
                   "Could not find an entry for src/nope.tsx in the manifest!",
                   fn ->
                     Manifest.get_file("src/nope.tsx")
                   end
    end
  end

  describe "get_css/1" do
    test "will return the corresponding file subkey for a top-level entry" do
      Config.vite_manifest("test/fixtures/basic-2.0.0-beta.58.json")
      assert Manifest.get_css("src/main.tsx") == ["assets/main.c14674d5.css"]
    end

    test "will return a default empty list, if CSS is missing in the manifest" do
      Config.vite_manifest("test/fixtures/empty-css.json")
      assert Manifest.get_css("src/main.tsx") == []
    end

    test "return an empty list, even if NO entry could be found" do
      Config.vite_manifest("test/fixtures/basic-2.0.0-beta.58.json")
      assert Manifest.get_css("src/nope.tsx") == []
    end
  end

  describe "get_imports/1" do
    test "will return the corresponding file subkey for a top-level entry" do
      Config.vite_manifest("test/fixtures/basic-2.0.0-beta.58.json")
      assert Manifest.get_imports("src/main.tsx") == ["assets/vendor.3b127d10.js"]
    end

    test "raises on missing keys" do
      Config.vite_manifest("test/fixtures/basic-2.0.0-beta.58.json")

      assert_raise RuntimeError,
                   "Could not find an entry for src/nope.tsx in the manifest!",
                   fn ->
                     Manifest.get_imports("src/nope.tsx")
                   end
    end

    test "works with nested imports" do
      Config.vite_manifest("test/fixtures/nested_imports.json")

      assert Manifest.get_imports("src/main-nested.tsx") == [
               "assets/dynamic-import-polyfill.b75f6adf.js",
               "assets/vendor.2c7f0e08.js"
             ]
    end
  end
end
