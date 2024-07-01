defmodule Vite.ManifestTest do
  use ExUnit.Case
  alias Vite.Manifest
  alias Vite.Config

  describe "entries/0" do
    test "nested" do
      Config.vite_manifest("test/fixtures/nested-imports.json")

      assert Manifest.entries() ==
               [
                 [
                   {:entry_name, "src/main-nested.tsx"},
                   {:module, "assets/inertia.071fd92e.js"},
                   {:import_css, "assets/dynamic-import-polyfill.0f681641.css"},
                   {:import_module, "assets/dynamic-import-polyfill.b75f6adf.js"},
                   {:import_module, "assets/vendor.2c7f0e08.js"}
                 ],
                 [
                   {:entry_name, "src/main.tsx"},
                   {:css, "assets/main.aba08cbf.css"},
                   {:module, "assets/main.aef2b0ab.js"},
                   {:import_css, "assets/dynamic-import-polyfill.0f681641.css"},
                   {:import_module, "assets/dynamic-import-polyfill.b75f6adf.js"},
                   {:import_module, "assets/vendor.2c7f0e08.js"}
                 ]
               ]

      assert Manifest.entry("src/main.tsx") ==
               [
                 {:entry_name, "src/main.tsx"},
                 {:css, "assets/main.aba08cbf.css"},
                 {:module, "assets/main.aef2b0ab.js"},
                 {:import_css, "assets/dynamic-import-polyfill.0f681641.css"},
                 {:import_module, "assets/dynamic-import-polyfill.b75f6adf.js"},
                 {:import_module, "assets/vendor.2c7f0e08.js"}
               ]
    end

    test "circular" do
      Config.vite_manifest("test/fixtures/circular-imports.json")

      assert Manifest.entries() ==
               [
                 [
                   {:entry_name, "src/main.tsx"},
                   {:css, "assets/main-DuLJnGy9.css"},
                   {:module, "assets/main-Di0ERxQQ.js"},
                   {:import_module, "assets/module_a-UvMMXHBe.js"},
                   {:import_module, "assets/module_c-CEsvvVSb.js"},
                   {:import_module, "assets/module_b-BL0iFxLQ.js"}
                 ]
               ]

      assert Manifest.entry("src/main.tsx") ==
               [
                 {:entry_name, "src/main.tsx"},
                 {:css, "assets/main-DuLJnGy9.css"},
                 {:module, "assets/main-Di0ERxQQ.js"},
                 {:import_module, "assets/module_a-UvMMXHBe.js"},
                 {:import_module, "assets/module_c-CEsvvVSb.js"},
                 {:import_module, "assets/module_b-BL0iFxLQ.js"}
               ]
    end
  end
end
