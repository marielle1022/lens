defmodule LensWeb.PhotoTagControllerTest do
  use LensWeb.ConnCase

  alias Lens.Tags
  alias Lens.Tags.PhotoTag

  @create_attrs %{

  }
  @update_attrs %{

  }
  @invalid_attrs %{}

  def fixture(:photo_tag) do
    {:ok, photo_tag} = Tags.create_photo_tag(@create_attrs)
    photo_tag
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all photo_tags", %{conn: conn} do
      conn = get(conn, Routes.photo_tag_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create photo_tag" do
    test "renders photo_tag when data is valid", %{conn: conn} do
      conn = post(conn, Routes.photo_tag_path(conn, :create), photo_tag: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.photo_tag_path(conn, :show, id))

      assert %{
               "id" => id
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.photo_tag_path(conn, :create), photo_tag: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update photo_tag" do
    setup [:create_photo_tag]

    test "renders photo_tag when data is valid", %{conn: conn, photo_tag: %PhotoTag{id: id} = photo_tag} do
      conn = put(conn, Routes.photo_tag_path(conn, :update, photo_tag), photo_tag: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.photo_tag_path(conn, :show, id))

      assert %{
               "id" => id
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, photo_tag: photo_tag} do
      conn = put(conn, Routes.photo_tag_path(conn, :update, photo_tag), photo_tag: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete photo_tag" do
    setup [:create_photo_tag]

    test "deletes chosen photo_tag", %{conn: conn, photo_tag: photo_tag} do
      conn = delete(conn, Routes.photo_tag_path(conn, :delete, photo_tag))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.photo_tag_path(conn, :show, photo_tag))
      end
    end
  end

  defp create_photo_tag(_) do
    photo_tag = fixture(:photo_tag)
    {:ok, photo_tag: photo_tag}
  end
end
