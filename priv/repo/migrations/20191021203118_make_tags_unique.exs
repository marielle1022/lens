defmodule Lens.Repo.Migrations.MakeTagsUnique do
  use Ecto.Migration

  def change do
    create unique_index(:tags, [:name])
    create unique_index(:photo_tags, [:photo_id, :tag_id])
  end
end
