defmodule DecidimMonitor.Api.Installation do
  require Logger

  @graphql_query "{ decidim { version } }"

  @query %{
    query: @graphql_query
  }

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
