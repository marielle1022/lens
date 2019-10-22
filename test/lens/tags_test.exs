defmodule Lens.TagsTest do
  use Lens.DataCase

  alias Lens.Tags

  describe "tags" do
    alias Lens.Tags.Tag

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def tag_fixture(attrs \\ %{}) do
      {:ok, tag} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Tags.create_tag()

      tag
    end

    test "list_tags/0 returns all tags" do
      tag = tag_fixture()
      assert Tags.list_tags() == [tag]
    end

    test "get_tag!/1 returns the tag with given id" do
      tag = tag_fixture()
      assert Tags.get_tag!(tag.id) == tag
    end

    test "create_tag/1 with valid data creates a tag" do
      assert {:ok, %Tag{} = tag} = Tags.create_tag(@valid_attrs)
      assert tag.name == "some name"
    end

    test "create_tag/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Tags.create_tag(@invalid_attrs)
    end

    test "update_tag/2 with valid data updates the tag" do
      tag = tag_fixture()
      assert {:ok, %Tag{} = tag} = Tags.update_tag(tag, @update_attrs)
      assert tag.name == "some updated name"
    end

    test "update_tag/2 with invalid data returns error changeset" do
      tag = tag_fixture()
      assert {:error, %Ecto.Changeset{}} = Tags.update_tag(tag, @invalid_attrs)
      assert tag == Tags.get_tag!(tag.id)
    end

    test "delete_tag/1 deletes the tag" do
      tag = tag_fixture()
      assert {:ok, %Tag{}} = Tags.delete_tag(tag)
      assert_raise Ecto.NoResultsError, fn -> Tags.get_tag!(tag.id) end
    end

    test "change_tag/1 returns a tag changeset" do
      tag = tag_fixture()
      assert %Ecto.Changeset{} = Tags.change_tag(tag)
    end
  end

  describe "photo_tags" do
    alias Lens.Tags.PhotoTag

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def photo_tag_fixture(attrs \\ %{}) do
      {:ok, photo_tag} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Tags.create_photo_tag()

      photo_tag
    end

    test "list_photo_tags/0 returns all photo_tags" do
      photo_tag = photo_tag_fixture()
      assert Tags.list_photo_tags() == [photo_tag]
    end

    test "get_photo_tag!/1 returns the photo_tag with given id" do
      photo_tag = photo_tag_fixture()
      assert Tags.get_photo_tag!(photo_tag.id) == photo_tag
    end

    test "create_photo_tag/1 with valid data creates a photo_tag" do
      assert {:ok, %PhotoTag{} = photo_tag} = Tags.create_photo_tag(@valid_attrs)
    end

    test "create_photo_tag/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Tags.create_photo_tag(@invalid_attrs)
    end

    test "update_photo_tag/2 with valid data updates the photo_tag" do
      photo_tag = photo_tag_fixture()
      assert {:ok, %PhotoTag{} = photo_tag} = Tags.update_photo_tag(photo_tag, @update_attrs)
    end

    test "update_photo_tag/2 with invalid data returns error changeset" do
      photo_tag = photo_tag_fixture()
      assert {:error, %Ecto.Changeset{}} = Tags.update_photo_tag(photo_tag, @invalid_attrs)
      assert photo_tag == Tags.get_photo_tag!(photo_tag.id)
    end

    test "delete_photo_tag/1 deletes the photo_tag" do
      photo_tag = photo_tag_fixture()
      assert {:ok, %PhotoTag{}} = Tags.delete_photo_tag(photo_tag)
      assert_raise Ecto.NoResultsError, fn -> Tags.get_photo_tag!(photo_tag.id) end
    end

    test "change_photo_tag/1 returns a photo_tag changeset" do
      photo_tag = photo_tag_fixture()
      assert %Ecto.Changeset{} = Tags.change_photo_tag(photo_tag)
    end
  end
end
