defmodule InstagramWeb.AuthController do
  use InstagramWeb, :controller
  alias Instagram.Auth
  alias Instagram.Repo
  plug Ueberauth

  def login(conn,_params) do
    changeset = Auth.changeset(%Auth{},%{})
    render(conn,"login.html" , changeset: changeset)
  end

  def register(conn,_params) do
    changeset = Auth.changeset(%Auth{},%{})
    render(conn,"register.html",changeset: changeset)
  end

  def registering(conn,%{"auth" => auth } = params) do
    %{"password" => password1 , "re_password" => password2,"email" => email} = auth

    if Repo.get_by(Auth,email: email) do
        conn
        |> put_flash(:error,"This Email has been registed before!")
        |> redirect(to: Routes.auth_path(conn,:register))

    else
        if password1 === password2 do
            user = %{auth | "password" => "#{Argon2.add_hash(password1).password_hash}"}
            changeset = Auth.changeset(%Auth{},user)

            case Repo.insert(changeset) do
              {:ok,_user} ->
                conn
                |> put_flash(:info,"You have Registered!")
                |> redirect(to: Routes.auth_path(conn,:register))
              {:error,_changeset} ->
                conn
                |> put_flash(:error,"Some thing went wrong!")
                |> redirect(to: Routes.auth_path(conn,:register))
              end
        else
              conn
              |> put_flash(:error,"Passwords are diffrent")
              |> redirect(to: Routes.auth_path(conn,:register))
          end
      end
    end

  def callback(conn , %{"auth" => auth}) do
    %{"email" => email , "password" => password } = auth
    user = Repo.get_by(Auth,email: email)
    if !user do
      conn
      |> put_flash(:error,"User not found! if you haven't register before please click on Register Link")
      |> redirect(to: Routes.auth_path(conn,:login))
    end
    if Argon2.verify_pass(password,user.password) do
      conn
      |> put_session(:user, user.id)
      |> put_flash(:info,"Welcome Back!")
      |> redirect(to: Routes.album_path(conn,:index))

    else
      conn
      |> put_flash(:error,"Email or password is Incorect!")
      |> redirect(to: Routes.auth_path(conn,:login))
    end
  end


  def logout(conn,params) do
    if conn.assigns.user do
      conn
      |> configure_session(drop: true)
      |> put_flash(:info,"You logged out!")
      |> redirect(to: Routes.album_path(conn,:index))

    end
  end







  def callback_google(%{assigns: %{ueberauth_auth: auth}} = conn ,_params) do
    IO.inspect(conn.assigns.ueberauth_auth.credentials.token)
    info = %{token: auth.credentials.token,email: auth.info.email}
    changeset = Auth.changeset(%Auth{}, info)
    signin(conn,changeset)
  end


  defp signin(conn , changeset) do
    case insert_or_update_user(changeset) do

    {:ok,user} ->
      conn
      |> put_flash(:info,"Welcome Back!")
      |> put_session(:user,user.id)
      |> redirect(to: Routes.album_path(conn,:index))

    {:error,_reason} ->
      conn
      |> put_flash(:error,"Sign in faild")
      |> redirect(to: Routes.album_path(conn,:index))
    end
  end

  defp insert_or_update_user(changeset) do
    case Repo.get_by(Auth,email: changeset.changes.email) do
      nil ->
        Repo.insert(changeset)
      user ->
        {:ok,user}
    end
  end

end
