defmodule Instagram.Article do
  use Ecto.Schema
  import Ecto.Changeset

  schema "article" do
    field :title,:string
    field :body, :string
    field :image, :string , default: ""
    belongs_to :auth , Instagram.Auth
    has_many :comments , Instagram.Comment,on_delete: :delete_all
    timestamps()
  end

  def changeset(struct,params \\ %{}) do
    struct
    |> cast(params,[:title,:body,:image])
    |> validate_required(:title)
  end
end
