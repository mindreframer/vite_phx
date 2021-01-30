# Vite

Vite helps you to integrate [Vite.js](https://vitejs.dev) with Phoenix.


## Configuration

```elixir
# in config/config.exs

config :vite,
  main_file: "src/main.tsx",
  endpoint: MyAppWeb.Endpoint,
  environment: Mix.env(),
  json_library: Jason,
  cache_static_manifest: "priv/static/cache_manifest.json"
```

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `vite` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:vite, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/vite](https://hexdocs.pm/vite).
