defmodule EathubApi.V1.FollowingView do
  use EathubApi.Web, :view

  def render("index.json", %{followings: followings}) do
    %{data: render_many(followings, EathubApi.V1.FollowingView, "following.json")}
  end

  def render("show.json", %{following: following}) do
    %{data: render_one(following, EathubApi.V1.FollowingView, "following.json")}
  end

  def render("following.json", %{following: following}) do
    %{id: following.id,
      displayName: following.displayName,
      username: following.username,
      idUser: following.idUser,
      idFollowedUser: following.idFollowedUser}
  end
end
