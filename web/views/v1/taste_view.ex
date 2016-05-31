defmodule EathubApi.V1.TasteView do
  use EathubApi.Web, :view

  def render("index.json", %{tastes: tastes}) do
    %{data: render_many(tastes, EathubApi.V1.TasteView, "taste.json")}
  end

  def render("show.json", %{taste: taste}) do
    %{data: render_one(taste, EathubApi.V1.TasteView, "taste.json")}
  end

  def render("taste.json", %{taste: taste}) do
    %{id: taste.id,
      idTaste: taste.idTaste,
      salty: taste.salty,
      sour: taste.sour,
      bitter: taste.bitter,
      sweet: taste.sweet,
      spicy: taste.spicy}
  end
end
