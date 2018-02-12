defmodule EathubWeb.V1.StepController do
  use EathubWeb, :controller

  alias Eathub.Recipes
  alias Eathub.Recipes.Step

  action_fallback EathubWeb.FallbackController

  def index(conn, _params) do
    steps = Recipes.list_steps()
    render(conn, "index.json-api", data: steps)
  end

  def create(conn, %{"step" => step_params}) do
    with {:ok, %Step{} = step} <- Recipes.create_step(step_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", api_v1_step_path(conn, :show, step))
      |> render("show.json-api", data: step)
    end
  end

  def show(conn, %{"id" => id}) do
    step = Recipes.get_step!(id)
    render(conn, "show.json-api", data: step)
  end

  def update(conn, %{"id" => id, "step" => step_params}) do
    step = Recipes.get_step!(id)

    with {:ok, %Step{} = step} <- Recipes.update_step(step, step_params) do
      render(conn, "show.json-api", data: step)
    end
  end

  def delete(conn, %{"id" => id}) do
    step = Recipes.get_step!(id)
    with {:ok, %Step{}} <- Recipes.delete_step(step) do
      send_resp(conn, :no_content, "")
    end
  end
end
