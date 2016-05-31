defmodule EathubApi.Taste do
  use EathubApi.Web, :model

  schema "tastes" do
    field :idTaste, :string
    field :salty, :integer
    field :sour, :integer
    field :bitter, :integer
    field :sweet, :integer
    field :spicy, :integer

    timestamps
  end

  @required_fields ~w(idTaste salty sour bitter sweet spicy)
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
