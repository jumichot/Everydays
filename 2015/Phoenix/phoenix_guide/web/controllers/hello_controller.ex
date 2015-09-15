defmodule PhoenixGuide.HelloController do
  use PhoenixGuide.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

  # pattern matching against the params to set the messenger variable
  def show(conn, %{"messenger" => messenger}) do
    # pass the messenger variable to the template
    render conn, "show.html", messenger: messenger
  end
end
