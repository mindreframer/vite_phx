import Config

IO.puts("loading config/releases.exs")

secret_key_base =
  System.get_env("SECRET_KEY_BASE") ||
    raise """
    environment variable SECRET_KEY_BASE is missing.
    You can generate one by calling: mix phx.gen.secret
    """

# Keep all Endpoint configs as runtime configuration for simplicity
config :demo, DemoWeb.Endpoint,
  http: [port: {:system, "PORT"}],
  force_ssl: [rewrite_on: [:x_forwarded_proto]],
  secret_key_base: secret_key_base,
  url: [scheme: "https", host: "vite-phoenix.herokuapp.com", port: 443],
  # this is needed for our LiveSocket / Websockets
  check_origin: ["https://example.com", "//localhost:4000", "//vite-phoenix.herokuapp.com"],
  cache_static_manifest: "priv/static/cache_manifest.json"

# start HTTP server
config :demo, DemoWeb.Endpoint, server: true
