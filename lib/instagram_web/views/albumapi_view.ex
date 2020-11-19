defmodule InstagramWeb.AlbumApiView do
  use InstagramWeb, :view
  alias InstagramWeb.AlbumApiView


  def render("index.json", %{album_api: article}) do
    %{data: render_many(article, AlbumApiView, "article.json")}
  end

  def render("show.json",%{takArticle: article}) do
    %{data: render_one(article,AlbumApiView,"article.json")}
  end


  def render("article.json",%{album_api: article}) do
    %{
      id: article.id,
      name: article.title,
      image: article.image,
      auth_id: article.auth_id
    }
  end
end
