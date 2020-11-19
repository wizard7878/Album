defmodule Instagram.Repo.Migrations.AddUserToPost do
  use Ecto.Migration

  def change do
    alter table (:article) do
      add :user_id,references(:users)
    end
  end
end
