defmodule DecidimMonitor.Api.Installation do
  @installations %{
    "barcelona" => %{name: "Decidim Barcelona", url: "https://www.decidim.barcelona" },
    "hospitalet" => %{ name: "L'H-ON Participa", url: "https://www.lhon-participa.cat" },
    "terrassa" => %{ name: "Decidim Terrassa", url: "https://participa.terrassa.cat" },
    "sabadell" => %{ name: "Decidim Sabadell", url: "https://decidim.sabadell.cat" },
    "gava" => %{ name: "Decidim Gavà", url: "https://participa.gavaciutat.cat" },
    "sant_cugat" => %{ name: "Decidim Sant Cugat", url: "https://decidim.santcugat.cat/" },
    "localret" => %{ name: "Decidim Localret", url: "http://decidim.localret.codegram.com" },
    "vilanova" => %{ name: "Vilanova Participa", url: "http://participa.vilanova.cat" },
    "staging" => %{ name: "Decidim Staging", url: "http://staging.decidim.codegram.com" },
    "pamplona" => %{ name: "Erabaki Pamplona", url: "https://erabaki.pamplona.es" },
    "mataro" => %{ name: "Decidim Mataró", url: "https://www.decidimmataro.cat" },
    "diba" => %{ name: "Decidim Diputació de Barcelona", url: "http://decidim.diba.cat" },
    "badalona" => %{ name: "Decidim Badalona", url: "http://decidim.badalona.cat" }
  }

  @graphql_query "{ decidim { version } }"

  @query %{
    query: @graphql_query
  }

  def all_installations do
    Map.keys @installations
  end

  def lookup(id) do
    installation = @installations[id]
    url = installation[:url]
    remote_data = remote_data(url)

    %{
      id: id,
      url: installation[:url],
      name: installation[:name],
      version: remote_data["version"],
      status: remote_data["status"]
    }
  end

  defp remote_data(url) do
    with %{body: body, status: 200} <- request(url),
         {:ok, body} <- Poison.Parser.parse(body),
         {:ok, data} <- Map.fetch(body, "data"),
         {:ok, decidim} <- Map.fetch(data, "decidim") do
      decidim
      |> Map.merge %{"status" => "online"}
    else
      _ -> %{"status" => "error", "version" => "N/A"}
    end
  end

  def request(url) do
    try do
      Tesla.post("#{url}/api", Poison.encode!(@query), headers: %{"Content-Type" => "application/json"})
    rescue
      error in Tesla.Error -> {:error, error}
    end
  end
end
