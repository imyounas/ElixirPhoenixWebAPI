defmodule TodoApiWeb.TodoController do
  use TodoApiWeb, :controller

  def index(conn, _params) do
    todos = generate_todos()
    json(conn, todos)
  end

  defp generate_todos do
    Enum.map(1..50, fn id ->
      %{
        id: id,
        title: "Set up a new Elixir project ",
        dueBy: DateTime.utc_now() |> DateTime.add(3600, :second) |> DateTime.to_iso8601(),
        isComplete: false
      }
    end)
  end
end
