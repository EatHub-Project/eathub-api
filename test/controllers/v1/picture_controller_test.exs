defmodule EathubApi.V1.PictureControllerTest do
  use EathubApi.ConnCase

  alias EathubApi.Picture
  @valid_attrs %{idUser: "some content", image: "some content"}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, v1_picture_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    picture = Repo.insert! %Picture{}
    conn = get conn, v1_picture_path(conn, :show, picture)
    assert json_response(conn, 200)["data"] == %{"id" => picture.id,
      "idUser" => picture.idUser,
      "image" => picture.image}
  end

  test "does not show resource and instead throw error when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, v1_picture_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, v1_picture_path(conn, :create), picture: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Picture, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, v1_picture_path(conn, :create), picture: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    picture = Repo.insert! %Picture{}
    conn = put conn, v1_picture_path(conn, :update, picture), picture: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Picture, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    picture = Repo.insert! %Picture{}
    conn = put conn, v1_picture_path(conn, :update, picture), picture: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    picture = Repo.insert! %Picture{}
    conn = delete conn, v1_picture_path(conn, :delete, picture)
    assert response(conn, 204)
    refute Repo.get(Picture, picture.id)
  end
end
