defmodule DecidimMonitor.InstallationsListTest do
  use DecidimMonitor.AcceptanceCase, async: true
  use ExVCR.Mock
  import Wallaby.Query, only: [css: 2]

  setup do
    ExVCR.Config.cassette_library_dir("fixture/vcr_cassettes")
    :ok
  end

  test "all installations appear once", %{session: session} do
    use_cassette "installation_list" do
      session
      |> visit("/")

      Enum.map(Map.values(DecidimMonitor.Api.Installation.all()), fn %{url: url} ->
        session
        |> assert_has(css("app-installation", text: "Decidim Staging"))
      end)
    end
  end

  test "the page has the right title", %{session: session} do
    use_cassette "installation_list" do
      session
      |> visit("/")
      |> assert_has(css("mat-toolbar", text: "decidim monitor"))
    end
  end
end
