defmodule Instagram.Repo.Migrations.UserAuth do
  use Ecto.Migration

  def change do
    create table (:users) do
      add :fname , :string
      add :lname , :string
      add :email, :string
      add :password , :string

      timestamps()
    end
  end
end
