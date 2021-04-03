use Mix.Config

# Do not print debug messages in production
config :logger, level: :info

import_config "releases.exs"
