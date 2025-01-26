defmodule Taiichi.KanbanTest do
  use Taiichi.DataCase

  alias Taiichi.Kanban

  describe "boards" do
    alias Taiichi.Kanban.Board

    import Taiichi.KanbanFixtures

    @invalid_attrs %{name: nil}

    test "list_boards/0 returns all boards" do
      board = board_fixture()
      assert Kanban.list_boards() == [board]
    end

    test "get_board!/1 returns the board with given id" do
      board = board_fixture()
      assert Kanban.get_board!(board.id) == board
    end

    test "create_board/1 with valid data creates a board" do
      valid_attrs = %{name: "some name"}

      assert {:ok, %Board{} = board} = Kanban.create_board(valid_attrs)
      assert board.name == "some name"
    end

    test "create_board/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Kanban.create_board(@invalid_attrs)
    end

    test "update_board/2 with valid data updates the board" do
      board = board_fixture()
      update_attrs = %{name: "some updated name"}

      assert {:ok, %Board{} = board} = Kanban.update_board(board, update_attrs)
      assert board.name == "some updated name"
    end

    test "update_board/2 with invalid data returns error changeset" do
      board = board_fixture()
      assert {:error, %Ecto.Changeset{}} = Kanban.update_board(board, @invalid_attrs)
      assert board == Kanban.get_board!(board.id)
    end

    test "delete_board/1 deletes the board" do
      board = board_fixture()
      assert {:ok, %Board{}} = Kanban.delete_board(board)
      assert_raise Ecto.NoResultsError, fn -> Kanban.get_board!(board.id) end
    end

    test "change_board/1 returns a board changeset" do
      board = board_fixture()
      assert %Ecto.Changeset{} = Kanban.change_board(board)
    end
  end
end
