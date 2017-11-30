defmodule DecidimMonitor.Web.PageControllerTest do
  use DecidimMonitor.Web.ConnCase, async: true

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "Decidim Monitor"
  end
end
