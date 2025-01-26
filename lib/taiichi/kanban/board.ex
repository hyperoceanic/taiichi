defmodule Taiichi.Kanban.Board do
  use Ecto.Schema
  import Ecto.Changeset

  schema "boards" do
    field :name, :string
    field :max_wip_per_person, :integer

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(board, attrs) do
    board
    |> cast(attrs, [:name, :max_wip_per_person])
    |> validate_required([:name, :max_wip_per_person])
  end
end
