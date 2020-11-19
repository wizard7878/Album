defmodule InstagramWeb.DashboardController do
  use InstagramWeb , :controller

  alias Instagram.Article
  alias Instagram.Auth
  alias Instagram.Repo
  plug :check_login when action in [:index , :create]
  def index(conn,_params) do

    changeset = Article.changeset(%Article{},%{})
    render conn,"index.html",changeset: changeset
  end
  def create(conn,%{"article" => %{"title" => title , "body" => body,"image" => image }} = params) do
    if title == "" or body == "" do
      conn
      |> put_flash(:error,"Please fill out all the forms")
      |> redirect(to: Routes.dashboard_path(conn,:index))
    end
    %{"article" => article} = params
      upload = image
      File.cp(upload.path, "assets/static/images/#{upload.filename}")

    changeset = conn.assigns.user
    |> Ecto.build_assoc(:article)
    |> Article.changeset(%{title: title ,body: body ,image: image.filename})


     case Repo.insert(changeset) do
      {:ok,_post} ->
        conn
        |> put_flash(:info,"Article Sent!")
        |> render("index.html",changeset: changeset)
      {:error, resaon} ->
        conn
        |> put_flash(:error,resaon)
        |> render(:index)

     end
  end

  def check_login(conn,_params) do
    if(conn.assigns.user) do
      conn
    else
      conn
      |> put_flash(:error,"You must login first!")
      |> redirect(to: Routes.album_path(conn,:index))
      |> halt()
    end
  end
end
