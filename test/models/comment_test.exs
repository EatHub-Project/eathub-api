defmodule EathubApi.CommentTest do
  use EathubApi.ModelCase

  alias EathubApi.Comment

  @valid_attrs %{createDate: 42, idAuthor: "some content", idRecipe: "some content", isBanned: true, text: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Comment.changeset(%Comment{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Comment.changeset(%Comment{}, @invalid_attrs)
    refute changeset.valid?
  end
end
