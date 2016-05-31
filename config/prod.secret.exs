use Mix.Config

# In this file, we keep production configuration that
# you likely want to automate and keep it away from
# your version control system.
config :eathub_api, EathubApi.Endpoint,
  secret_key_base: "fjsrlxg915HCtL6CfuPW+36zghX286PzIKpzu0yIgt9kJ/BPpGzzMhrwth3JokOz"

# Configure your database
config :eathub_api, EathubApi.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "eathub_api_prod",
  pool_size: 20
