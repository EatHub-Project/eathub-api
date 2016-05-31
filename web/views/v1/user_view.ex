defmodule EathubApi.V1.UserView do
  use EathubApi.Web, :view

  def render("index.json", %{users: users}) do
    %{data: render_many(users, EathubApi.V1.UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, EathubApi.V1.UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{id: user.id,
      displayName: user.displayName,
      modificationDate: user.modificationDate,
      mainLanguage: user.mainLanguage,
      avatar: user.avatar,
      website: user.website,
      gender: user.gender,
      birthDate: user.birthDate,
      location: user.location,
      karma: user.karma,
      username: user.username}
  end
end
