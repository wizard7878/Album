defmodule Instagram.Repo.Migrations.Albums do
  use Ecto.Migration

  def change do
    create table (:article) do
      add :title,:string
      add :body, :text
      add :image, :string

      timestamps()
    end
  end
end
