defmodule EathubApi.Repo.Migrations.CreateStep do
  use Ecto.Migration

  def change do
    create table(:steps) do
      add :idRecipe, :string
      add :text, :string
      add :idPicture, :string

      timestamps
    end

  end
end
