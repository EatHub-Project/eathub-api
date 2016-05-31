defmodule EathubApi.Step do
  use EathubApi.Web, :model

  schema "steps" do
    field :idRecipe, :string
    field :text, :string
    field :idPicture, :string

    timestamps
  end

  @required_fields ~w(idRecipe text idPicture)
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
