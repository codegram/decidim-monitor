# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :decidim_monitor, ecto_repos: [DecidimMonitor.Repo]

# Configures the endpoint
config :decidim_monitor, DecidimMonitor.Web.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "go3Koe77kvLy9iO6cTBZVC3J1j32OWczWBM1AyPGAkKrMxpJXCzriZtkTOGDrYi0",
  render_errors: [view: DecidimMonitor.Web.ErrorView, accepts: ~w(html json)],
  pubsub: [name: DecidimMonitor.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :decidim_monitor, DecidimMonitor.Api.Installation,
  installations: %{
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
      tags: ["codegram"]
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
      url: "https://participons.debatpublic.fr",
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
      codegram: false
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
      codegram: false
    },
    "nouvelle-aquitaine" => %{
      name: "Nouvelle-Aquitaine",
      url: "https://concertations.nouvelle-aquitaine.fr/",
      codegram: false
    },
    "castilla-la-mancha" => %{
      name: "Participa Castilla La Mancha",
      url: "https://participa.castillalamancha.es/",
      codegram: false,
      repo: "https://github.com/castilla-lamancha/participa-castillalamancha"
    },
    "veracruz" => %{
      name: "Decide Veracruz",
      url: "http://decide.veracruzmunicipio.gob.mx/",
      codegram: false
    },
    "esplugues" => %{
      name: "Esplugues Participa",
      url: "https://espluguesparticipa.diba.cat/",
      codegram: false
    },
    "metadecidim-fr" => %{
      name: "Club des utilisateurs de Decidim",
      url: "https://club.decidim.opensourcepolitics.eu/",
      codegram: false
    },
    "rubi" => %{
      name: "Participa Rubí",
      url: "https://participa.rubi.cat/",
      codegram: false
    },
    "malgrat" => %{
      name: "Malgrat Decideix",
      url: "https://decideix.ajmalgrat.cat/",
      codegram: false
    },
    "gencat" => %{
      name: "Generalitat de Catalunya",
      url: "https://participa.gencat.cat/",
      codegram: false
    },
    "forum-franco-ruse" => %{
      name: "Forum Franco-Ruse",
      url: "https://forum.dialogue-trianon.fr/",
      codegram: false
    },
    "lille" => %{
      name: "Métropole Européene de Lille",
      url: "https://participation.lillemetropole.fr/",
      codegram: false
    },
    "oidp" => %{
      name: "OIDP",
      url: "https://participate.oidp.net/",
      codegram: false
    },
    "amyocs" => %{
      name: "amycos",
      url: "http://burgos.decidimos.pt/",
      codegram: false
    }
  }

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
