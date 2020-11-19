defmodule Instagram.Repo.Migrations.RemoveCommentsToArticle do
  use Ecto.Migration

  def change do
    alter table (:article) do
      remove :comments_id,references(:comments)
    end
  end
end
