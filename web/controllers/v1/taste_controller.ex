defmodule EathubApi.V1.TasteController do
  use EathubApi.Web, :controller

  alias EathubApi.Taste

  plug :scrub_params, "taste" when action in [:create, :update]

  def index(conn, _params) do
    tastes = Repo.all(Taste)
    render(conn, "index.json", tastes: tastes)
  end

  def create(conn, %{"taste" => taste_params}) do
    changeset = Taste.changeset(%Taste{}, taste_params)

    case Repo.insert(changeset) do
      {:ok, taste} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", v1_taste_path(conn, :show, taste))
        |> render("show.json", taste: taste)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(EathubApi.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    taste = Repo.get!(Taste, id)
    render(conn, "show.json", taste: taste)
  end

  def update(conn, %{"id" => id, "taste" => taste_params}) do
    taste = Repo.get!(Taste, id)
    changeset = Taste.changeset(taste, taste_params)

    case Repo.update(changeset) do
      {:ok, taste} ->
        render(conn, "show.json", taste: taste)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(EathubApi.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    taste = Repo.get!(Taste, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(taste)

    send_resp(conn, :no_content, "")
  end
end
