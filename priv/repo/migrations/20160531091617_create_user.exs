defmodule EathubApi.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :displayName, :string
      add :modificationDate, :integer
      add :mainLanguage, :string
      add :avatar, :string
      add :website, :string
      add :gender, :string
      add :birthDate, :integer
      add :location, :string
      add :karma, :integer
      add :username, :string

      timestamps
    end

  end
end
