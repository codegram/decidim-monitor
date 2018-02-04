defmodule DecidimMonitor.Api.Installation do
  require Logger

  @installations %{
    "barcelona" => %{
      name: "Decidim Barcelona",
      url: "https://www.decidim.barcelona",
      tags: ["codegram"],
      repo: "https://github.com/AjuntamentdeBarcelona/decidim-barcelona/"
    },
    "metadecidim" => %{
      name: "Metadecidim",
      url: "https://meta.decidim.barcelona",
      tags: ["codegram"],
      repo: "https://github.com/decidim/metadecidim/"
    },
    "decidim-barcelona-organizations" => %{
      name: "Decidim Barcelona Organizations",
      url: "https://decidim.coterrats.com",
      tags: ["codegram"],
      repo: "https://github.com/AjuntamentdeBarcelona/decidim-barcelona-organizations/"
    },
    "calafell" => %{
      name: "Decidim Calafell",
      url: "https://decidim.calafell.cat",
      tags: ["codegram"],
      repo: "https://github.com/AjuntamentdeCalafell/decidim-calafell/"
    },
    "hospitalet" => %{
      name: "L'H-ON Participa",
      url: "https://www.lhon-participa.cat",
      tags: ["codegram"],
      repo: "https://github.com/HospitaletDeLlobregat/decidim-hospitalet/"
    },
    "terrassa" => %{
      name: "Participa Terrassa",
      url: "https://participa.terrassa.cat",
      tags: ["codegram"],
      repo: "https://github.com/AjuntamentDeTerrassa/decidim-terrassa/"
    },
    "sabadell" => %{
      name: "Decidim Sabadell",
      url: "https://decidim.sabadell.cat",
      tags: ["codegram"],
      repo: "https://github.com/AjuntamentDeSabadell/decidim-sabadell/"
    },
    "gava" => %{
      name: "Participa Gavà",
      url: "https://participa.gavaciutat.cat",
      codegram: false,
      repo: "https://github.com/AjuntamentDeGava/decidim-gava/"
    },
    "sant_cugat" => %{
      name: "Decidim Sant Cugat",
      url: "https://decidim.santcugat.cat/",
      tags: ["codegram"],
      repo: "https://github.com/AjuntamentdeSantCugat/decidim-sant_cugat/"
    },
    "localret" => %{
      name: "Decidim Localret",
      url: "http://decidim.localret.codegram.com",
      tags: ["codegram"],
      repo: "https://github.com/codegram/decidim-localret/"
    },
    "vilanova" => %{
      name: "Vilanova Participa",
      url: "http://participa.vilanova.cat",
      codegram: false,
      repo: "https://github.com/vilanovailageltru/decidim-vilanova/"
    },
    "staging" => %{
      name: "Decidim Staging",
      url: "http://staging.decidim.codegram.com",
      tags: ["codegram"],
    },
    "pamplona" => %{
      name: "Erabaki Pamplona",
      url: "https://erabaki.pamplona.es",
      codegram: false,
      repo: "https://github.com/ErabakiPamplona/erabaki/"
    },
    "mataro" => %{
      name: "Decidim Mataró",
      url: "https://www.decidimmataro.cat",
      codegram: false,
      repo: "https://github.com/AjuntamentDeMataro/decidim-mataro/"
    },
    "diba" => %{
      name: "Decidim Diputació de Barcelona",
      url: "http://decidim.diba.cat",
      codegram: false,
      repo: "https://github.com/diputacioBCN/decidim-diba/"
    },
    "badalona" => %{
      name: "Decidim Badalona",
      url: "https://decidim.badalona.cat",
      tags: ["codegram"],
      repo: "https://github.com/AjuntamentdeBadalona/decidim-badalona/"
    },
    "cndp" => %{
      name: "Commission Nationale du Débat Public",
      url: "https://cndp.opensourcepolitics.eu",
      codegram: false,
      repo: "https://github.com/OpenSourcePolitics/decidim-cndp"
    },
    "reus" => %{
      name: "Participa Reus",
      url: "https://participa.reus.cat",
      codegram: false,
      repo: "https://github.com/AjuntamentdeReus/decidim"
    },
    "helsinki" => %{
      name: "Osallistu Helsingin kehittämiseen",
      url: "https://osallistu.hel.fi/",
      codegram: false,
      repo: ""
    },
    "esparreguera" => %{
      name: "Decideix Esparreguera",
      url: "http://decideix.esparreguera.cat/",
      codegram: false,
    },
    "fundaction" => %{
      name: "FundAction",
      url: "https://assembly.fundaction.eu/",
      codegram: false,
      repo: "https://github.com/ElectricThings/fund_action"
    },
    "brocard" => %{
      name: "Blandine Brocard",
      url: "https://participez.blandinebrocard.com/",
      codegram: false,
    },
    "nouvelle-aquitaine" => %{
      name: "Nouvelle-Aquitaine",
      url: "https://concertations.nouvelle-aquitaine.fr/",
      codegram: false,
    },
    "castilla-la-mancha" => %{
      name: "Participa Castilla La Mancha",
      url: "https://participa.castillalamancha.es/",
      codegram: false,
      repo: "https://github.com/castilla-lamancha/participa-castillalamancha"
    }
  }

  @graphql_query "{ decidim { version } }"

  @query %{
    query: @graphql_query
  }

  def all do
    @installations
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
      tags: installation[:tags] || [],
      codegram: Enum.member?(installation[:tags] || [], "codegram")
    }
  end

  defp remote_data(url) do
    with {:ok, %{body: body, status: 200}} <- request(url),
         {:ok, data} <- Map.fetch(body, :data),
         {:ok, decidim} <- Map.fetch(data, :decidim),
         %{version: version} <- decidim do
      %{status: "online", version: version}
    else
      _ -> %{status: "error"}
    end
  end

  def request(url) do
    DecidimClient.post("#{url}/api", @query)
  end
end
