defmodule EathubApi.User do
  use EathubApi.Web, :model

  schema "users" do
    field :displayName, :string
    field :modificationDate, :integer
    field :mainLanguage, :string
    field :avatar, :string
    field :website, :string
    field :gender, :string
    field :birthDate, :integer
    field :location, :string
    field :karma, :integer
    field :username, :string

    timestamps
  end

  @required_fields ~w(displayName modificationDate mainLanguage avatar website gender birthDate location karma username)
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
