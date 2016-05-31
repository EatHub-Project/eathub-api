defmodule EathubApi.V1.StepController do
  use EathubApi.Web, :controller

  alias EathubApi.Step

  plug :scrub_params, "step" when action in [:create, :update]

  def index(conn, _params) do
    steps = Repo.all(Step)
    render(conn, "index.json", steps: steps)
  end

  def create(conn, %{"step" => step_params}) do
    changeset = Step.changeset(%Step{}, step_params)

    case Repo.insert(changeset) do
      {:ok, step} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", v1_step_path(conn, :show, step))
        |> render("show.json", step: step)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(EathubApi.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    step = Repo.get!(Step, id)
    render(conn, "show.json", step: step)
  end

  def update(conn, %{"id" => id, "step" => step_params}) do
    step = Repo.get!(Step, id)
    changeset = Step.changeset(step, step_params)

    case Repo.update(changeset) do
      {:ok, step} ->
        render(conn, "show.json", step: step)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(EathubApi.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    step = Repo.get!(Step, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(step)

    send_resp(conn, :no_content, "")
  end
end
