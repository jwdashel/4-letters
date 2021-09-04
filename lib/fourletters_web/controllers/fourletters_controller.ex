defmodule FourlettersWeb.FourlettersController do
  use FourlettersWeb, :controller
  require Logger
  # import Fourletters.Troll
  # import ABCD.Fourletters

  def fourletters(conn, %{"fourletters" => fourletters}) do
    if String.length(fourletters) == 4 and fourletters =~ ~r(^[a-z!]*$) do

      pid = case Supervisor.start_child(
          Fourletters.Troll,
          %{id: String.to_atom(fourletters), start: {ABCD.Fourletters, :start_link, [[]]}}) do
        {:ok, pid} -> pid
        {:error, {:already_started, pid}} -> pid
      end
      messages = ABCD.Fourletters.get(pid)
      render(conn, "four.html", fourletters: fourletters, messages: messages)
    else
      redirect(conn, to: "/")
    end
  end

  def getmessages(conn, %{"fourletters" => fourletters}) do
    if String.length(fourletters) == 4 and fourletters =~ ~r(^[a-z!]*$)  do

      pid = case Supervisor.start_child(
          Fourletters.Troll,
          %{id: String.to_atom(fourletters), start: {ABCD.Fourletters, :start_link, [[]]}}) do
        {:ok, pid} -> pid
        {:error, {:already_started, pid}} -> pid
      end
      messages = ABCD.Fourletters.get(pid)
      json(conn, %{fourletters: fourletters, messages: messages})
    else
      json(conn, %{welcome: "this is fourletters"})
    end
  end

  def addletters(conn, _params) do
    %{params: params} = conn
    %{"fourletters" => fourletters, "message" => message} = params
    if String.length(fourletters) == 4 and String.length(message) < 101 and fourletters =~ ~r(^[a-z!]*$)  do

      Logger.info params
      pid = case Supervisor.start_child(
          Fourletters.Troll,
          %{id: String.to_atom(fourletters), start: {ABCD.Fourletters, :start_link, [[]]}}) do
        {:ok, pid} -> pid
        {:error, {:already_started, pid}} -> pid
      end
      _ = ABCD.Fourletters.put(pid, message)
      # conn
      # |> put_status(:ok)
      # |> json(%{fourletters: fourletters, messages: messages})
      # |> put_status(:ok)
      # |> redirect(to: "/#{fourletters}")
      redirect(conn, to: "/#{fourletters}")
      # |> render("four.html", fourletters: fourletters, messages: messages)
    else
      redirect(conn, to: "/#{fourletters}")
    end
  end

  def apiaddletters(conn, _params) do
    %{params: params} = conn
    %{"fourletters" => fourletters, "message" => message} = params
    if String.length(fourletters) == 4 and fourletters =~ ~r(^[a-z!]*$)  and String.length(message) < 101 do

      Logger.info fn ->
        "#{DateTime.utc_now} #{inspect(params)}"
      end
      pid = case Supervisor.start_child(
          Fourletters.Troll,
          %{id: String.to_atom(fourletters), start: {ABCD.Fourletters, :start_link, [[]]}}) do
        {:ok, pid} -> pid
        {:error, {:already_started, pid}} -> pid
      end
      _ = ABCD.Fourletters.put(pid, message)
      messages = ABCD.Fourletters.get(pid)
      conn
      |> put_status(:created)
      |> json(%{fourletters: fourletters, messages: messages})
      # |> put_status(:ok)
      |> redirect(to: "/#{fourletters}")
      # redirect(conn, to: "/#{fourletters}")
      # |> render("four.html", fourletters: fourletters, messages: messages)
    else
      json(conn, %{error: message})
    end
  end

  def apiclearletters(conn, _params) do
    %{params: params} = conn
    %{"fourletters" => fourletters} = params
    if String.length(fourletters) == 4 and fourletters =~ ~r(^[a-z!]*$)  do
      pid = case Supervisor.start_child(
          Fourletters.Troll,
          %{id: String.to_atom(fourletters), start: {ABCD.Fourletters, :start_link, [[]]}}) do
        {:ok, pid} -> pid
        {:error, {:already_started, pid}} -> pid
      end
      ABCD.Fourletters.clear(pid)
      # conn
      # |> put_status(:ok)
      # |> json(%{fourletters: fourletters, clear: true})
      # |> redirect(to: "/#{fourletters}")
      # redirect(conn, to: "/redirect_test")
      redirect(conn, to: "/#{fourletters}")
    end
  end

  def clearletters(conn, _params) do
    %{params: params} = conn
    %{"fourletters" => fourletters} = params
    if String.length(fourletters) == 4 and fourletters =~ ~r(^[a-z!]*$)  do
      pid = case Supervisor.start_child(
          Fourletters.Troll,
          %{id: String.to_atom(fourletters), start: {ABCD.Fourletters, :start_link, [[]]}}) do
        {:ok, pid} -> pid
        {:error, {:already_started, pid}} -> pid
      end
      ABCD.Fourletters.clear(pid)
      # conn
      # |> put_status(:ok)
      # redirect(conn, to: "/redirect_test")
      redirect(conn, to: "/#{fourletters}")
    end
  end

  def nothing(conn, %{"fourletters" => fourletters}) do
    if String.length(fourletters) == 4 and fourletters =~ ~r(^[a-z!]*$)  do
      redirect(conn, to: "/#{fourletters}")
    else
      render(conn, "nothing.html")
    end
  end

  def nothing(conn, %{}) do
    render(conn, "nothing.html")
  end
end
