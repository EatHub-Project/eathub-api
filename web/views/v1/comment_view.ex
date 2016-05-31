defmodule EathubApi.V1.CommentView do
  use EathubApi.Web, :view

  def render("index.json", %{comments: comments}) do
    %{data: render_many(comments, EathubApi.V1.CommentView, "comment.json")}
  end

  def render("show.json", %{comment: comment}) do
    %{data: render_one(comment, EathubApi.V1.CommentView, "comment.json")}
  end

  def render("comment.json", %{comment: comment}) do
    %{id: comment.id,
      idRecipe: comment.idRecipe,
      text: comment.text,
      createDate: comment.createDate,
      idAuthor: comment.idAuthor,
      isBanned: comment.isBanned}
  end
end
