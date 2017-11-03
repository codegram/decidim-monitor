defmodule DecidimMonitor.Api.Decidim do
  def data do
    case DecidimClient.get("https://rubygems.org/api/v1/gems/decidim.json") do
      {:ok, %{body: body}} -> {:ok, body}
      {:error, error} -> {:error, error}
    end
  end
end
