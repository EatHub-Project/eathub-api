defmodule EathubApi.V1.FollowingControllerTest do
  use EathubApi.ConnCase

  alias EathubApi.Following
  @valid_attrs %{displayName: "some content", idFollowedUser: "some content", idUser: "some content", username: "some content"}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, v1_following_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    following = Repo.insert! %Following{}
    conn = get conn, v1_following_path(conn, :show, following)
    assert json_response(conn, 200)["data"] == %{"id" => following.id,
      "displayName" => following.displayName,
      "username" => following.username,
      "idUser" => following.idUser,
      "idFollowedUser" => following.idFollowedUser}
  end

  test "does not show resource and instead throw error when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, v1_following_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, v1_following_path(conn, :create), following: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Following, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, v1_following_path(conn, :create), following: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    following = Repo.insert! %Following{}
    conn = put conn, v1_following_path(conn, :update, following), following: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Following, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    following = Repo.insert! %Following{}
    conn = put conn, v1_following_path(conn, :update, following), following: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    following = Repo.insert! %Following{}
    conn = delete conn, v1_following_path(conn, :delete, following)
    assert response(conn, 204)
    refute Repo.get(Following, following.id)
  end
end
