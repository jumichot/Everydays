defmodule PhoenixGuide.HelloController do
  use PhoenixGuide.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
