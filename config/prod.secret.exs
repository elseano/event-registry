use Mix.Config

# In this file, we keep production configuration that
# you likely want to automate and keep it away from
# your version control system.
config :event_registry, EventRegistry.Endpoint,
  secret_key_base: "rI1IH827rWbYo4zezWJvFQo0FLuQ5TJTmSx+YBe30490HK2JxZeicskzFtzRV1jY"

# Configure your database
config :event_registry, EventRegistry.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: "event_registry_dev",
  extensions: [{Extensions.JSON, library: Poison}],
  size: 5
