defmodule EathubWeb.UserControllerTest do
  use EathubWeb.ConnCase

  alias Eathub.Accounts
  alias Eathub.Accounts.User
  alias Eathub.Accounts.Guardian

  @create_attrs %{avatar: "some avatar", display_name: "some display_name", email: "some email", language: "some language", password: "some password", provider: "some provider", website: "some website"}
  @update_attrs %{avatar: "some updated avatar", display_name: "some updated display_name", email: "some updated email", language: "some updated language", password: "some updated password", provider: "some updated provider", website: "some updated website"}
  @invalid_attrs %{avatar: nil, display_name: nil, email: nil, language: nil, password: nil, provider: nil, website: nil}

  test "GET /", %{conn: conn} do
      conn = get conn, "/api/v1/users"
      assert json_response(conn, 200)["data"] != []
  end

  def fixture(:user) do
    {:ok, user} = Accounts.create_user(@create_attrs)
    user
  end

  setup %{conn: conn} do
    conn = conn
      |> put_req_header("accept", "application/vnd.api+json")
      |> put_req_header("content-type", "application/vnd.api+json")


      {:ok, %User{} = user} = %{avatar: "some avatar", display_name: "some display_name", email: "some email", language: "some language", password: "some password", provider: "some provider", website: "some website"}
        |> Accounts.create_user()

      conn = Guardian.Plug.sign_in(conn, user, %{})
      jwt = Guardian.Plug.current_token(conn)
      claims = Guardian.Plug.current_claims(conn)
      conn = conn
        |> put_resp_header("authorization", "Bearer #{jwt}")
    {:ok, conn: conn}
  end

  describe "index" do
    test "lists all users", %{conn: conn} do
      conn = get conn, "/api/v1/users"
      assert json_response(conn, 200)["data"] != []
    end
  end

  describe "create user" do
    test "renders user when data is valid", %{conn: conn} do
      conn = post conn, "/api/v1/users", user: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, api_v1_user_path(conn, :show, id)
      assert json_response(conn, 200)["data"]["attributes"]["id"] == id
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, "/api/v1/users", user: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update user" do
    setup [:create_user]

    test "renders user when data is valid", %{conn: conn, user: user} do
      conn = put conn, api_v1_user_path(conn, :update, user), user: @update_attrs
      assert %{"id" => id} = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, user: user} do
      conn = put conn, api_v1_user_path(conn, :update, user), user: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete user" do
    setup [:create_user]

    test "deletes chosen user", %{conn: conn, user: user} do
      conn = delete conn, api_v1_user_path(conn, :delete, user)
      assert response(conn, 204)
    end
  end

  defp create_user(_) do
    user = fixture(:user)
    {:ok, user: user}
  end
end
