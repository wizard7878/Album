defmodule InstagramWeb.UserSocket do
  use Phoenix.Socket

  ## Channels
  channel "comments:*", InstagramWeb.CommentsChannel


  def connect(%{"token" => token}, socket, _connect_info) do
    IO.inspect(token)
    case Phoenix.Token.verify(socket,"key",token) do
      {:ok , user_id} ->
        IO.inspect(user_id)
        {:ok,assign(socket,:user_id,user_id)}
      {:error,_error} ->
        :error
    end
  end


  def id(_socket), do: nil
end
