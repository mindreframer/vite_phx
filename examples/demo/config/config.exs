# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

# Configures the endpoint
config :demo, DemoWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "A0xid91CuqIR01sqbAwgJFXmIeQG2dPcRCOarSLHpppgUwOA5kxc5Yn04slpih3X",
  render_errors: [view: DemoWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Demo.PubSub,
  live_view: [signing_salt: "CbTNUYgA"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Configure Vite
config :vite_phx,
  main_file: "src/main.tsx",
  # required get the :cache_static_manifest config
  endpoint: DemoWeb.Endpoint,
  # to tell prod and dev env appart
  environment: Mix.env(),
  # optional
  cache_static_manifest: "priv/static/cache_manifest.json"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
