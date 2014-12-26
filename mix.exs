defmodule Bencoder.Mixfile do
  use Mix.Project

  def project do
    [app: :bencoder,
     version: "0.0.2",
     elixir: "~> 1.0.0",
     description: "a library to handle bencode in elixir",
     package: package,
     deps: deps]
  end

  defp package do
    [ contributors: ["alehander42"],
      licenses: ["MIT"],
      links: %{"Github" => "https://github.com/alehander42/bencoder"}]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [applications: [:logger]]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type `mix help deps` for more examples and options
  defp deps do
    []
  end
end