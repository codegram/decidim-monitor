defmodule DecidimMonitor.Api.Installation do
  require Logger

  @extended_query "{
    decidim {
      version
    }
    organization {
      stats {
        value
        name
      }
    }
  }
  "

  @simple_query "{ decidim { version } }"

  def all do
    Application.get_env(:decidim_monitor, __MODULE__)[:installations]
  end

  def lookup(id) do
    installation = all()[id]
    url = installation[:url]
    remote_data = remote_data(url)

    %{
      id: id,
      url: installation[:url],
      repo: installation[:repo],
      name: installation[:name],
      version: remote_data[:version],
      status: remote_data[:status],
      users: remote_data[:users],
      tags: installation[:tags] || [],
      codegram: Enum.member?(installation[:tags] || [], "codegram")
    }
  end

  defp remote_data(url) do
    with {:ok, %{body: %{data: data}}} <- request(url) do
      format_data(data)
    else
      _ -> %{status: "error"}
    end
  end

  def request(url) do
    case DecidimClient.post("#{url}/api", %{query: @extended_query}) do
      {:ok, %{body: %{data: _}}} = response ->
        IO.puts(inspect(response)) && response

      response ->
        DecidimClient.post("#{url}/api", %{query: @simple_query})
    end
  end

  def format_data(data) do
    {:ok, decidim} = Map.fetch(data, :decidim)

    IO.puts(inspect(data))

    %{
      status: "online",
      users: extract_users(data),
      version: decidim[:version]
    }
  end

  def extract_users(%{organization: %{stats: stats}}) do
    stats
    |> Enum.find(fn %{name: "users_count"} -> true end)
    |> Map.get(:value)
  end

  def extract_users(_), do: nil
end
