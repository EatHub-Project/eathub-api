defmodule Eathub.Repo.Migrations.CreateIngredients do
  use Ecto.Migration

  def change do
    create table(:ingredients, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :text, :string
      add :position, :integer
      add :recipe_id, references(:recipes, on_delete: :nothing, type: :uuid)
      
      timestamps()
    end

  end
end
