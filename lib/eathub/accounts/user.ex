defmodule Eathub.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Eathub.Accounts.User
  alias Comeonin.Bcrypt

  @primary_key {:id, :binary_id, autogenerate: true}
  @derive {Phoenix.Param, key: :id}
  @derive {Poison.Encoder, only: [:id, :display_name, :avatar, :website]}

  schema "users" do
    field :avatar, :string
    field :display_name, :string
    field :email, :string
    field :language, :string
    field :password, :string
    field :provider, :string
    field :website, :string
    has_many :recipes, Eathub.Recipes.Recipe

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:display_name, :password, :email, :language, :avatar, :website, :provider])
    |> validate_required([:email])
    |> unique_constraint(:email)
    |> put_pass_hash()
  end

  defp put_pass_hash(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, password: Bcrypt.hashpwsalt(password))
  end

  defp put_pass_hash(changeset), do: changeset
end
