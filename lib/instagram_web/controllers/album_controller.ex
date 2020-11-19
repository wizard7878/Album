defmodule InstagramWeb.AlbumController do
  use InstagramWeb , :controller
  alias Instagram.Article
  alias Instagram.Repo
  alias Instagram.Auth

  plug :check_topic_owner when action in [:update,:edit,:delete]
  def index(conn, _params) do
    IO.inspect(conn)
    IO.inspect("++++++++++++++++++++++++")
    posts = Repo.all(Article)
    IO.inspect(posts)
    render(conn, "index.html",posts: posts,repo: Repo,auth: Auth)
  end

  def edit(conn,%{"id" => article_id} = params) do
    IO.inspect(conn)
    IO.inspect("++++++++++++++++++++++++")

    old_post = Repo.get(Article,article_id)
    IO.inspect(old_post)

    changeset = Article.changeset(old_post)
    render conn,"edit.html",changeset: changeset , post: old_post
  end

  def update(conn,%{"article" => article} = params) do
    %{"id" => article_id} = params
    old_post = Repo.get(Article,article_id)
    changeset = Article.changeset(old_post,article)

    case Repo.update(changeset) do
      {:ok,_post} ->
        conn
        |> put_flash(:info,"Article Edited!")
        |> redirect(to: Routes.album_path(conn,:edit,old_post))
    end
  end

  def delete(conn,%{"id" => article_id} = params) do
    Repo.get(Article,article_id)
    |> Repo.delete!
    redirect(conn,to: Routes.album_path(conn,:index))
  end

  def show(conn,%{"id" => article_id}) do
    article = Repo.get(Article,article_id)
    render conn,"view.html" , article: article
  end

  def check_topic_owner(conn,params) do
    if conn.assigns.user do
      %{params: %{"id" => article_id}} = conn
      if Repo.get(Article,article_id).auth_id == conn.assigns.user.id do
        conn
      else
        conn
        |> put_flash(:error,"404 Not Found! :(")
        |> redirect(to: Routes.album_path(conn,:index))
        |> halt()
      end
    else
      conn
      |> put_flash(:error,"404 Not Found! :(")
      |> redirect(to: Routes.album_path(conn,:index))
      |> halt()
    end
end

end
