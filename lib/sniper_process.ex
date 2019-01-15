defmodule CxSnipertimerService.SniperProcess do
  use GenServer
  require Logger

  @sniper_registry_name :sniper_process_registry

  defstruct sniper_name: "",
            score: 0,
            init_timestamp: 0

  def start_link(sniper_name) when is_binary(sniper_name) do
    GenServer.start_link(__MODULE__, [sniper_name], name: via_tuple(sniper_name))
  end

  defp via_tuple(sniper_name), do: {:via, Registry, {@sniper_registry_name, sniper_name}}

  def init([sniper_name]) do
    Logger.info("New sniper added with nickname: #{sniper_name}")

    {:ok, %__MODULE__{sniper_name: sniper_name, score: 120, init_timestamp: :os.system_time(:seconds)}}
  end

  # genserver apis

  def get_state(sniper_name) do
    GenServer.call(via_tuple(sniper_name), :get_details)
  end

  def increment_score(sniper_name, amount) do
    GenServer.call(via_tuple(sniper_name), {:increment_score, amount})
  end

  # genserver callbacks

  def handle_call(:get_details, _from, state) do
    response = %{
      name: state.sniper_name,
      score: state.score,
      init_timestamp: state.init_timestamp
    }

    {:reply, response, state}
  end

  def handle_call({:increment_score, amount}, _from, %__MODULE__{ score: score } = state) do
    {:reply, :ok, %__MODULE__{ state | score: score + amount}}
  end
end