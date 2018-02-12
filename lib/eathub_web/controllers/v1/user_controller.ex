defmodule EathubWeb.V1.UserController do
  use EathubWeb, :controller
  use PhoenixSwagger
  alias Eathub.Accounts
  alias Eathub.Accounts.User
  alias Eathub.Accounts.Guardian

  action_fallback EathubWeb.FallbackController

  swagger_path :index do
    get "/"
    summary "List all users"
    description "List all users"
    response 200, "Ok", Schema.ref(:Trackers)
  end
  def index(conn, _params) do
    users = Accounts.list_users()
    render(conn, "index.json-api", data: users)
  end

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Accounts.create_user(user_params) do
      conn
      |> put_status(:created)
      |> render("show.json-api", data: user)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    render(conn, "show.json-api", data: user)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Accounts.get_user!(id)

    with {:ok, %User{} = user} <- Accounts.update_user(user, user_params) do
      render(conn, "show.json-api", data: user)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    with {:ok, %User{}} <- Accounts.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end

  #Account login/logout
  def login(conn, %{"user" => %{"display_name" => username, "password" => password}}) do
    Accounts.authenticate_user(username, password)
    |> login_reply(conn)
  end

  defp login_reply({:error, _error}, conn) do
    conn
    |> put_status(:error)
  end

  defp login_reply({:ok, user}, conn) do
    new_conn = Guardian.Plug.sign_in(conn, user)
     jwt = Guardian.Plug.current_token(new_conn)
     claims = Guardian.Plug.current_claims(new_conn)
     exp = Map.get(claims, "exp")
     new_conn
     |> put_resp_header("authorization", "Bearer #{jwt}")
     |> put_resp_header("x-expires", Kernel.inspect(exp))
     |> json(%{access_token: jwt})
  end

  def logout(conn, _) do
    jwt = Guardian.Plug.current_token(conn)
    claims = Guardian.Plug.current_claims(conn)
    Guardian.revoke(jwt, claims)
    json(conn, %{logout: true})
  end

  def secret(conn, _params) do
    user = Guardian.Plug.current_resource(conn)
    render(conn, "show.json-api", data: user)
  end

  def swagger_definitions do
    %{
      Tracker: swagger_schema do
        title "User"
        description "An activity which has been recorded"
        properties do
          id :string, "The ID of the user"
          avatar :string, "User Avatar", required: false
          display_name :string, "Username", required: false
          email :string, "Email", required: true
          language :string, "Language", required: false
          provider :string, "Auth's provider", required: false
          website :string, "Just in case", required: false
          inserted_at :string, "When was initially inserted", format: "ISO-8601"
          updated_at :string, "When was last updated", format: "ISO-8601"
        end
        example %{
          avatar: "http://path.to.picture",
          display_name: "John Doe",
          email: "email@addr.ess",
          language: "Spanish",
          provider: "Google",
          website: "http://ihave.a.website"
        }
      end
    }
  end
end
