defmodule EathubApi.V1.FollowingController do
  use EathubApi.Web, :controller

  alias EathubApi.Following

  plug :scrub_params, "following" when action in [:create, :update]

  def index(conn, _params) do
    followings = Repo.all(Following)
    render(conn, "index.json", followings: followings)
  end

  def create(conn, %{"following" => following_params}) do
    changeset = Following.changeset(%Following{}, following_params)

    case Repo.insert(changeset) do
      {:ok, following} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", v1_following_path(conn, :show, following))
        |> render("show.json", following: following)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(EathubApi.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    following = Repo.get!(Following, id)
    render(conn, "show.json", following: following)
  end

  def update(conn, %{"id" => id, "following" => following_params}) do
    following = Repo.get!(Following, id)
    changeset = Following.changeset(following, following_params)

    case Repo.update(changeset) do
      {:ok, following} ->
        render(conn, "show.json", following: following)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(EathubApi.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    following = Repo.get!(Following, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(following)

    send_resp(conn, :no_content, "")
  end
end
