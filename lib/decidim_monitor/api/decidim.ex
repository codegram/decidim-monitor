defmodule DecidimMonitor.Api.Decidim do
  def data do
    with %{body: body} <- Tesla.get("https://rubygems.org/api/v1/gems/decidim.json"),
         {:ok, body} <- Poison.Parser.parse(body, keys: :atoms) do
      body
    end
  end
end
