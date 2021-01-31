defmodule Vite.Entry do
  @moduledoc """
  %Vite.Entry{
    name: "src/main.tsx",
    file: "assets/main.9160cfe1.js",
    cssfiles: ["assets/main.c14674d5.css"],
    imports: ["assets/vendor.3b127d10.js"]
  }
  """
  defstruct name: nil, file: nil, cssfiles: [], imports: []

  @type t :: %Vite.Entry{}
end
