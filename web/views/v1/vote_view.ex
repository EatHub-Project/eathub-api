defmodule EathubApi.V1.VoteView do
  use EathubApi.Web, :view

  def render("index.json", %{votes: votes}) do
    %{data: render_many(votes, EathubApi.V1.VoteView, "vote.json")}
  end

  def render("show.json", %{vote: vote}) do
    %{data: render_one(vote, EathubApi.V1.VoteView, "vote.json")}
  end

  def render("vote.json", %{vote: vote}) do
    %{id: vote.id,
      idRecipe: vote.idRecipe,
      date: vote.date,
      idUser: vote.idUser}
  end
end
