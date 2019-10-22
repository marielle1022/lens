defmodule Lens.Repo.Migrations.CreatePhotoTags do
  use Ecto.Migration

  def change do
    create table(:photo_tags) do
      add :photo_id, references(:photos, on_delete: :delete_all), null: false
      add :tag_id, references(:tags, on_delete: :delete_all), null: false

      timestamps()
    end

    create index(:photo_tags, [:photo_id])
    create index(:photo_tags, [:tag_id])
  end
end
