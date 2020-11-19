defmodule InstagramWeb.CommentsChannel do
  use InstagramWeb, :channel
  alias Instagram.Article
  alias Instagram.Repo
  alias Instagram.Comment

  def join("comments:" <> album_id, _params, socket) do
    album_id = String.to_integer(album_id)
    IO.inspect(album_id)
    album = Article
    |> Repo.get(album_id)
    |> Repo.preload(comments: [:auth])  # connect users that also associated with comments
                                        # |> Repo.preload(:comments) // only associate with articles to comments
    IO.inspect(album)
    {:ok,%{comments: album.comments},assign(socket,:album, album)}

  end

  def handle_in(name,%{"content" => content},socket) do
    album = socket.assigns.album
    user_id = socket.assigns.user_id
    changeset = album
    |> Ecto.build_assoc(:comments,auth_id: user_id)
    |> Comment.changeset(%{content: content})

    case Repo.insert(changeset) do
      {:ok , comment} ->
        broadcast!(socket,"comments:#{socket.assigns.album.id}:new",%{comment: comment})
        {:reply,:ok,  socket}
      {:error,_reason} ->
        {:reply, {:error,%{errors: changeset}}, socket}
      end
  end

end
