defmodule Eathub.RecipesTest do
  use Eathub.DataCase

  alias Eathub.Recipes
  alias Eathub.Accounts

  describe "recipes" do
    alias Eathub.Recipes.Recipe

    @valid_attrs %{description: "some description", language: "some language", main_image: "some main_image", notes: "some notes", serves: 42, time: 42, title: "some title",
    user: %{avatar: "some avatar", display_name: "some display_name", email: "some email", language: "some language", password: "some password", provider: "some provider", website: "some website"},
    steps: [%{text: "paso 2", image: "image 2", position: 1}],
    ingredients: [%{text: "tomate", position: 0}]}
    @update_attrs %{description: "some updated description", language: "some updated language", main_image: "some updated main_image", notes: "some updated notes", serves: 43, time: 43, title: "some updated title"}
    @invalid_attrs %{description: nil, language: nil, main_image: nil, notes: nil, serves: nil, time: nil, title: nil}

    def recipe_fixture(attrs \\ %{}) do
      {:ok, recipe} =
        Recipe.changeset(%Recipe{}, @valid_attrs)
        |> Recipes.create_recipe()
      recipe
    end

    test "list_recipes/0 returns all recipes" do
      recipe = recipe_fixture()
      assert length(Recipes.list_recipes()) == 1
    end

    test "get_recipe!/1 returns the recipe with given id" do
      recipe = recipe_fixture()
      assert Recipes.get_recipe!(recipe.id).id == recipe.id
    end

    test "create_recipe/1 with valid data creates a recipe" do
      assert {:ok, %Recipe{} = recipe} = Recipes.create_recipe(Recipe.changeset(%Recipe{}, @valid_attrs))
      assert recipe.description == "some description"
      assert recipe.language == "some language"
      assert recipe.main_image == "some main_image"
      assert recipe.notes == "some notes"
      assert recipe.serves == 42
      assert recipe.time == 42
      assert recipe.title == "some title"
    end

    test "create_recipe/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Recipes.create_recipe(Recipe.changeset(%Recipe{}, @invalid_attrs))
    end

    test "update_recipe/2 with valid data updates the recipe" do
      recipe = recipe_fixture()
      assert {:ok, recipe} = Recipes.update_recipe(recipe, @update_attrs)
      assert %Recipe{} = recipe
      assert recipe.description == "some updated description"
      assert recipe.language == "some updated language"
      assert recipe.main_image == "some updated main_image"
      assert recipe.notes == "some updated notes"
      assert recipe.serves == 43
      assert recipe.time == 43
      assert recipe.title == "some updated title"
    end

    test "update_recipe/2 with invalid data returns error changeset" do
      recipe = recipe_fixture()
      assert {:error, %Ecto.Changeset{}} = Recipes.update_recipe(recipe, @invalid_attrs)
      assert recipe.id == Recipes.get_recipe!(recipe.id).id
    end

    test "delete_recipe/1 deletes the recipe" do
      recipe = recipe_fixture()
      assert {:ok, %Recipe{}} = Recipes.delete_recipe(recipe)
      assert_raise Ecto.NoResultsError, fn -> Recipes.get_recipe!(recipe.id) end
    end
  end

  describe "steps" do
    alias Eathub.Recipes.Step

    @valid_attrs %{image: "some image", position: 42, text: "some text"}
    @update_attrs %{image: "some updated image", position: 43, text: "some updated text"}
    @invalid_attrs %{image: nil, position: nil, text: nil}

    def step_fixture(attrs \\ %{}) do
      {:ok, step} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Recipes.create_step()

      step
    end

    test "list_steps/0 returns all steps" do
      step = step_fixture()
      assert Recipes.list_steps() == [step]
    end

    test "get_step!/1 returns the step with given id" do
      step = step_fixture()
      assert Recipes.get_step!(step.id) == step
    end

    test "create_step/1 with valid data creates a step" do
      assert {:ok, %Step{} = step} = Recipes.create_step(@valid_attrs)
      assert step.image == "some image"
      assert step.position == 42
      assert step.text == "some text"
    end

    test "create_step/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Recipes.create_step(@invalid_attrs)
    end

    test "update_step/2 with valid data updates the step" do
      step = step_fixture()
      assert {:ok, step} = Recipes.update_step(step, @update_attrs)
      assert %Step{} = step
      assert step.image == "some updated image"
      assert step.position == 43
      assert step.text == "some updated text"
    end

    test "update_step/2 with invalid data returns error changeset" do
      step = step_fixture()
      assert {:error, %Ecto.Changeset{}} = Recipes.update_step(step, @invalid_attrs)
      assert step == Recipes.get_step!(step.id)
    end

    test "delete_step/1 deletes the step" do
      step = step_fixture()
      assert {:ok, %Step{}} = Recipes.delete_step(step)
      assert_raise Ecto.NoResultsError, fn -> Recipes.get_step!(step.id) end
    end

    test "change_step/1 returns a step changeset" do
      step = step_fixture()
      assert %Ecto.Changeset{} = Recipes.change_step(step)
    end
  end

  describe "ingredients" do
    alias Eathub.Recipes.Ingredient

    @valid_attrs %{position: 42, text: "some text"}
    @update_attrs %{position: 43, text: "some updated text"}
    @invalid_attrs %{position: nil, text: nil}

    def ingredient_fixture(attrs \\ %{}) do
      {:ok, ingredient} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Recipes.create_ingredient()

      ingredient
    end

    test "list_ingredients/0 returns all ingredients" do
      ingredient = ingredient_fixture()
      assert Recipes.list_ingredients() == [ingredient]
    end

    test "get_ingredient!/1 returns the ingredient with given id" do
      ingredient = ingredient_fixture()
      assert Recipes.get_ingredient!(ingredient.id) == ingredient
    end

    test "create_ingredient/1 with valid data creates a ingredient" do
      assert {:ok, %Ingredient{} = ingredient} = Recipes.create_ingredient(@valid_attrs)
      assert ingredient.position == 42
      assert ingredient.text == "some text"
    end

    test "create_ingredient/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Recipes.create_ingredient(@invalid_attrs)
    end

    test "update_ingredient/2 with valid data updates the ingredient" do
      ingredient = ingredient_fixture()
      assert {:ok, ingredient} = Recipes.update_ingredient(ingredient, @update_attrs)
      assert %Ingredient{} = ingredient
      assert ingredient.position == 43
      assert ingredient.text == "some updated text"
    end

    test "update_ingredient/2 with invalid data returns error changeset" do
      ingredient = ingredient_fixture()
      assert {:error, %Ecto.Changeset{}} = Recipes.update_ingredient(ingredient, @invalid_attrs)
      assert ingredient == Recipes.get_ingredient!(ingredient.id)
    end

    test "delete_ingredient/1 deletes the ingredient" do
      ingredient = ingredient_fixture()
      assert {:ok, %Ingredient{}} = Recipes.delete_ingredient(ingredient)
      assert_raise Ecto.NoResultsError, fn -> Recipes.get_ingredient!(ingredient.id) end
    end

    test "change_ingredient/1 returns a ingredient changeset" do
      ingredient = ingredient_fixture()
      assert %Ecto.Changeset{} = Recipes.change_ingredient(ingredient)
    end
  end
end
