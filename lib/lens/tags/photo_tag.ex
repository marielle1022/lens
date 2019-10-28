defmodule Lens.Tags.PhotoTag do
  use Ecto.Schema
  import Ecto.Changeset

  schema "photo_tags" do
    belongs_to :photo, Lens.Photos.Photo
    belongs_to :tag, Lens.Tags.Tag

    timestamps()
  end

  @doc false
  def changeset(photo_tag, attrs) do
    photo_tag
    |> cast(attrs, [:photo_id, :tag_id])
    |> validate_required([:photo_id, :tag_id])
  end
end
