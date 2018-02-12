defmodule Eathub.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :display_name, :string
      add :password, :string
      add :email, :string
      add :language, :string
      add :avatar, :string
      add :website, :string
      add :provider, :string

      timestamps()
    end

  end
end
