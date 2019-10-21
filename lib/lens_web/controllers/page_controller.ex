defmodule LensWeb.PageController do
  use LensWeb, :controller

  def index(conn, _params) do
    photos = Lens.Photos.recent_photos(9)
    render(conn, "index.html", photos: photos)
  end
end
