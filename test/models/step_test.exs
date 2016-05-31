defmodule EathubApi.StepTest do
  use EathubApi.ModelCase

  alias EathubApi.Step

  @valid_attrs %{idPicture: "some content", idRecipe: "some content", text: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Step.changeset(%Step{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Step.changeset(%Step{}, @invalid_attrs)
    refute changeset.valid?
  end
end
