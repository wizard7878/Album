defmodule Instagram.Auth do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Jason.Encoder, only: [:fname,:lname]}
  schema "users" do

   field :fname , :string
   field :lname , :string
   field :email, :string
   field :password , :string
   field :token , :string
   has_many :article , Instagram.Article
   has_many :comments , Instagram.Comment, on_delete: :delete_all
   timestamps()

  end


  def changeset(struct,params \\ %{}) do
    struct
    |> cast(params,[:fname,:lname,:email,:password,:token])
    |> validate_required([:email])

  end
end
