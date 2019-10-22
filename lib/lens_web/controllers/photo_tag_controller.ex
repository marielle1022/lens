defmodule LensWeb.PhotoTagController do
  use LensWeb, :controller

  alias Lens.Tags
  alias Lens.Tags.PhotoTag

  action_fallback LensWeb.FallbackController

  def index(conn, _params) do
    photo_tags = Tags.list_photo_tags()
    render(conn, "index.json", photo_tags: photo_tags)
  end

  def create(conn, %{"photo_tag" => photo_tag_params}) do
    with {:ok, %PhotoTag{} = photo_tag} <- Tags.create_photo_tag(photo_tag_params) do
      photo_tag = Tags.get_photo_tag!(photo_tag.id)
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.photo_tag_path(conn, :show, photo_tag))
      |> render("show.json", photo_tag: photo_tag)
    end
  end

  def show(conn, %{"id" => id}) do
    photo_tag = Tags.get_photo_tag!(id)
    render(conn, "show.json", photo_tag: photo_tag)
  end

  def update(conn, %{"id" => id, "photo_tag" => photo_tag_params}) do
    photo_tag = Tags.get_photo_tag!(id)

    with {:ok, %PhotoTag{} = photo_tag} <- Tags.update_photo_tag(photo_tag, photo_tag_params) do
      render(conn, "show.json", photo_tag: photo_tag)
    end
  end

  def delete(conn, %{"id" => id}) do
    photo_tag = Tags.get_photo_tag!(id)

    with {:ok, %PhotoTag{}} <- Tags.delete_photo_tag(photo_tag) do
      send_resp(conn, :no_content, "")
    end
  end
end
