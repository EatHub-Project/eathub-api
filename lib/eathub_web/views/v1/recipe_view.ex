defmodule EathubWeb.V1.RecipeView do
  use EathubWeb, :view
  alias EathubWeb.V1.RecipeView

  attributes [:id, :user, :title, :description, :main_image, :serves, :time, :notes, :language, :steps, :ingredients]
end
