# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :instagram,
  ecto_repos: [Instagram.Repo]

# Configures the endpoint
config :instagram, InstagramWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "9MPQ+7v5sl/F+XFjBExLL8VKkj5JM/IEHBtZv+FjiJWPFyTknf6jW+n6x5S7v7mm",
  render_errors: [view: InstagramWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Instagram.PubSub,
  live_view: [signing_salt: "enEia6FA"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"


  config :ueberauth, Ueberauth,
  providers: [
    google: {Ueberauth.Strategy.Google, []  }
  ]


  config :ueberauth, Ueberauth.Strategy.Google.OAuth,
  client_id: "460831738815-5kj5l3sko4fnngcjgkis6lm9vc9uc0ak.apps.googleusercontent.com",
  client_secret: "8OQr5m8Amyy6JJfkaBEQRVNy"
  
  config :argon2_elixir,
  t_cost: 1,
  m_cost: 8
