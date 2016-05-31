defmodule EathubApi.VoteTest do
  use EathubApi.ModelCase

  alias EathubApi.Vote

  @valid_attrs %{date: 42, idRecipe: "some content", idUser: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Vote.changeset(%Vote{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Vote.changeset(%Vote{}, @invalid_attrs)
    refute changeset.valid?
  end
end
