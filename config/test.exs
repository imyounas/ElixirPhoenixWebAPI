import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :todo_api, TodoApiWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "oz7Yc2WThfy0OlIqbIV2yyfCs/GgGJPKpZhyJtijf5U5T8F6OR/6BPx0HqDu6u9G",
  server: false

# In test we don't send emails
config :todo_api, TodoApi.Mailer, adapter: Swoosh.Adapters.Test

# Disable swoosh api client as it is only required for production adapters
config :swoosh, :api_client, false

# Print only warnings and errors during test
config :logger, level: :warning

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
