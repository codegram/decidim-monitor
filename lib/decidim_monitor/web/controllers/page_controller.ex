defmodule DecidimMonitor.Web.PageController do
  use DecidimMonitor.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
