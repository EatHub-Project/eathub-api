defmodule Eathub.Recipes.Step do
  use Ecto.Schema
  import Ecto.Changeset
  alias Eathub.Recipes.Step

  @primary_key {:id, :binary_id, autogenerate: true}
  @derive {Phoenix.Param, key: :id}
  @foreign_key_type :binary_id
  @derive {Poison.Encoder, only: [:id, :image, :position, :text]}

  schema "steps" do
    field :image, :string
    field :position, :integer
    field :text, :string
    belongs_to :recipe, Eathub.Recipes.Recipe

    timestamps()
  end

  @doc false
  def changeset(%Step{} = step, attrs) do
    step
    |> cast(attrs, [:text, :image, :position])
    |> validate_required([:text, :image, :position])
  end
end
