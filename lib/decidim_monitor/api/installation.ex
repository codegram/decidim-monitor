defmodule DecidimMonitor.Api.Installation do
  require Logger

  @installations %{
    "barcelona" => %{name: "Decidim Barcelona", url: "https://www.decidim.barcelona", codegram: true, repo: "https://github.com/AjuntamentdeBarcelona/decidim-barcelona/" },
    "metadecidim" => %{name: "Metadecidim", url: "https://meta.decidim.barcelona", codegram: true, repo: "https://github.com/decidim/metadecidim/" },
    "decidim-barcelona-organizations" => %{name: "Decidim Barcelona Organizations", url: "https://decidim-bcn-organizations.herokuapp.com", codegram: true, repo: "https://github.com/AjuntamentdeBarcelona/decidim-barcelona-organizations/" },
    "calafell" => %{name: "Decidim Calafell", url: "https://decidim.calafell.cat", codegram: true, repo: "https://github.com/AjuntamentdeCalafell/decidim-calafell/" },
    "hospitalet" => %{ name: "L'H-ON Participa", url: "https://www.lhon-participa.cat", codegram: true, repo: "https://github.com/HospitaletDeLlobregat/decidim-hospitalet/" },
    "terrassa" => %{ name: "Decidim Terrassa", url: "https://participa.terrassa.cat", codegram: true, repo: "https://github.com/AjuntamentDeTerrassa/decidim-terrassa/" },
    "sabadell" => %{ name: "Decidim Sabadell", url: "https://decidim.sabadell.cat", codegram: true, repo: "https://github.com/AjuntamentDeSabadell/decidim-sabadell/" },
    "gava" => %{ name: "Decidim Gavà", url: "https://participa.gavaciutat.cat", codegram: false, repo: "https://github.com/AjuntamentDeGava/decidim-gava/" },
    "sant_cugat" => %{ name: "Decidim Sant Cugat", url: "https://decidim.santcugat.cat/", codegram: true, repo: "https://github.com/AjuntamentdeSantCugat/decidim-sant_cugat/" },
    "localret" => %{ name: "Decidim Localret", url: "http://decidim.localret.codegram.com", codegram: true, repo: "https://github.com/codegram/decidim-localret/" },
    "vilanova" => %{ name: "Vilanova Participa", url: "http://participa.vilanova.cat", codegram: false, repo: "https://github.com/vilanovailageltru/decidim-vilanova/" },
    "staging" => %{ name: "Decidim Staging", url: "http://staging.decidim.codegram.com", codegram: true, repo: "" },
    "pamplona" => %{ name: "Erabaki Pamplona", url: "https://erabaki.pamplona.es", codegram: false, repo: "https://github.com/ErabakiPamplona/erabaki/" },
    "mataro" => %{ name: "Decidim Mataró", url: "https://www.decidimmataro.cat", codegram: false, repo: "https://github.com/AjuntamentDeMataro/decidim-mataro/" },
    "diba" => %{ name: "Decidim Diputació de Barcelona", url: "http://decidim.diba.cat", codegram: false, repo: "https://github.com/diputacioBCN/decidim-diba/" },
    "badalona" => %{ name: "Decidim Badalona", url: "https://decidim.badalona.cat", codegram: true, repo: "https://github.com/AjuntamentdeBadalona/decidim-badalona/" },
    "cndp" => %{ name: "Commission Nationale du Débat Public", url: "https://cndp.opensourcepolitics.eu", codegram: false, repo: "" }
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
      repo: installation[:repo],
      name: installation[:name],
      version: remote_data[:version],
      status: remote_data[:status],
      codegram: installation[:codegram]
    }
  end

  defp remote_data(url) do
    with {:ok, %{body: body, status: 200}} <- request(url),
         {:ok, data} <- Map.fetch(body, :data),
         {:ok, decidim} <- Map.fetch(data, :decidim) do
      decidim
      |> Map.merge(%{status: "online"})
    else
      _ -> %{status: "error", version: "N/A"}
    end
  end

  def request(url) do
    DecidimClient.post("#{url}/api", @query)
  end
end
