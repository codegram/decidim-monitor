defmodule DecidimClient do
  use Tesla

  plug Tesla.Middleware.Tuples
  plug Tesla.Middleware.Timeout, timeout: 2000
  plug Tesla.Middleware.Compression
  plug Tesla.Middleware.Logger
  plug Tesla.Middleware.JSON, engine_opts: [keys: :atoms]
end
