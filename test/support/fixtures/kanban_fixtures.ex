defmodule Taiichi.KanbanFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Taiichi.Kanban` context.
  """

  @doc """
  Generate a board.
  """
  def board_fixture(attrs \\ %{}) do
    {:ok, board} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> Taiichi.Kanban.create_board()

    board
  end
end
