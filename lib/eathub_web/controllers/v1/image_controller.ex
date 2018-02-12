defmodule EathubWeb.V1.ImageController do
  use EathubWeb, :controller

  alias Eathub.Accounts
  alias Eathub.Recipes

  def create(conn, %{"image" => file }) do
    conn
    |> put_status(201)
    |> json(%{"image_url" => upload_image(file) })
  end

  defp upload_image(file) do
    Eathub.AssetStore.upload_image(file)
  end

  def upload_user_avatar(conn, %{"id" => id, "image" => file}) do
    Accounts.get_user!(id)
    |> Accounts.update_user(%{avatar: avatar_url = upload_image(file)})
    conn
    |> put_status(201)
    |> json(%{"image_url" => avatar_url })
  end

  def upload_recipe_image(conn, %{"id" => id, "image" => file}) do
    Recipes.get_recipe!(id)
    |> Recipes.update_recipe(%{main_image: main_image = upload_image(file)})
    conn
    |> put_status(201)
    |> json(%{"image_url" => main_image })
  end

  def upload_step_image(conn, %{"id" => id, "image" => file}) do
    Recipes.get_step!(id)
    |> Recipes.update_step(%{image: main_image = upload_image(file)})
    conn
    |> put_status(201)
    |> json(%{"image_url" => main_image })
  end
end
