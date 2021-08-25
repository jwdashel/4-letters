defmodule FourlettersWeb.FourlettersController do
  use FourlettersWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def show(conn, %{"messenger" => messenger}) do
    render(conn, "show.html", messenger: messenger)
  end

  def yo(conn, %{"messenger" => messenger}) do
    render(conn, "yo.html", messenger: messenger)
  end
  def nothing(conn, _params) do
    render(conn, "nothing.html")
  end
end
