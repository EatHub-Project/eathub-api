defmodule EathubApi.V1.RecipeView do
  use EathubApi.Web, :view

  def render("index.json", %{recipes: recipes}) do
    %{data: render_many(recipes, EathubApi.V1.RecipeView, "recipe.json")}
  end

  def render("show.json", %{recipe: recipe}) do
    %{data: render_one(recipe, EathubApi.V1.RecipeView, "recipe.json")}
  end

  def render("recipe.json", %{recipe: recipe}) do
    %{id: recipe.id,
      title: recipe.title,
      creationDate: recipe.creationDate,
      mainImage: recipe.mainImage,
      modificationDate: recipe.modificationDate,
      serves: recipe.serves,
      language: recipe.language,
      temporality: recipe.temporality,
      nationality: recipe.nationality,
      notes: recipe.notes,
      difficult: recipe.difficult,
      foodType: recipe.foodType,
      isPublished: recipe.isPublished,
      idParentRecipe: recipe.idParentRecipe,
      author: recipe.author,
      savours: recipe.savours,
      preparationTime: recipe.preparationTime,
      cookTime: recipe.cookTime}
  end
end
