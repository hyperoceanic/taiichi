defmodule Taiichi.Repo.Migrations.AddFieldsToBoards do
  use Ecto.Migration

  def change do
    alter table("boards") do
        add :max_wip_per_person, :integer
    end

  end
end
