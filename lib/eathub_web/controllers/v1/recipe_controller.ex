defmodule EathubWeb.V1.RecipeController do
  use EathubWeb, :controller

  alias Eathub.Recipes.Recipe
  alias Eathub.Recipes

  action_fallback EathubWeb.FallbackController

  def index(conn, _params) do
    recipes = Recipes.list_recipes()
    render(conn, "index.json-api", data: recipes)
  end

  def create(conn, %{"recipe" => recipe_params}) do
    #before => changeset = conn.assigns.user
    #Review
    #changeset = conn.private.guardian_default_resource
    #  |> Ecto.build_assoc(:recipes)
    changeset = Recipe.changeset(%Recipe{}, recipe_params)
    recipe_with_user = Ecto.Changeset.put_assoc(changeset, :user, conn.private.guardian_default_resource)
    with {:ok, %Recipe{} = recipe} <- Recipes.create_recipe(recipe_with_user) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", api_v1_recipe_path(conn, :show, recipe))
      |> render("show.json-api", data: recipe)
    end
  end

  def show(conn, %{"id" => id}) do
    recipe = Recipes.get_recipe!(id)
    render(conn, "show.json-api", data: recipe)
  end

  def update(conn, %{"id" => id, "recipe" => recipe_params}) do
    recipe = Recipes.get_recipe!(id)
    with {:ok, %Recipe{} = recipe} <- Recipes.update_recipe(recipe, recipe_params) do
      render(conn, "show.json-api", data: recipe)
    end
  end

  def delete(conn, %{"id" => id}) do
    recipe = Recipes.get_recipe!(id)
    with {:ok, %Recipe{}} <- Recipes.delete_recipe(recipe) do
      send_resp(conn, :no_content, "")
    end
  end
end
