defmodule CxSnipertimerService do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      supervisor(Registry, [:unique, :sniper_process_registry]),
      supervisor(CxSnipertimerService.SniperSupervisor, [])
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: CxSnipertimerService.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
