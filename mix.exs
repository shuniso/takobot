defmodule Takobot.Mixfile do
  use Mix.Project

  def project do
    [app: :takobot,
     version: "0.0.1",
     elixir: "~> 1.2",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [mod: {Takobot, []},
    applications: [:logger, :slack, :cowboy, :plug, :hackney]]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [{:websocket_client, github: "jeremyong/websocket_client"},
    {:slack, "~> 0.4.0"},
    {:httpoison, "~> 0.8.3"},
    {:floki, "~> 0.8.1"},
    {:poison, "~> 2.1.0"},
    {:docomo, path: "../docomo"},
    {:exrm, "~> 0.18.1"},
    {:cowboy, "~> 1.0.4"},
    {:plug, "~> 1.1.5"},
    {:hackney, "~> 1.6.0"}]
  end
end
