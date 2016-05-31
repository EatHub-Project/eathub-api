defmodule EathubApi.Taste do
  use EathubApi.Web, :model

  schema "tastes" do
    field :salty, :integer
    field :sour, :integer
    field :bitter, :integer
    field :sweet, :integer
    field :spicy, :integer

    timestamps
  end

  @required_fields ~w(salty sour bitter sweet spicy)
  @optional_fields ~w()

  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
