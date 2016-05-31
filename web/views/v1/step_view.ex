defmodule EathubApi.V1.StepView do
  use EathubApi.Web, :view

  def render("index.json", %{steps: steps}) do
    %{data: render_many(steps, EathubApi.V1.StepView, "step.json")}
  end

  def render("show.json", %{step: step}) do
    %{data: render_one(step, EathubApi.V1.StepView, "step.json")}
  end

  def render("step.json", %{step: step}) do
    %{id: step.id,
      idRecipe: step.idRecipe,
      text: step.text,
      idPicture: step.idPicture}
  end
end
