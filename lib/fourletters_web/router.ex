defmodule FourlettersWeb.Router do
  use FourlettersWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", FourlettersWeb do
    pipe_through :browser

    get "/", FourlettersController, :nothing
    get "/:fourletters", FourlettersController, :fourletters
  end

  # Other scopes may use custom stacks.
  scope "/", FourlettersWeb do
    pipe_through :api

    post "/:fourletters", FourlettersController, :addletters
    get "/api/:fourletters", FourlettersController, :getmessages

    post "/api/:fourletters", FourlettersController, :apiaddletters

    delete "/api/:fourletters", FourlettersController, :clearletters

    # for stupid html forms that dont do DELETE
    post "/api/clear/:fourletters", FourlettersController, :clearletters
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: FourlettersWeb.Telemetry
    end
  end
end
