defmodule EathubApi.TasteTest do
  use EathubApi.ModelCase

  alias EathubApi.Taste

  @valid_attrs %{bitter: 42, idTaste: "some content", salty: 42, sour: 42, spicy: 42, sweet: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Taste.changeset(%Taste{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Taste.changeset(%Taste{}, @invalid_attrs)
    refute changeset.valid?
  end
end
