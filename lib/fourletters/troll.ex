defmodule Fourletters.Troll do
  use Supervisor
  def start_link(arg) do
    Supervisor.start_link(__MODULE__, arg, name: __MODULE__)
  end

  @impl true
  def init(_arg) do
    children = [
      # initial case, not required
      %{id: :butt, start: {ABCD.Fourletters, :start_link, [["yo"]]}}
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end
end
