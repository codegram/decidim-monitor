defmodule DecidimClient do
  use Tesla

  plug Tesla.Middleware.Tuples
  plug Tesla.Middleware.Timeout, timeout: 500
  plug Tesla.Middleware.Compression
  plug Tesla.Middleware.FollowRedirects
  plug Tesla.Middleware.Logger
  plug Tesla.Middleware.JSON, engine_opts: [keys: :atoms]
end
