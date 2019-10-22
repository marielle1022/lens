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
    tag_name = if Ecto.assoc_loaded?(Map.get(photo_tag, :tag)) do
      photo_tag.tag.name
    else
      nil
    end

    html = render(LensWeb.TagView, "tag.html", pt: photo_tag)
    |> Phoenix.HTML.safe_to_string

    %{
      id: photo_tag.id,
      photo_id: photo_tag.photo_id,
      tag_id: photo_tag.tag_id,
      tag_name: tag_name,
      html: html,
    }
  end
end
