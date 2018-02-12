defmodule Eathub.AccountsTest do
  use Eathub.DataCase

  alias Eathub.Accounts

  describe "users" do
    alias Eathub.Accounts.User

    @valid_attrs %{avatar: "some avatar", display_name: "some display_name", email: "some email", language: "some language", password: "some password", provider: "some provider", website: "some website"}
    @update_attrs %{avatar: "some updated avatar", display_name: "some updated display_name", email: "some updated email", language: "some updated language", password: "some updated password", provider: "some updated provider", website: "some updated website"}
    @invalid_attrs %{avatar: nil, display_name: nil, email: nil, language: nil, password: nil, provider: nil, website: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_user()

      user
    end

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Accounts.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Accounts.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Accounts.create_user(@valid_attrs)
      assert user.avatar == "some avatar"
      assert user.display_name == "some display_name"
      assert user.email == "some email"
      assert user.language == "some language"
      assert String.contains?(user.password, "$")
      assert user.provider == "some provider"
      assert user.website == "some website"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, user} = Accounts.update_user(user, @update_attrs)
      assert %User{} = user
      assert user.avatar == "some updated avatar"
      assert user.display_name == "some updated display_name"
      assert user.email == "some updated email"
      assert user.language == "some updated language"
      assert String.contains?(user.password, "$")
      assert user.provider == "some updated provider"
      assert user.website == "some updated website"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_user(user, @invalid_attrs)
      assert user == Accounts.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Accounts.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Accounts.change_user(user)
    end
  end
end
