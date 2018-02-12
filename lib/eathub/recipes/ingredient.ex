defmodule Eathub.Recipes.Ingredient do
  use Ecto.Schema
  import Ecto.Changeset
  alias Eathub.Recipes.Ingredient

  @primary_key {:id, :binary_id, autogenerate: true}
  @derive {Phoenix.Param, key: :id}
  @foreign_key_type :binary_id
  @derive {Poison.Encoder, only: [:id, :position, :text]}

  schema "ingredients" do
    field :position, :integer
    field :text, :string
    belongs_to :recipe, Eathub.Recipes.Recipe
    
    timestamps()
  end

  @doc false
  def changeset(%Ingredient{} = ingredient, attrs) do
    ingredient
    |> cast(attrs, [:text, :position])
    |> validate_required([:text, :position])
  end
end
