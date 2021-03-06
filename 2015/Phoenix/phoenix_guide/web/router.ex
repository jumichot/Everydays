defmodule PhoenixGuide.Router do
  use PhoenixGuide.Web, :router

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

  scope "/", PhoenixGuide do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    get "/text_rendering", HelloController, :test_text
    get "/hello", HelloController, :index
    get "/hello/:messenger", HelloController, :show
  end

  # Other scopes may use custom stacks.
  # scope "/api", PhoenixGuide do
  #   pipe_through :api
  # end
end
