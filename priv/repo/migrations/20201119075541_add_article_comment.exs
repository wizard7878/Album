defmodule Instagram.Repo.Migrations.AddArticleComment do
  use Ecto.Migration

  def change do
    alter table(:comments) do
      add :article_id ,references(:article)


    end
  end
end
