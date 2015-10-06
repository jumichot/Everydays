defmodule Hello.HelloController do
  use Hello.Web, :controller

  def world(conn, %{"name" => name}) do
    conn
    |> render "world.html", name: name
  end
end
