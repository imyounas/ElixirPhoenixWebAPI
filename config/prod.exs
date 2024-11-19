import Config

# Configures Swoosh API Client
config :swoosh, api_client: Swoosh.ApiClient.Finch, finch_name: TodoApi.Finch

# Disable Swoosh Local Memory Storage
config :swoosh, local: false

# Do not print debug messages in production
config :logger, level: :info

# Runtime production configuration, including reading
# of environment variables, is done on config/runtime.exs.

config :todo_api, TodoApiWeb.Endpoint,
  url: [host: "localhost"],
  cache_static_manifest: "priv/static/cache_manifest.json"

# Disable request logging
# config :phoenix, :logger, false

# Or if you want to be more specific about what to disable:
config :logger, :console,
  level: :warning  # This will only show warnings and errors