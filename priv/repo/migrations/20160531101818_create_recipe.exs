defmodule EathubApi.Repo.Migrations.CreateRecipe do
  use Ecto.Migration

  def change do
    create table(:recipes) do
      add :title, :string
      add :creationDate, :integer
      add :mainImage, :string
      add :modificationDate, :integer
      add :serves, :string
      add :language, :string
      add :temporality, :string
      add :nationality, :string
      add :notes, :string
      add :difficult, :integer
      add :foodType, :string
      add :isPublished, :boolean, default: false
      add :idParentRecipe, :string
      add :author, :string
      add :savours, :string
      add :preparationTime, :integer
      add :cookTime, :integer

      timestamps
    end

  end
end
