defmodule Instagram.Repo.Migrations.ChangeAlbum do
  use Ecto.Migration

  def change do
    alter table (:article) do
      remove :image, :string

    end
  end
end
