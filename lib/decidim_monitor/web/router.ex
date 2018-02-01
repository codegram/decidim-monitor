defmodule DecidimMonitor.Web.Router do
  use DecidimMonitor.Web, :router

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_flash)
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
  end

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/api" do
    pipe_through(:api)

    forward("/", Absinthe.Plug, schema: DecidimMonitor.Api.Schema)
  end

  forward(
    "/graphiql",
    Absinthe.Plug.GraphiQL,
    schema: DecidimMonitor.Api.Schema,
    interface: :simple
  )

  scope "/", DecidimMonitor.Web do
    # Use the default browser stack
    pipe_through(:browser)

    get("/*path", PageController, :index)
  end
end
