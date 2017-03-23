defmodule DecidimMonitor.Api.Schema do
  use Absinthe.Schema

  query do
    @desc "Get an item by ID"
    field :instance, type: :instance do

      @desc "The ID of the instance"
      arg :id, :id

      resolve fn
        %{id: id}, _ -> {:ok, DecidimMonitor.Instance.lookup(id)}
      end
    end

    @desc "Get all the instance versions"
    field :instances, type: list_of(:instance) do
      resolve fn _, _ ->
        result = DecidimMonitor.Instance.instances
        |> Enum.map(&(Task.async(fn -> DecidimMonitor.Instance.lookup(&1) end)))
        |> Enum.map(&Task.await/1)

        {:ok, result}
      end
    end
  end

  @desc "Decidim's installed instance"
  object :instance do
    @desc "This instance's ID"
    field :id, :id

    @desc "The item's name"
    field :url, :string

    @desc "Decidim's installed version"
    field :version, :string
  end
end
