defmodule Eathub.Repo.Migrations.CreateSteps do
  use Ecto.Migration

  def change do
    create table(:steps, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :text, :string
      add :image, :string
      add :position, :integer
      add :recipe_id, references(:recipes, on_delete: :nothing, type: :uuid)

      timestamps()
    end

  end
end
