defmodule CxSnipertimerService.MixProject do
  use Mix.Project

  def project do
    [
      app: :cx_snipertimer_service,
      version: "0.1.0",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      mod: {CxSnipertimerService, []},
      extra_applications: [:logger]
    ]
  end

  defp deps do
    []
  end
end
