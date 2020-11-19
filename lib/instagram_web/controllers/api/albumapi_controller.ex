defmodule InstagramWeb.AlbumApiController do
  use InstagramWeb , :controller
  alias Instagram.Repo
  alias Instagram.Article

  def index(conn,params) do
    IO.inspect(conn)
    article = Repo.all(Article)
    render conn ,"index.json" , album_api: article
  end

  def show(conn,%{"id" => id} = params) do

    article = Repo.get(Article,id)
    render conn,"show.json",takArticle: article
  end

  def create(conn,params) do
    IO.inspect(params)
    changeset = Article.changeset(%Article{},params)
    Repo.insert(changeset)
    conn
    |> put_status(:created)
    |> render("show.json", takArticle: params)
    # |> put_resp_header("location", Routes.documnt_path(conn, :show, article))
  end

  def delete(conn,%{ "id" => id}= params) do
    IO.inspect(id)
    id = String.to_integer(id)
    Repo.get(Article,id)
    |> Repo.delete!
  end
end
