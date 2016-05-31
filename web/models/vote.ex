defmodule EathubApi.Vote do
  use EathubApi.Web, :model

  schema "votes" do
    field :idRecipe, :string
    field :date, :integer
    field :idUser, :string

    timestamps
  end

  @required_fields ~w(idRecipe date idUser)
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
