defmodule PeepBlogBackend.Router do
  use PeepBlogBackend.Web, :router

  pipeline :api do
    plug PlugCors, origins: ["*"]
    plug :accepts, ["json"]
  end

  scope "/", PeepBlogBackend do
    pipe_through :api

    resources "/posts", PostController
  end
end
