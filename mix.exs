defmodule DefaultTitle.Mixfile do
  use Mix.Project

  def project do
    [app: :default_title,
     version: "0.0.1",
     elixir: "~> 1.0",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  def application do
    [applications: [:logger]]
  end

  defp deps do
    [
      {:phoenix, "~> 1.3.0-rc.1"},
    ]
  end
end
