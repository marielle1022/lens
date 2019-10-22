defmodule Lens.Tags do
  @moduledoc """
  The Tags context.
  """

  import Ecto.Query, warn: false
  alias Lens.Repo

  alias Lens.Tags.Tag

  @doc """
  Returns the list of tags.

  ## Examples

      iex> list_tags()
      [%Tag{}, ...]

  """
  def list_tags do
    Repo.all(Tag)
  end

  @doc """
  Gets a single tag.

  Raises `Ecto.NoResultsError` if the Tag does not exist.

  ## Examples

      iex> get_tag!(123)
      %Tag{}

      iex> get_tag!(456)
      ** (Ecto.NoResultsError)

  """
  def get_tag!(id), do: Repo.get!(Tag, id)

  @doc """
  Creates a tag.

  ## Examples

      iex> create_tag(%{field: value})
      {:ok, %Tag{}}

      iex> create_tag(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_tag(attrs \\ %{}) do
    {:ok, tag} = %Tag{}
    |> Tag.changeset(attrs)
    |> Repo.insert(
      on_conflict: :nothing,
      conflict_target: :name
    )
    tag = Repo.get_by!(Tag, name: tag.name)
    {:ok, tag}
  end

  @doc """
  Updates a tag.

  ## Examples

      iex> update_tag(tag, %{field: new_value})
      {:ok, %Tag{}}

      iex> update_tag(tag, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_tag(%Tag{} = tag, attrs) do
    tag
    |> Tag.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Tag.

  ## Examples

      iex> delete_tag(tag)
      {:ok, %Tag{}}

      iex> delete_tag(tag)
      {:error, %Ecto.Changeset{}}

  """
  def delete_tag(%Tag{} = tag) do
    Repo.delete(tag)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking tag changes.

  ## Examples

      iex> change_tag(tag)
      %Ecto.Changeset{source: %Tag{}}

  """
  def change_tag(%Tag{} = tag) do
    Tag.changeset(tag, %{})
  end

  alias Lens.Tags.PhotoTag

  @doc """
  Returns the list of photo_tags.

  ## Examples

      iex> list_photo_tags()
      [%PhotoTag{}, ...]

  """
  def list_photo_tags do
    Repo.all(PhotoTag)
  end

  @doc """
  Gets a single photo_tag.

  Raises `Ecto.NoResultsError` if the Photo tag does not exist.

  ## Examples

      iex> get_photo_tag!(123)
      %PhotoTag{}

      iex> get_photo_tag!(456)
      ** (Ecto.NoResultsError)

  """
  def get_photo_tag!(id) do
    Repo.get!(PhotoTag, id)
    |> Repo.preload(:tag)
  end

  @doc """
  Creates a photo_tag.

  ## Examples

      iex> create_photo_tag(%{field: value})
      {:ok, %PhotoTag{}}

      iex> create_photo_tag(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_photo_tag(), do: create_photo_tag(%{})

  def create_photo_tag(attrs = %{"tag_name" => tag_name}) do
    {:ok, tag} = create_tag(%{"name" => tag_name})
    attrs
    |> Map.delete("tag_name")
    |> Map.put("tag_id", tag.id)
    |> create_photo_tag
  end

  def create_photo_tag(attrs) do
    {:ok, pt} = %PhotoTag{}
    |> PhotoTag.changeset(attrs)
    |> Repo.insert(on_conflict: :nothing)
    pt = Repo.get_by!(PhotoTag, tag_id: attrs["tag_id"], photo_id: attrs["photo_id"])
    {:ok, pt}
  end

  @doc """
  Updates a photo_tag.

  ## Examples

      iex> update_photo_tag(photo_tag, %{field: new_value})
      {:ok, %PhotoTag{}}

      iex> update_photo_tag(photo_tag, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_photo_tag(%PhotoTag{} = photo_tag, attrs) do
    photo_tag
    |> PhotoTag.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a PhotoTag.

  ## Examples

      iex> delete_photo_tag(photo_tag)
      {:ok, %PhotoTag{}}

      iex> delete_photo_tag(photo_tag)
      {:error, %Ecto.Changeset{}}

  """
  def delete_photo_tag(%PhotoTag{} = photo_tag) do
    Repo.delete(photo_tag)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking photo_tag changes.

  ## Examples

      iex> change_photo_tag(photo_tag)
      %Ecto.Changeset{source: %PhotoTag{}}

  """
  def change_photo_tag(%PhotoTag{} = photo_tag) do
    PhotoTag.changeset(photo_tag, %{})
  end
end
