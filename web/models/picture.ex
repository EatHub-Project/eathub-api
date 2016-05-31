defmodule EathubApi.Picture do
  use EathubApi.Web, :model

  schema "pictures" do
    field :idUser, :string
    field :image, :string

    timestamps
  end

  @required_fields ~w(idUser image)
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
