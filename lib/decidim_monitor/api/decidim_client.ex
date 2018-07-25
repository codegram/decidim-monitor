defmodule DecidimClient do
  use Tesla
  adapter(Tesla.Adapter.Hackney, insecure: true)

  plug(Tesla.Middleware.Timeout, timeout: 4000)
  plug(Tesla.Middleware.Compression)
  plug(Tesla.Middleware.Logger)
  plug(Tesla.Middleware.JSON, engine_opts: [keys: :atoms])
end
