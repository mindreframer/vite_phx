defmodule Vite do
  @moduledoc """
  Documentation for `Vite`.
  """
  alias Vite.{Config, Manifest}

  @spec main_js() :: binary()
  def main_js() do
    Manifest.get_file(Config.main_file())
  end

  @spec main_css() :: binary()
  def main_css() do
    Manifest.get_css(Config.main_file())
  end

  @spec vendor_js() :: binary()
  def vendor_js() do
    Manifest.get_imports(Config.main_file()) |> Enum.at(0)
  end
end
