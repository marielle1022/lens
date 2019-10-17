defmodule LensWeb.Router do
  use LensWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug LensWeb.Plugs.FetchCurrentUser
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", LensWeb do
    pipe_through :browser

    get "/", PageController, :index
    resources "/users", UserController
    resources "/photos", PhotoController
    get "/photos/:id/file", PhotoController, :file
    resources "/sessions", SessionController,
      only: [:new, :create, :delete], singleton: true
  end

  # Other scopes may use custom stacks.
  # scope "/api", LensWeb do
  #   pipe_through :api
  # end
end
