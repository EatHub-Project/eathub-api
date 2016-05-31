defmodule EathubApi.V1.RecipeControllerTest do
  use EathubApi.ConnCase

  alias EathubApi.Recipe
  @valid_attrs %{author: "some content", cookTime: 42, creationDate: 42, difficult: 42, foodType: "some content", idParentRecipe: "some content", isPublished: true, language: "some content", mainImage: "some content", modificationDate: 42, nationality: "some content", notes: "some content", preparationTime: 42, savours: "some content", serves: "some content", temporality: "some content", title: "some content"}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, v1_recipe_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    recipe = Repo.insert! %Recipe{}
    conn = get conn, v1_recipe_path(conn, :show, recipe)
    assert json_response(conn, 200)["data"] == %{"id" => recipe.id,
      "title" => recipe.title,
      "creationDate" => recipe.creationDate,
      "mainImage" => recipe.mainImage,
      "modificationDate" => recipe.modificationDate,
      "serves" => recipe.serves,
      "language" => recipe.language,
      "temporality" => recipe.temporality,
      "nationality" => recipe.nationality,
      "notes" => recipe.notes,
      "difficult" => recipe.difficult,
      "foodType" => recipe.foodType,
      "isPublished" => recipe.isPublished,
      "idParentRecipe" => recipe.idParentRecipe,
      "author" => recipe.author,
      "savours" => recipe.savours,
      "preparationTime" => recipe.preparationTime,
      "cookTime" => recipe.cookTime}
  end

  test "does not show resource and instead throw error when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, v1_recipe_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, v1_recipe_path(conn, :create), recipe: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Recipe, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, v1_recipe_path(conn, :create), recipe: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    recipe = Repo.insert! %Recipe{}
    conn = put conn, v1_recipe_path(conn, :update, recipe), recipe: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Recipe, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    recipe = Repo.insert! %Recipe{}
    conn = put conn, v1_recipe_path(conn, :update, recipe), recipe: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    recipe = Repo.insert! %Recipe{}
    conn = delete conn, v1_recipe_path(conn, :delete, recipe)
    assert response(conn, 204)
    refute Repo.get(Recipe, recipe.id)
  end
end
