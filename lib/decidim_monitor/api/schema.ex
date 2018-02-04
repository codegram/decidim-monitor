defmodule DecidimMonitor.Api.Schema do
  require Logger

  use Absinthe.Schema
  alias DecidimMonitor.Api.Installation, as: Installation
  alias DecidimMonitor.Api.Decidim, as: Decidim

  query do
    @desc "Get an item by ID"
    field :installation, type: :installation do
      @desc "The ID of the installation"
      arg(:id, non_null(:id))

      resolve(fn %{id: id}, _ -> {:ok, Installation.lookup(id)} end)
    end

    @desc "Get all the installations"
    field :installations, type: list_of(:installation) do
      arg(:version, :string)
      arg(:tags, list_of(:string))

      resolve(fn args, _ ->
        result =
          Map.keys(Installation.all())
          |> Flow.from_enumerable()
          |> Flow.partition(max_demand: 50, stages: 50)
          |> Flow.map(fn id -> Installation.lookup(id) end)
          |> Flow.filter(fn installation ->
               if args[:version] do
                 installation[:version] == args[:version]
               else
                 true
               end
             end)
          |> Flow.filter(fn installation ->
              if args[:tags] do
                Enum.all?(args[:tags], fn (tag) -> 
                  Enum.member?(installation[:tags], tag)
                end)
              else
                true
              end
            end)
          |> Enum.to_list()

        {:ok, result}
      end)
    end

    field :decidim, type: :decidim do
      resolve(fn _, _ ->
        Decidim.data()
      end)
    end
  end

  @desc "Decidim's installation"
  object :installation do
    @desc "This installation's ID"
    field(:id, non_null(:id))

    @desc "The installation's name"
    field(:name, :string)

    @desc "The installation's URL"
    field(:url, :string)

    @desc "The installation's repo URL"
    field(:repo, :string)

    @desc "Decidim's installed version"
    field(:version, :string)

    @desc "This installation's status"
    field(:status, :string)

    @desc "Wether the installation is maintained by codegram or not."
    field(:codegram, :boolean, deprecate: "Use the tags field instead.")

    @desc "A list of tags associated with this installation"
    field(:tags, list_of(:string))
  end

  @desc "Decidim's version"
  object :decidim do
    @desc "Decidim's latest released version"
    field(:version, :string)

    @desc "Decidim's downloads"
    field(:downloads, :integer)

    @desc "Decidim's latest released version downloads"
    field(:version_downloads, :integer)
  end
end
