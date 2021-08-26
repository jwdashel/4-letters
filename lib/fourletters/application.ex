defmodule Fourletters.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      FourlettersWeb.Telemetry,
      # Start the letter troll
      {Fourletters.Troll, name: Fourletters.Troll},
      # Start the PubSub system
      {Phoenix.PubSub, name: Fourletters.PubSub},
      # Start the Endpoint (http/https)
      FourlettersWeb.Endpoint
      # Start a worker by calling: Fourletters.Worker.start_link(arg)
      # {Fourletters.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Fourletters.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    FourlettersWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
