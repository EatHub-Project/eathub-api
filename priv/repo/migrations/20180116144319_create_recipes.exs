defmodule Eathub.Repo.Migrations.CreateRecipes do
  use Ecto.Migration

  def change do
    create table(:recipes, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :title, :string
      add :description, :string
      add :main_image, :string
      add :serves, :integer
      add :time, :integer
      add :notes, :string
      add :language, :string
      add :user_id, references(:users, on_delete: :nothing, type: :uuid)
      
      timestamps()
    end

  end
end
