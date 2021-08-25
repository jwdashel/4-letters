# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

# Configures the endpoint
config :fourletters, FourlettersWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "0uufssOtHojOe84Byp9qpanj9A97/GTNib3rWZDh+VZ84UXdgmLBkrh91cBvcL1G",
  render_errors: [view: FourlettersWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Fourletters.PubSub,
  live_view: [signing_salt: "6h8UNurG"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
