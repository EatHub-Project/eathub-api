defmodule EathubWeb.V1.AuthController do
  use EathubWeb, :controller
  plug Ueberauth

  alias Eathub.Accounts.User
  alias Eathub.Accounts.AuthUser
  alias Eathub.Accounts.Guardian
  alias Eathub.Repo
  import Ecto.Query
  plug :scrub_params, "user" when action in [:sign_in_user]

  def request(_params) do
  end

  def delete(conn, _params) do
    # Sign out the user
    jwt = Guardian.Plug.current_token(conn)
    claims = Guardian.Plug.current_claims(conn)
    Guardian.revoke(jwt, claims)
    json(conn, %{logout: true})
  end

  def callback(%{assigns: %{ueberauth_failure: _fails}} = conn, _params) do
    # This callback is called when the user denies the app to get the data from the oauth provider
    conn
    |> put_status(401)
    |> render(EathubWeb.ErrorView, "401.json-api")
  end

  def callback(%{assigns: %{ueberauth_auth: auth}} = conn, _params) do
    case AuthUser.basic_info(auth) do
      {:ok, user} ->
        sign_in_user(conn, %{"user" => user})
    end

  case AuthUser.basic_info(auth) do
      {:ok, user} ->
        conn
        |> render("show.json-api", data: user)
      {:error} ->
        conn
        |> put_status(401)
        |> render(EathubWeb.ErrorView, "401.json-api")
    end
  end

  def sign_in_user(conn, %{"user" => user}) do
    try do
      # Attempt to retrieve exactly one user from the DB, whose
      # email matches the one provided with the login request
      user = User
      |> where(email: ^user.email)
      |> Repo.one!

      cond do
        true ->
          new_conn = Guardian.Plug.sign_in(conn, user)
          jwt = Guardian.Plug.current_token(new_conn)
          claims = Guardian.Plug.current_claims(new_conn)
          exp = Map.get(claims, "exp")
          new_conn
            |> put_resp_header("authorization", "Bearer #{jwt}")
            |> put_resp_header("x-expires", Kernel.inspect(exp))
            |> json(%{access_token: jwt})

        false ->
          # Unsuccessful login
          conn
          |> put_status(401)
          |> render(EathubWeb.ErrorView, "401.json-api")
      end
    rescue
      e ->
        IO.inspect e # Print error to the console for debugging

        # Successful registration
        sign_up_user(conn, %{"user" => user})
    end
  end

  def sign_up_user(conn, %{"user" => user}) do
    changeset = User.changeset %User{}, %{avatar: user.avatar,
      display_name: user.first_name,
      email: user.email,
      provider: "google"}

    case Repo.insert_or_update changeset do
      {:ok, user} ->
        new_conn = Guardian.Plug.sign_in(conn, user)
        jwt = Guardian.Plug.current_token(new_conn)
        claims = Guardian.Plug.current_claims(new_conn)
        exp = Map.get(claims, "exp")
        new_conn
          |> put_resp_header("authorization", "Bearer #{jwt}")
          |> put_resp_header("x-expires", Kernel.inspect(exp))
          |> json(%{access_token: jwt})
      {:error, _changeset} ->
        conn
        |> put_status(422)
        |> render(EathubWeb.ErrorView, "422.json-api")
    end
  end

  def unauthenticated(conn, _params) do
    conn
    |> put_status(401)
    |> render(EathubWeb.ErrorView, "401.json-api")
  end

  def unauthorized(conn, _params) do
    conn
    |> put_status(403)
    |> render(EathubWeb.ErrorView, "403.json-api")
  end

  def already_authenticated(conn, _params) do
    conn
    |> put_status(200)
    |> render(EathubWeb.ErrorView, "200.json-api")
  end

  def no_resource(conn, _params) do
    conn
    |> put_status(404)
    |> render(EathubWeb.ErrorView, "404.json-api")
  end
end
