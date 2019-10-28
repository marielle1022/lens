defmodule LensWeb.PhotoTagView do
  use LensWeb, :view
  alias LensWeb.PhotoTagView

  def render("index.json", %{photo_tags: photo_tags}) do
    %{data: render_many(photo_tags, PhotoTagView, "photo_tag.json")}
  end

  def render("show.json", %{photo_tag: photo_tag}) do
    %{data: render_one(photo_tag, PhotoTagView, "photo_tag.json")}
  end

  def render("photo_tag.json", %{photo_tag: photo_tag}) do
    %{id: photo_tag.id}
  end
end
