defmodule CxSnipertimerService.SniperSupervisor do
  use Supervisor
  require Logger

  @sniper_registry_name :sniper_process_registry

  def start_link, do: Supervisor.start_link(__MODULE__, [], name: __MODULE__)

  def create_sniper_process(sniper_name) when is_binary(sniper_name) do
    case Supervisor.start_child(__MODULE__, [sniper_name]) do
      {:ok, _pid} -> {:ok, sniper_name}
      {:error, {:already_started, _pid}} -> {:error, :process_already_exists}
      other -> {:error, other}
    end
  end

  def init(_) do
    children = [
      worker(CxSnipertimerService.SniperProcess, [], restart: :transient)
    ]

    supervise(children, strategy: :simple_one_for_one)
  end
end