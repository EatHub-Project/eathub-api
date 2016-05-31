defmodule EathubApi.Repo.Migrations.CreateFollowing do
  use Ecto.Migration

  def change do
    create table(:followings) do
      add :displayName, :string
      add :username, :string
      add :idUser, :string
      add :idFollowedUser, :string

      timestamps
    end

  end
end
