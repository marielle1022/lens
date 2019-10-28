defmodule Lens.Photos.Photo do
  use Ecto.Schema
  import Ecto.Changeset

  schema "photos" do
    field :filename, :string
    field :desc, :string
    field :data, :string  # lol, base64 photo

    belongs_to :user, Lens.Users.User
    has_many :photo_tags, Lens.Tags.PhotoTag
    has_many :tags, through: [:photo_tags, :tag]

    timestamps()
  end

  @doc false
  def changeset(photo, attrs) do
    photo
    |> cast(attrs, [:filename, :desc, :data, :user_id])
    |> validate_required([:filename, :desc, :data, :user_id])
  end
end
