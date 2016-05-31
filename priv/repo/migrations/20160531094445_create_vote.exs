defmodule EathubApi.Repo.Migrations.CreateVote do
  use Ecto.Migration

  def change do
    create table(:votes) do
      add :idRecipe, :string
      add :date, :integer
      add :idUser, :string

      timestamps
    end

  end
end
