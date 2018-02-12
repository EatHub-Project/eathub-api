defmodule EathubWeb.Router do
  use EathubWeb, :router

  pipeline :api do
    plug :accepts, ["json-api"]
  end

  pipeline :auth do
    plug Eathub.Accounts.Pipeline
  end

  pipeline :ensure_auth do
    plug Guardian.Plug.EnsureAuthenticated
    plug Guardian.Plug.VerifyHeader, realm: "Bearer"
    plug Guardian.Plug.LoadResource
  end

  scope "/api", EathubWeb, as: :api do
    pipe_through [:api, :auth]

    scope "/v1", V1, as: :v1 do
      post "/login", UserController, :login
      resources "/users", UserController
      resources "/recipes", RecipeController
      resources "/steps", StepController
      resources "/ingredients", IngredientController

      scope "/auth" do
        get "/:provider", AuthController, :request
        get "/:provider/callback", AuthController, :callback
        post "/:provider/callback", AuthController, :callback
      end
    end
  end

  scope "/api", EathubWeb, as: :api do
    pipe_through [:api, :auth, :ensure_auth]

    scope "/v1", V1, as: :v1 do
      get "/secret", UserController, :secret

      #resources "/images", ImageController, only: [:create]

      scope "/images" do
        post "/user/:id", ImageController, :upload_user_avatar
        post "/recipe/:id", ImageController, :upload_recipe_image
        post "/recipe/:id", ImageController, :upload_step_image
      end

      scope "/auth" do
        post "/logout", AuthController, :delete
      end
    end
  end

  scope "/swagger" do
    forward "/", PhoenixSwagger.Plug.SwaggerUI,
      otp_app: :eathub,
      swagger_file: "swagger.json",
      disable_validator: true
  end

  def swagger_info do
    %{
      info: %{
        version: "1.0",
        title: "Eathub"
      }
    }
  end
end
