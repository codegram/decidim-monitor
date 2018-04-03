defmodule DecidimMonitor.InstallationsListTest do
  use DecidimMonitor.AcceptanceCase, async: true
  import Wallaby.Query, only: [css: 2]

  test "all installations appear once", %{session: session} do
    session
    |> visit("/")

    Enum.map(Map.values(DecidimMonitor.Api.Installation.all()), fn %{url: url} ->
      session
      |> assert_has(css("app-installation", text: "Decidim Staging"))
    end)
  end

  test "the page has the right title", %{session: session} do
    session
    |> visit("/")
    |> assert_has(css("mat-toolbar", text: "decidim monitor"))
  end
end
