defmodule PostCodeWeb.CodeControllerTest do
  use PostCodeWeb.ConnCase

  import PostCode.CodesFixtures

  alias PostCode.Codes.Code

  @create_attrs %{
    country: "some country",
    country_code: "some country_code",
    eastings: "some eastings",
    latitude: 120.5,
    longitude: 120.5,
    northings: "some northings",
    postcode: "some postcode",
    region: "some region",
    town: "some town"
  }
  @update_attrs %{
    country: "some updated country",
    country_code: "some updated country_code",
    eastings: "some updated eastings",
    latitude: 456.7,
    longitude: 456.7,
    northings: "some updated northings",
    postcode: "some updated postcode",
    region: "some updated region",
    town: "some updated town"
  }
  @invalid_attrs %{country: nil, country_code: nil, eastings: nil, latitude: nil, longitude: nil, northings: nil, postcode: nil, region: nil, town: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all codes", %{conn: conn} do
      conn = get(conn, ~p"/api/codes")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create code" do
    test "renders code when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/codes", code: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/codes/#{id}")

      assert %{
               "id" => ^id,
               "country" => "some country",
               "country_code" => "some country_code",
               "eastings" => "some eastings",
               "latitude" => 120.5,
               "longitude" => 120.5,
               "northings" => "some northings",
               "postcode" => "some postcode",
               "region" => "some region",
               "town" => "some town"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/codes", code: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update code" do
    setup [:create_code]

    test "renders code when data is valid", %{conn: conn, code: %Code{id: id} = code} do
      conn = put(conn, ~p"/api/codes/#{code}", code: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/codes/#{id}")

      assert %{
               "id" => ^id,
               "country" => "some updated country",
               "country_code" => "some updated country_code",
               "eastings" => "some updated eastings",
               "latitude" => 456.7,
               "longitude" => 456.7,
               "northings" => "some updated northings",
               "postcode" => "some updated postcode",
               "region" => "some updated region",
               "town" => "some updated town"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, code: code} do
      conn = put(conn, ~p"/api/codes/#{code}", code: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete code" do
    setup [:create_code]

    test "deletes chosen code", %{conn: conn, code: code} do
      conn = delete(conn, ~p"/api/codes/#{code}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/codes/#{code}")
      end
    end
  end

  defp create_code(_) do
    code = code_fixture()
    %{code: code}
  end
end
