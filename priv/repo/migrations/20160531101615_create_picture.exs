defmodule EathubApi.Repo.Migrations.CreatePicture do
  use Ecto.Migration

  def change do
    create table(:pictures) do
      add :idUser, :string
      add :image, :string

      timestamps
    end

  end
end
