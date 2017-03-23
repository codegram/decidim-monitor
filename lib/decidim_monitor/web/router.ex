defmodule DecidimMonitor.Web.Router do
  use DecidimMonitor.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", DecidimMonitor.Web do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  forward "/api", Absinthe.Plug, schema: DecidimMonitor.Api.Schema
  forward "/graphiql", Absinthe.Plug.GraphiQL, schema: DecidimMonitor.Api.Schema
end
