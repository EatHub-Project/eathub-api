defmodule EathubWeb.V1.IngredientController do
  use EathubWeb, :controller

  alias Eathub.Recipes
  alias Eathub.Recipes.Ingredient

  action_fallback EathubWeb.FallbackController

  def index(conn, _params) do
    ingredients = Recipes.list_ingredients()
    render(conn, "index.json-api", data: ingredients)
  end

  def create(conn, %{"ingredient" => ingredient_params}) do
    with {:ok, %Ingredient{} = ingredient} <- Recipes.create_ingredient(ingredient_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", api_v1_ingredient_path(conn, :show, ingredient))
      |> render("show.json-api", data: ingredient)
    end
  end

  def show(conn, %{"id" => id}) do
    ingredient = Recipes.get_ingredient!(id)
    render(conn, "show.json-api", data: ingredient)
  end

  def update(conn, %{"id" => id, "ingredient" => ingredient_params}) do
    ingredient = Recipes.get_ingredient!(id)

    with {:ok, %Ingredient{} = ingredient} <- Recipes.update_ingredient(ingredient, ingredient_params) do
      render(conn, "show.json-api", data: ingredient)
    end
  end

  def delete(conn, %{"id" => id}) do
    ingredient = Recipes.get_ingredient!(id)
    with {:ok, %Ingredient{}} <- Recipes.delete_ingredient(ingredient) do
      send_resp(conn, :no_content, "")
    end
  end
end
