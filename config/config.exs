# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :eathub,
  ecto_repos: [Eathub.Repo]

# Configures the endpoint
config :eathub, EathubWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: System.get_env("SECRET_KEY_BASE"),
  render_errors: [view: EathubWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: Eathub.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :phoenix, :format_encoders,
  "json-api": Poison

config :mime, :types, %{
  "application/vnd.api+json" => ["json-api"],
  "application/xml" => ["xml"]
}

config :eathub, Eathub.Accounts.Guardian,
  issuer: "eathub", # Name of your app/company/product
  secret_key: System.get_env("GUARDIAN_SECRET_KEY")

# Ueberauth Config for oauth
config :ueberauth, Ueberauth,
  base_path: "/api/v1/auth",
  providers: [
    google: { Ueberauth.Strategy.Google, [] },
    identity: { Ueberauth.Strategy.Identity, [
        callback_methods: ["POST"],
        uid_field: :username,
        nickname_field: :username,
      ] },
  ]


config :ueberauth, Ueberauth.Strategy.Google.OAuth,
  client_id: System.get_env("UEBERAUTH_CLIENT_ID"),
  client_secret: System.get_env("UEBERAUTH_SECRET")

config :ex_aws,
  access_key_id: [System.get_env("AWS_ACCESS_KEY_ID"), :instance_role],
  secret_access_key: [System.get_env("AWS_SECRET"), :instance_role],
  s3: [
   scheme: "https://",
   host: "#{System.get_env("BUCKET_NAME")}.s3.amazonaws.com",
   region: "eu-west-3"
  ]
  # Import environment specific config. This must remain at the bottom
  # of this file so it overrides the configuration defined above.
  import_config "#{Mix.env}.exs"
