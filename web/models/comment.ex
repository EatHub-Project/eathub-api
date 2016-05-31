defmodule EathubApi.Comment do
  use EathubApi.Web, :model

  schema "comments" do
    field :idRecipe, :string
    field :text, :string
    field :createDate, :integer
    field :idAuthor, :string
    field :isBanned, :boolean, default: false

    timestamps
  end

  @required_fields ~w(idRecipe text createDate idAuthor isBanned)
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
