defmodule PostCode.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      PostCodeWeb.Telemetry,
      # Start the Ecto repository
      PostCode.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: PostCode.PubSub},
      # Start the Endpoint (http/https)
      PostCodeWeb.Endpoint
      # Start a worker by calling: PostCode.Worker.start_link(arg)
      # {PostCode.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: PostCode.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    PostCodeWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
