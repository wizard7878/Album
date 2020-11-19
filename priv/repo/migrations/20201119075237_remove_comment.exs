defmodule Instagram.Repo.Migrations.RemoveComment do
  use Ecto.Migration

  def change do
    alter table(:comments) do
      remove :album_id ,references(:article)

     
    end
  end
end
