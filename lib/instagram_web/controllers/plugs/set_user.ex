defmodule InstagramWeb.Plugs.SetUser do
  import Plug.Conn
  import Phoenix.Controller

  alias Instagram.Repo
  alias Instagram.Auth

  def init(_params) do
  end

  def call(conn,_params) do
    user_id = get_session(conn,:user)

    cond do
      user = user_id && Repo.get(Auth,user_id) ->
        assign(conn,:user,user)

      true ->
        assign(conn,:user,nil)
    end
  end
end
