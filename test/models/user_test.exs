defmodule EathubApi.UserTest do
  use EathubApi.ModelCase

  alias EathubApi.User

  @valid_attrs %{avatar: "some content", birthDate: 42, displayName: "some content", gender: "some content", karma: 42, location: "some content", mainLanguage: "some content", modificationDate: 42, username: "some content", website: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = User.changeset(%User{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = User.changeset(%User{}, @invalid_attrs)
    refute changeset.valid?
  end
end
