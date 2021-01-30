# Vite

[![Build Status](https://github.com/mindreframer/vite_phx/workflows/CI/badge.svg)](https://github.com/mindreframer/vite_phx/actions?query=workflow%3A%22CI%22)

Vite helps you to integrate [Vite.js](https://vitejs.dev) with Phoenix.


## Configuration

```elixir
# in config/config.exs

config :vite_phx,
  main_file: "src/main.tsx",
  endpoint: MyAppWeb.Endpoint, # required get the :cache_static_manifest config
  environment: Mix.env(), # to tell prod and dev env appart
  cache_static_manifest: "priv/static/cache_manifest.json" # optional
```

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `vite` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:vite_phx, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/vite](https://hexdocs.pm/vite).
