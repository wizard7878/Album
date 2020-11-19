defmodule Instagram.Comment do
  use Ecto.Schema
  import Ecto.Changeset


  @derive {Jason.Encoder, only: [:content,:auth]}

  schema "comments" do
    field :content ,:string
    belongs_to :auth , Instagram.Auth
    belongs_to :article , Instagram.Article

    timestamps()
  end


  def changeset(struct , params \\ %{}) do
    struct
    |> cast(params,[:content])
    |> validate_required([:content])
  end
end
