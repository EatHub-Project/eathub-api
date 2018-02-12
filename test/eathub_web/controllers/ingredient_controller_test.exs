defmodule EathubWeb.IngredientControllerTest do
  use EathubWeb.ConnCase

  alias Eathub.Recipes
  alias Eathub.Recipes.Recipe
  alias Eathub.Recipes.Ingredient
  alias Eathub.Accounts
  alias Eathub.Accounts.User
  alias Eathub.Accounts.Guardian

  @create_attrs_recipe %{description: "some description", language: "some language", main_image: "some main_image", notes: "some notes", serves: 42, time: 42, title: "some title",
  user: %{avatar: "some avatar", display_name: "some display_name", email: "some email", language: "some language", password: "some password", provider: "some provider", website: "some website"},
  steps: [%{text: "paso 2", image: "image 2", position: 1}],
  ingredients: [%{text: "tomate", position: 0}]}
  @create_attrs %{position: 42, text: "some text"}
  @update_attrs %{position: 43, text: "some updated text"}
  @invalid_attrs %{position: nil, text: nil, recipe: nil}

  def fixture(:ingredient) do
    {:ok, recipe} = Recipes.create_recipe(Recipe.changeset(%Recipe{}, @create_attrs_recipe))
    {:ok, ingredient} = Recipes.create_ingredient(%{position: 42, text: "some text", recipe: recipe})
    ingredient
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
    test "lists all ingredients", %{conn: conn} do
      conn = get conn, api_v1_ingredient_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "update ingredient" do
    setup [:create_ingredient]

    test "renders ingredient when data is valid", %{conn: conn, ingredient: %Ingredient{id: id} = ingredient} do
      {:ok, recipe} = Recipes.create_recipe(Recipe.changeset(%Recipe{}, @create_attrs_recipe))
      conn = put conn, api_v1_ingredient_path(conn, :update, ingredient), ingredient: %{position: 43, text: "some updated text", recipe: recipe}
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, api_v1_ingredient_path(conn, :show, id)
      assert json_response(conn, 200)["data"]["id"] == id
    end

    test "renders errors when data is invalid", %{conn: conn, ingredient: ingredient} do
      conn = put conn, api_v1_ingredient_path(conn, :update, ingredient), ingredient: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete ingredient" do
    setup [:create_ingredient]

    test "deletes chosen ingredient", %{conn: conn, ingredient: ingredient} do
      conn = delete conn, api_v1_ingredient_path(conn, :delete, ingredient)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, api_v1_ingredient_path(conn, :show, ingredient)
      end
    end
  end

  defp create_ingredient(_) do
    ingredient = fixture(:ingredient)
    {:ok, ingredient: ingredient}
  end
end
