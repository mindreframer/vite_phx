import Config

secret_key_base =
  System.get_env("SECRET_KEY_BASE") ||
    raise """
    environment variable SECRET_KEY_BASE is missing.
    You can generate one by calling: mix phx.gen.secret
    """

# Keep all Endpoint configs as runtime configuration for simplicity
config :demo, DemoWeb.Endpoint,
  http: [
    port: String.to_integer(System.get_env("PORT") || "4000"),
    transport_options: [socket_opts: [:inet6]]
  ],
  secret_key_base: secret_key_base,
  url: [host: "example.com", port: 80],
  # this is needed for our LiveSocket / Websockets
  check_origin: ["https://example.com", "//localhost:4000"],
  cache_static_manifest: "priv/static/cache_manifest.json"

# start HTTP server
config :demo, DemoWeb.Endpoint, server: true
