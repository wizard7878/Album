defmodule Instagram.Repo.Migrations.AddCommentsToArticle do
  use Ecto.Migration

  def change do
    alter table (:article) do
      add :comments_id,references(:comments)
    end
  end
end
