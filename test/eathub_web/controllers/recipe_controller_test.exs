defmodule EathubWeb.RecipeControllerTest do
  use EathubWeb.ConnCase

  alias Eathub.Recipes
  alias Eathub.Recipes.Recipe
  alias Eathub.Accounts
  alias Eathub.Accounts.User
  alias Eathub.Accounts.Guardian

  @create_attrs %{description: "some description", language: "some language", main_image: "some main_image", notes: "some notes", serves: 42, time: 42, title: "some title",
  user: %{avatar: "some avatar", display_name: "some display_name", email: "some email", language: "some language", password: "some password", provider: "some provider", website: "some website"},
  steps: [%{text: "paso 2", image: "image 2", position: 1}],
  ingredients: [%{text: "tomate", position: 0}]}
  @update_attrs %{description: "some updated description", language: "some updated language", main_image: "some updated main_image", notes: "some updated notes", serves: 43, time: 43, title: "some updated title"}
  @invalid_attrs %{description: nil, language: nil, main_image: nil, notes: nil, serves: nil, time: nil, title: nil}

  def fixture(:recipe) do
    {:ok, recipe} = Recipes.create_recipe(Recipe.changeset(%Recipe{}, @create_attrs))
    recipe
  end

  setup %{conn: conn} do
    conn = conn
      |> put_req_header("accept", "application/vnd.api+json")
      |> put_req_header("content-type", "application/vnd.api+json")


      {:ok, %User{} = user} = %{avatar: "some avatar", display_name: "some display_name", email: "some email", language: "some language", password: "some password", provider: "some provider", website: "some website"}
        |> Accounts.create_user()

      conn = Guardian.Plug.sign_in(conn, user, %{})
      jwt = Guardian.Plug.current_token(conn)
      claims = Guardian.Plug.current_claims(conn)
      conn = conn
        |> put_resp_header("authorization", "Bearer #{jwt}")
    {:ok, conn: conn}
  end

  describe "index" do
    test "lists all recipes", %{conn: conn} do
      conn = get conn, api_v1_recipe_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "update recipe" do
    setup [:create_recipe]

    test "renders recipe when data is valid", %{conn: conn, recipe: %Recipe{id: id} = recipe} do
      conn = put conn, api_v1_recipe_path(conn, :update, recipe), recipe: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, api_v1_recipe_path(conn, :show, id)
      assert json_response(conn, 200)["data"]["attributes"]["id"] == id
    end

    test "renders errors when data is invalid", %{conn: conn, recipe: recipe} do
      conn = put conn, api_v1_recipe_path(conn, :update, recipe), recipe: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete recipe" do
    setup [:create_recipe]

    test "deletes chosen recipe", %{conn: conn, recipe: recipe} do
      conn = delete conn, api_v1_recipe_path(conn, :delete, recipe)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, api_v1_recipe_path(conn, :show, recipe)
      end
    end
  end

  defp create_recipe(_) do
    recipe = fixture(:recipe)
    {:ok, recipe: recipe}
  end
end
