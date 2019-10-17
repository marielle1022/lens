defmodule Lens.Photos.Photo do
  use Ecto.Schema
  import Ecto.Changeset

  schema "photos" do
    field :desc, :string
    field :filename, :string
    field :uuid, :string

    belongs_to :user, Lens.Users.User

    field :photo_upload, :any, virtual: true

    timestamps()
  end

  @doc false
  def changeset(photo, attrs) do
    photo
    |> cast(attrs, [:desc, :user_id, :photo_upload])
    |> validate_required([:desc, :user_id, :photo_upload])
    |> generate_uuid()
    |> save_photo_upload()
  end

  def make_uuid() do
    :crypto.strong_rand_bytes(16)
    |> Base.encode16
  end

  def generate_uuid(cset) do
    if get_field(cset, :uuid) do
      cset
    else
      put_change(cset, :uuid, make_uuid())
    end
  end

  def save_photo_upload(cset) do
    up = get_field(cset, :photo_upload)
    uuid = get_field(cset, :uuid)
    if up do
      dir = photo_upload_dir(uuid)
      File.mkdir_p!(dir)
      File.copy!(up.path, Path.join(dir, up.filename))
      put_change(cset, :filename, up.filename)
    else
      cset
    end
  end

  def photo_upload_dir(uuid) do
    base = Path.expand("~/.local/data/lens/photos/")
    Path.join(base, uuid)
  end
end
