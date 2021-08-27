defmodule FourlettersWeb.FourlettersController do
  use FourlettersWeb, :controller
  import Fourletters.Troll
  import ABCD.Fourletters


  def fourletters(conn, %{"fourletters" => fourletters}) do
    if String.length(fourletters) == 4 do

      pid = case Supervisor.start_child(
          Fourletters.Troll,
          %{id: String.to_atom(fourletters), start: {ABCD.Fourletters, :start_link, [["oo"]]}}) do
        {:ok, pid} -> pid
        {:error, {:already_started, pid}} -> pid
      end
      messages = ABCD.Fourletters.get(pid)
      render(conn, "four.html", fourletters: fourletters, messages: messages)
    else
      redirect(conn, to: "/")
    end
  end


  def addletters(conn, _params) do
    %{params: params, path_params: path_params} = conn
    %{"fourletters" => fourletters, "message" => message} = params
    if String.length(fourletters) == 4 and String.length(message) < 101 do

      pid = case Supervisor.start_child(
          Fourletters.Troll,
          %{id: String.to_atom(fourletters), start: {ABCD.Fourletters, :start_link, [["oo"]]}}) do
        {:ok, pid} -> pid
        {:error, {:already_started, pid}} -> pid
      end
      messages = ABCD.Fourletters.put(pid, message)
      messages = ABCD.Fourletters.get(pid)
      conn
      |> put_status(:created)
      # |> json(%{fourletters: fourletters, messages: messages})
      # |> put_status(:ok)
      |> redirect(to: "/#{fourletters}")
      # |> render("four.html", fourletters: fourletters, messages: messages)
    else
      json(conn, %{error: message})
    end
  end


  def nothing(conn, _params) do
    render(conn, "nothing.html")
  end
end
