defmodule FourlettersWeb.FourlettersController do
  use FourlettersWeb, :controller
  require Logger

  defp get_pid(for_letters) do
      case Supervisor.start_child(
          Fourletters.Troll,
          %{id: String.to_atom(for_letters), start: {ABCD.Fourletters, :start_link, [[]]}}) do
        {:ok, pid} -> pid
        {:error, {:already_started, pid}} -> pid
      end
  end

  defp valid_fourletters(for_letters) do
    String.length(for_letters) == 4 and for_letters =~ ~r(^[a-z!]*$)
  end

 def index(conn, _params) do
   render(conn, "index.html")
  end

  def fourletters(conn, %{"fourletters" => fourletters}) do
    if valid_fourletters(fourletters) do
      pid = get_pid(fourletters)
      messages = ABCD.Fourletters.get(pid)
      render(conn, "four.html", fourletters: fourletters, messages: messages)
    else
      redirect(conn, to: "/")
    end
  end

  def getmessages(conn, %{"fourletters" => fourletters}) do
    if valid_fourletters(fourletters) do
      pid = get_pid(fourletters)
      messages = ABCD.Fourletters.get(pid)
      json(conn, %{fourletters: fourletters, messages: messages})
    else
      json(conn, %{welcome: "this is fourletters"})
    end
  end

  def addletters(conn, params) do
    %{"fourletters" => fourletters, "message" => message} = params
    if valid_fourletters(fourletters) and String.length(message) < 101  do
      Logger.info params
      pid = get_pid(fourletters)
      ABCD.Fourletters.put(pid, message)
      redirect(conn, to: "/#{fourletters}")
    else
      redirect(conn, to: "/#{fourletters}")
    end
  end

  def apiaddletters(conn, params) do
    # how to consolidate with the other addletters?

    %{"fourletters" => fourletters, "message" => message} = params
    if valid_fourletters(fourletters) and String.length(message) < 101  do
      Logger.info fn ->
        "#{DateTime.utc_now} #{inspect(params)}"
      end
      pid = get_pid(fourletters)
      ABCD.Fourletters.put(pid, message)
      messages = ABCD.Fourletters.get(pid)
      conn
      |> put_status(:created)
      |> json(%{fourletters: fourletters, messages: messages})
      |> redirect(to: "/#{fourletters}")
    else
      json(conn, %{error: message})
    end
  end

  def clearletters(conn, params) do
    %{"fourletters" => fourletters} = params
    if valid_fourletters(fourletters) do
      pid = get_pid(fourletters)
      ABCD.Fourletters.clear(pid)
      redirect(conn, to: "/#{fourletters}")
    end
  end

  def nothing(conn, %{"fourletters" => fourletters}) do
    if valid_fourletters(fourletters) do
      redirect(conn, to: "/#{fourletters}")
    else
      render(conn, "nothing.html")
    end
  end

  def nothing(conn, %{}) do
    render(conn, "nothing.html")
  end
end
