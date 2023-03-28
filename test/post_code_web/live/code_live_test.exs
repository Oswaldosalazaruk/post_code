defmodule PostCodeWeb.CodeLiveTest do
  use PostCodeWeb.ConnCase

  import Phoenix.LiveViewTest
  import PostCode.CodesFixtures

  @create_attrs %{country: "some country", country_code: "some country_code", eastings: "some eastings", latitude: 120.5, longitude: 120.5, northings: "some northings", postcode: "some postcode", region: "some region", town: "some town"}
  @update_attrs %{country: "some updated country", country_code: "some updated country_code", eastings: "some updated eastings", latitude: 456.7, longitude: 456.7, northings: "some updated northings", postcode: "some updated postcode", region: "some updated region", town: "some updated town"}
  @invalid_attrs %{country: nil, country_code: nil, eastings: nil, latitude: nil, longitude: nil, northings: nil, postcode: nil, region: nil, town: nil}

  defp create_code(_) do
    code = code_fixture()
    %{code: code}
  end

  describe "Index" do
    setup [:create_code]

    test "lists all codes", %{conn: conn, code: code} do
      {:ok, _index_live, html} = live(conn, ~p"/codes")

      assert html =~ "Listing Codes"
      assert html =~ code.country
    end

    test "saves new code", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/codes")

      assert index_live |> element("a", "New Code") |> render_click() =~
               "New Code"

      assert_patch(index_live, ~p"/codes/new")

      assert index_live
             |> form("#code-form", code: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#code-form", code: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/codes")

      html = render(index_live)
      assert html =~ "Code created successfully"
      assert html =~ "some country"
    end

    test "updates code in listing", %{conn: conn, code: code} do
      {:ok, index_live, _html} = live(conn, ~p"/codes")

      assert index_live |> element("#codes-#{code.id} a", "Edit") |> render_click() =~
               "Edit Code"

      assert_patch(index_live, ~p"/codes/#{code}/edit")

      assert index_live
             |> form("#code-form", code: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#code-form", code: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/codes")

      html = render(index_live)
      assert html =~ "Code updated successfully"
      assert html =~ "some updated country"
    end

    test "deletes code in listing", %{conn: conn, code: code} do
      {:ok, index_live, _html} = live(conn, ~p"/codes")

      assert index_live |> element("#codes-#{code.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#codes-#{code.id}")
    end
  end

  describe "Show" do
    setup [:create_code]

    test "displays code", %{conn: conn, code: code} do
      {:ok, _show_live, html} = live(conn, ~p"/codes/#{code}")

      assert html =~ "Show Code"
      assert html =~ code.country
    end

    test "updates code within modal", %{conn: conn, code: code} do
      {:ok, show_live, _html} = live(conn, ~p"/codes/#{code}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Code"

      assert_patch(show_live, ~p"/codes/#{code}/show/edit")

      assert show_live
             |> form("#code-form", code: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#code-form", code: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/codes/#{code}")

      html = render(show_live)
      assert html =~ "Code updated successfully"
      assert html =~ "some updated country"
    end
  end
end
