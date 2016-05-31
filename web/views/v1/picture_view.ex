defmodule EathubApi.V1.PictureView do
  use EathubApi.Web, :view

  def render("index.json", %{pictures: pictures}) do
    %{data: render_many(pictures, EathubApi.V1.PictureView, "picture.json")}
  end

  def render("show.json", %{picture: picture}) do
    %{data: render_one(picture, EathubApi.V1.PictureView, "picture.json")}
  end

  def render("picture.json", %{picture: picture}) do
    %{id: picture.id,
      idUser: picture.idUser,
      image: picture.image}
  end
end
