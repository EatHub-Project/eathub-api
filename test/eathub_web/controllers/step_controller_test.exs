defmodule EathubWeb.StepControllerTest do
  use EathubWeb.ConnCase

  alias Eathub.Recipes
  alias Eathub.Recipes.Step
  alias Eathub.Recipes.Recipe
  alias Eathub.Accounts
  alias Eathub.Accounts.User
  alias Eathub.Accounts.Guardian

  @create_attrs_recipe %{description: "some description", language: "some language", main_image: "some main_image", notes: "some notes", serves: 42, time: 42, title: "some title",
  user: %{avatar: "some avatar", display_name: "some display_name", email: "some email", language: "some language", password: "some password", provider: "some provider", website: "some website"},
  steps: [%{text: "paso 2", image: "image 2", position: 1}],
  ingredients: [%{text: "tomate", position: 0}]}
  @create_attrs %{image: "some image", position: 42, text: "some text"}
  @update_attrs %{image: "some updated image", position: 43, text: "some updated text"}
  @invalid_attrs %{image: nil, position: nil, text: nil}

  def fixture(:step) do
    {:ok, recipe} = Recipes.create_recipe(Recipe.changeset(%Recipe{}, @create_attrs_recipe))
    {:ok, step} = Recipes.create_step(%{image: "some image", position: 42, text: "some text", recipe: recipe})
    step
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
    test "lists all steps", %{conn: conn} do
      conn = get conn, api_v1_step_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "update step" do
    setup [:create_step]

    test "renders step when data is valid", %{conn: conn, step: %Step{id: id} = step} do
      {:ok, recipe} = Recipes.create_recipe(Recipe.changeset(%Recipe{}, @create_attrs_recipe))
      conn = put conn, api_v1_step_path(conn, :update, step), step:
      %{image: "some updated image", position: 43, text: "some updated text", recipe: recipe}
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, api_v1_step_path(conn, :show, id)
      assert json_response(conn, 200)["data"]["id"] == id
    end

    test "renders errors when data is invalid", %{conn: conn, step: step} do
      conn = put conn, api_v1_step_path(conn, :update, step), step: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete step" do
    setup [:create_step]

    test "deletes chosen step", %{conn: conn, step: step} do
      conn = delete conn, api_v1_step_path(conn, :delete, step)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, api_v1_step_path(conn, :show, step)
      end
    end
  end

  defp create_step(_) do
    step = fixture(:step)
    {:ok, step: step}
  end
end
