defmodule Vite.ViewTest do
  use ExUnit.Case
  alias Vite.View
  alias Vite.Manifest
  alias Vite.Config

  def no_lf(s), do: String.replace(s, "\n", "")
  def no_indent(s), do: Regex.replace(~r/^\s+/m, s, "")
  def strip(s), do: s |> no_indent() |> no_lf()

  describe "for_entry/1" do
    test "generates the complete markup to include scripts (1)" do
      Config.vite_manifest("test/fixtures/nested-imports.json")
      e = Manifest.entry("src/main.tsx")

      assert View.for_entry(e) |> strip() ==
               ~S{
                <link phx-track-static rel="stylesheet" href="/assets/main.aba08cbf.css"/>
                <script type="module" crossorigin defer phx-track-static src="/assets/main.aef2b0ab.js"></script>
                <link phx-track-static rel="stylesheet" href="/assets/dynamic-import-polyfill.0f681641.css"/>
                <link rel="modulepreload" href="/assets/dynamic-import-polyfill.b75f6adf.js">
                <link rel="modulepreload" href="/assets/vendor.2c7f0e08.js">
        } |> strip()
    end

    test "generates the complete markup to include scripts - 2" do
      Config.vite_manifest("test/fixtures/basic-2.0.0.json")
      e = Manifest.entry("src/main.tsx")

      assert View.for_entry(e) |> strip() ==
               ~S{
                <link phx-track-static rel="stylesheet" href="/assets/main.c14674d5.css"/>
                <script type="module" crossorigin defer phx-track-static src="/assets/main.9160cfe1.js"></script>
                <link rel="modulepreload" href="/assets/vendor.3b127d10.js">
        } |> strip()
    end
  end
end
