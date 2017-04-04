defmodule DecidimMonitor.Api.Schema do
  use Absinthe.Schema
  alias DecidimMonitor.Api.Installation, as: Installation
  alias DecidimMonitor.Api.Decidim, as: Decidim

  query do
    @desc "Get an item by ID"
    field :installation, type: :installation do

      @desc "The ID of the installation"
      arg :id, :id

      resolve fn
        %{id: id}, _ -> {:ok, Installation.lookup(id)}
      end
    end

    @desc "Get all the installations"
    field :installations, type: list_of(:installation) do
      resolve fn _, _ ->
        result = Installation.all_installations()
        |> Enum.map(&(Task.async(fn -> Installation.lookup(&1) end)))
        |> Enum.map(&Task.await/1)

        {:ok, result}
      end
    end

    field :decidim, type: :decidim do
      resolve fn _, _ ->
        {:ok, Decidim.data()}
      end
    end
  end

  @desc "Decidim's installation"
  object :installation do
    @desc "This installation's ID"
    field :id, :id

    @desc "The installation's URL"
    field :url, :string

    @desc "Decidim's installed version"
    field :version, :string
  end

  @desc "Decidim's version"
  object :decidim do
    @desc "Decidim's latest released version"
    field :version, :string

    @desc "Decidim's downloads"
    field :downloads, :integer

    @desc "Decidim's latest released version downloads"
    field :version_downloads, :integer
  end
end
