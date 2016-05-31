defmodule EathubApi.FollowingTest do
  use EathubApi.ModelCase

  alias EathubApi.Following

  @valid_attrs %{displayName: "some content", idFollowedUser: "some content", idUser: "some content", username: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Following.changeset(%Following{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Following.changeset(%Following{}, @invalid_attrs)
    refute changeset.valid?
  end
end
