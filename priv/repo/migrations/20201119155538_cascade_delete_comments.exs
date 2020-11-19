defmodule Instagram.Repo.Migrations.CascadeDeleteComments do
  use Ecto.Migration

  def change do
    alter table (:article) do
      add :comments_id,references(:comments), on_delete: :delete_all
    end
  end
end
