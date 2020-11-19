defmodule Instagram.Repo.Migrations.AddComments do
  use Ecto.Migration

  def change do
    create table(:comments) do
      add :content, :string
      add :auth_id , references(:users)
      add :album_id ,references(:article)

      timestamps()
    end
  end
end
