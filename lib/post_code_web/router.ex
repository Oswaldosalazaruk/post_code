defmodule PostCodeWeb.Router do
  use PostCodeWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {PostCodeWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", PostCodeWeb do
    pipe_through :browser

    get "/", PageController, :home
    live "/codes", CodeLive.Index, :index
    live "/codes/new", CodeLive.Index, :new
    live "/codes/:id/edit", CodeLive.Index, :edit

    live "/codes/:id", CodeLive.Show, :show
    live "/codes/:id/show/edit", CodeLive.Show, :edit
  end

  # Other scopes may use custom stacks.
  scope "/api", PostCodeWeb do
    pipe_through :api
    resources "/codes", CodeController, except: [:new, :edit]
  end
end
