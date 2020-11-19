defmodule InstagramWeb.Router do
  use InstagramWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug InstagramWeb.Plugs.SetUser
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", InstagramWeb do
    pipe_through :browser

    get "/", AlbumController, :index
    get "/dashboard/form", DashboardController , :index
    get "/edit/:id" , AlbumController,:edit
    put "/edit/update/:id",AlbumController,:update
    post "/dashboard/send" , DashboardController , :create
    delete "/delete/:id" , AlbumController,:delete
    get "view/:id" , AlbumController , :show
  end


  scope "/auth", InstagramWeb do
    pipe_through :browser
    pipe_through :api
    get "/register" ,AuthController , :register
    post "/registering",AuthController,:registering
    get "/login" , AuthController , :login
    post "login/" , AuthController,:callback
    get "logout" , AuthController ,:logout

    get "/:provider" , AuthController , :request_google
    get "/:provider/callback" , AuthController , :callback_google
  end


  # Other scopes may use custom stacks.
  scope "/api", InstagramWeb do
    pipe_through :api

    get "/albums" , AlbumApiController , :index
    get "/albums/:id" , AlbumApiController , :show
    post "/albums/create" , AlbumApiController , :create
    delete "/albums/delete" ,AlbumApiController , :delete
  end
#/:title/:body/:image
  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  # if Mix.env() in [:dev, :test] do
  #   import Phoenix.LiveDashboard.Router

  #   scope "/" do
  #     pipe_through :browser
  #     live_dashboard "/dashboard", metrics: InstagramWeb.Telemetry
  #   end
  # end
end
