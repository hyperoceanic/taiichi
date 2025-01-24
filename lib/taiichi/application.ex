defmodule Taiichi.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      TaiichiWeb.Telemetry,
      Taiichi.Repo,
      {DNSCluster, query: Application.get_env(:taiichi, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Taiichi.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Taiichi.Finch},
      # Start a worker by calling: Taiichi.Worker.start_link(arg)
      # {Taiichi.Worker, arg},
      # Start to serve requests, typically the last entry
      TaiichiWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Taiichi.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    TaiichiWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
