defmodule FourlettersWeb.FourlettersController do
  use FourlettersWeb, :controller
  import Fourletters.Troll
  import ABCD.Fourletters

  def fourletters(conn, %{"messenger" => messenger}) do
    if String.length(messenger) == 4 do

      {:ok, sup_pid} = Supervisor.start_link(Fourletters.Troll, [])
      pid = case Supervisor.start_child(
                  sup_pid, %{id: String.to_atom(messenger),
                             start: {ABCD.Fourletters, :start_link, [[]]}}) do
        {:ok, pid} -> pid
        {:error, {:already_started, pid}} -> pid
      end
      messages = ABCD.Fourletters.get(pid)
      render(conn, "four.html", messenger: messenger, messages: messages)
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
