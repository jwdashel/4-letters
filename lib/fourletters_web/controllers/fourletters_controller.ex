defmodule FourlettersWeb.FourlettersController do
  use FourlettersWeb, :controller

  def fourletters(conn, %{"messenger" => messenger}) do
    if String.length(messenger) == 4 do
      render(conn, "four.html", messenger: messenger)
    end
    redirect(conn, to: "/")
  end

  # def fourletters(conn, %{"messenger" => messenger}) do
  #   render(conn, "nothing.html")
  # end

  def nothing(conn, _params) do
    render(conn, "nothing.html")
  end
end
