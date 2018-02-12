defmodule Eathub.Recipes.Recipe do
  use Ecto.Schema
  import Ecto.Changeset
  alias Eathub.Recipes.Recipe

  @primary_key {:id, :binary_id, autogenerate: true}
  @derive {Phoenix.Param, key: :id}
  @foreign_key_type :binary_id

  schema "recipes" do
    field :description, :string
    field :language, :string
    field :main_image, :string
    field :notes, :string
    field :serves, :integer
    field :time, :integer
    field :title, :string
    belongs_to :user, Eathub.Accounts.User
    has_many :steps, Eathub.Recipes.Step, on_delete: :delete_all
    has_many :ingredients, Eathub.Recipes.Ingredient, on_delete: :delete_all

    timestamps()
  end

  @doc false
  def changeset(%Recipe{} = recipe, attrs) do
    recipe
    |> cast(attrs, [:title, :description, :main_image, :serves, :time, :notes, :language])
    |> cast_assoc(:steps)
    |> cast_assoc(:ingredients)
    |> validate_required([:title, :description, :main_image, :serves, :time, :notes, :language, :steps])
  end
end
