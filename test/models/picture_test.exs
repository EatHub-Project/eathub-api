defmodule EathubApi.PictureTest do
  use EathubApi.ModelCase

  alias EathubApi.Picture

  @valid_attrs %{idUser: "some content", image: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Picture.changeset(%Picture{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Picture.changeset(%Picture{}, @invalid_attrs)
    refute changeset.valid?
  end
end
