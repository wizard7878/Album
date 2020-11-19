defmodule Instagram.Repo.Migrations.ChangeAlbum do
  use Ecto.Migration

  def change do
    alter table (:article) do
      add :image, :string , default: ""

    end
  end
end
