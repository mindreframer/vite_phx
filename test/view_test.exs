defmodule Vite.ViewTest do
  use ExUnit.Case
  alias Vite.View
  alias Vite.ManifestItem

  def entry(1) do
    %ManifestItem{
      name: "src/main.tsx",
      file: "assets/main.9160cfe1.js",
      cssfiles: ["assets/main.c14674d5.css"],
      imports: ["assets/vendor.3b127d10.js"]
    }
  end

  def entry(2) do
    %ManifestItem{
      name: "src/main.js",
      file: "assets/main.9160cfe1.js",
      cssfiles: ["assets/main.c14674d5.css", "assets/main.c33345b3.css"],
      imports: ["assets/vendor.3b127d10.js", "assets/vendor.bbddaa33.js"]
    }
  end

  def entry(3) do
    %ManifestItem{
      name: "src/main.js",
      file: "assets/main.9160cfe1.js",
      cssfiles: [],
      imports: ["assets/vendor.3b127d10.js", "assets/vendor.bbddaa33.js"]
    }
  end

  def no_lf(s), do: String.replace(s, "\n", "")
  def no_indent(s), do: Regex.replace(~r/^\s+/m, s, "")
  def strip(s), do: s |> no_indent() |> no_lf()

  describe "for_entry/1" do
    test "generates the complete markup to include scripts (1)" do
      e = entry(1)

      assert View.for_entry(e) |> strip() ==
               ~S{
          <link phx-track-static rel="stylesheet" href="/assets/main.c14674d5.css"/>
          <script type="module" crossorigin defer phx-track-static src="/assets/main.9160cfe1.js"></script>
          <link rel="modulepreload" href="/assets/vendor.3b127d10.js">
        } |> strip()
    end

    test "generates the complete markup to include scripts (2)" do
      e = entry(2)

      assert View.for_entry(e) |> strip() ==
               ~S{
          <link phx-track-static rel="stylesheet" href="/assets/main.c14674d5.css"/>
          <link phx-track-static rel="stylesheet" href="/assets/main.c33345b3.css"/>
          <script type="module" crossorigin defer phx-track-static src="/assets/main.9160cfe1.js"></script>
          <link rel="modulepreload" href="/assets/vendor.3b127d10.js">
          <link rel="modulepreload" href="/assets/vendor.bbddaa33.js">
        } |> strip()
    end

    test "generates the complete markup to include scripts (3)" do
      e = entry(3)

      assert View.for_entry(e) |> strip() ==
               ~S{
          <script type="module" crossorigin defer phx-track-static src="/assets/main.9160cfe1.js"></script>
          <link rel="modulepreload" href="/assets/vendor.3b127d10.js">
          <link rel="modulepreload" href="/assets/vendor.bbddaa33.js">
        } |> strip()
    end
  end
end
