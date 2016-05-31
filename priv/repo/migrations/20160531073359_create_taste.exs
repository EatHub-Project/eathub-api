defmodule EathubApi.Repo.Migrations.CreateTaste do
  use Ecto.Migration

  def change do
    create table(:tastes) do
      add :idTaste, :string
      add :salty, :integer
      add :sour, :integer
      add :bitter, :integer
      add :sweet, :integer
      add :spicy, :integer

      timestamps
    end

  end
end
