defmodule EathubApi.V1.TasteControllerTest do
  use EathubApi.ConnCase

  alias EathubApi.Taste
  @valid_attrs %{bitter: 42, salty: 42, sour: 42, spicy: 42, sweet: 42}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, v1_taste_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    taste = Repo.insert! %Taste{}
    conn = get conn, v1_taste_path(conn, :show, taste)
    assert json_response(conn, 200)["data"] == %{"id" => taste.id,
      "salty" => taste.salty,
      "sour" => taste.sour,
      "bitter" => taste.bitter,
      "sweet" => taste.sweet,
      "spicy" => taste.spicy}
  end

  test "does not show resource and instead throw error when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, v1_taste_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, v1_taste_path(conn, :create), taste: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Taste, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, v1_taste_path(conn, :create), taste: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    taste = Repo.insert! %Taste{}
    conn = put conn, v1_taste_path(conn, :update, taste), taste: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Taste, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    taste = Repo.insert! %Taste{}
    conn = put conn, v1_taste_path(conn, :update, taste), taste: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    taste = Repo.insert! %Taste{}
    conn = delete conn, v1_taste_path(conn, :delete, taste)
    assert response(conn, 204)
    refute Repo.get(Taste, taste.id)
  end
end
