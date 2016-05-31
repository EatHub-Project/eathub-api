defmodule EathubApi.Router do
  use EathubApi.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", EathubApi do
    pipe_through :api

    scope "/v1", V1, as: :v1 do
          resources "/tastes", TasteController
          resources "/users", UserController
        end
  end

  # Other scopes may use custom stacks.
  # scope "/api", EathubApi do
  #   pipe_through :api
  # end
end
