defmodule EathubApi.Following do
  use EathubApi.Web, :model

  schema "followings" do
    field :displayName, :string
    field :username, :string
    field :idUser, :string
    field :idFollowedUser, :string

    timestamps
  end

  @required_fields ~w(displayName username idUser idFollowedUser)
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
