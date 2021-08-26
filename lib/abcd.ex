defmodule ABCD.Fourletters do
  use Agent

  @doc """
  Start a new fourletters.
  """
  def start_link(opts) do
    Agent.start_link(fn -> opts end)
  end

  @doc """
  Get the posts on this fourletters. 
  """
  def get(name) do
    Agent.get(name, & &1)
  end

  @doc """
  Put a new post on these fourletters.
  """
  def put(name, value) do
    Agent.update(name, fn list -> append(list, value) end)
  end

  defp append(lines, value) when is_list(lines) and length(lines) < 101 do
    lines ++ [value]
  end

  defp append(lines, _values) do
    lines
  end
end

