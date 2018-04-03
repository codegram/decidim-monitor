defmodule DecidimClient do
  use Tesla
  adapter(:hackney, insecure: true)

  plug(Tesla.Middleware.Tuples)
  plug(Tesla.Middleware.Timeout, timeout: 4000)
  plug(Tesla.Middleware.Compression)
  plug(Tesla.Middleware.Logger)
  plug(Tesla.Middleware.JSON, engine_opts: [keys: :atoms])
end
