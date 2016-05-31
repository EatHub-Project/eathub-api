defmodule EathubApi.Recipe do
  use EathubApi.Web, :model

  schema "recipes" do
    field :title, :string
    field :creationDate, :integer
    field :mainImage, :string
    field :modificationDate, :integer
    field :serves, :string
    field :language, :string
    field :temporality, :string
    field :nationality, :string
    field :notes, :string
    field :difficult, :integer
    field :foodType, :string
    field :isPublished, :boolean, default: false
    field :idParentRecipe, :string
    field :author, :string
    field :savours, :string
    field :preparationTime, :integer
    field :cookTime, :integer

    timestamps
  end

  @required_fields ~w(title creationDate mainImage modificationDate serves language temporality nationality notes difficult foodType isPublished idParentRecipe author savours preparationTime cookTime)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
