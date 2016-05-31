defmodule EathubApi.Repo.Migrations.CreateComment do
  use Ecto.Migration

  def change do
    create table(:comments) do
      add :idRecipe, :string
      add :text, :string
      add :createDate, :integer
      add :idAuthor, :string
      add :isBanned, :boolean, default: false

      timestamps
    end

  end
end
