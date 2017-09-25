defmodule DecidimMonitor.Api.Installation do
  @installations %{
    "barcelona" => %{name: "Decidim Barcelona", url: "https://www.decidim.barcelona", codegram: true },
    "hospitalet" => %{ name: "L'H-ON Participa", url: "https://www.lhon-participa.cat", codegram: true },
    "terrassa" => %{ name: "Decidim Terrassa", url: "https://participa.terrassa.cat", codegram: true },
    "sabadell" => %{ name: "Decidim Sabadell", url: "https://decidim.sabadell.cat", codegram: true },
    "gava" => %{ name: "Decidim Gavà", url: "https://participa.gavaciutat.cat", codegram: false },
    "sant_cugat" => %{ name: "Decidim Sant Cugat", url: "https://decidim.santcugat.cat/", codegram: true },
    "localret" => %{ name: "Decidim Localret", url: "http://decidim.localret.codegram.com", codegram: true },
    "vilanova" => %{ name: "Vilanova Participa", url: "http://participa.vilanova.cat", codegram: false },
    "staging" => %{ name: "Decidim Staging", url: "http://staging.decidim.codegram.com", codegram: true },
    "pamplona" => %{ name: "Erabaki Pamplona", url: "https://erabaki.pamplona.es", codegram: false },
    "mataro" => %{ name: "Decidim Mataró", url: "https://www.decidimmataro.cat", codegram: false },
    "diba" => %{ name: "Decidim Diputació de Barcelona", url: "http://decidim.diba.cat", codegram: false },
    "badalona" => %{ name: "Decidim Badalona", url: "https://decidim.badalona.cat", codegram: true },
    "cndp" => %{ name: "Commission Nationale du Débat Public", url: "https://cndp.opensourcepolitics.eu", codegram: false }
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
      status: remote_data["status"],
      codegram: installation[:codegram]
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
