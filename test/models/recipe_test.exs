defmodule EathubApi.RecipeTest do
  use EathubApi.ModelCase

  alias EathubApi.Recipe

  @valid_attrs %{author: "some content", cookTime: 42, creationDate: 42, difficult: 42, foodType: "some content", idParentRecipe: "some content", isPublished: true, language: "some content", mainImage: "some content", modificationDate: 42, nationality: "some content", notes: "some content", preparationTime: 42, savours: "some content", serves: "some content", temporality: "some content", title: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Recipe.changeset(%Recipe{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Recipe.changeset(%Recipe{}, @invalid_attrs)
    refute changeset.valid?
  end
end
