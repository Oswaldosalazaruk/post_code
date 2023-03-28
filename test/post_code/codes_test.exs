defmodule PostCode.CodesTest do
  use PostCode.DataCase

  alias PostCode.Codes

  describe "codes" do
    alias PostCode.Codes.Code

    import PostCode.CodesFixtures

    @invalid_attrs %{country: nil, country_code: nil, eastings: nil, latitude: nil, longitude: nil, northings: nil, postcode: nil, region: nil, town: nil}

    test "list_codes/0 returns all codes" do
      code = code_fixture()
      assert Codes.list_codes() == [code]
    end

    test "get_code!/1 returns the code with given id" do
      code = code_fixture()
      assert Codes.get_code!(code.id) == code
    end

    test "create_code/1 with valid data creates a code" do
      valid_attrs = %{country: "some country", country_code: "some country_code", eastings: "some eastings", latitude: 120.5, longitude: 120.5, northings: "some northings", postcode: "some postcode", region: "some region", town: "some town"}

      assert {:ok, %Code{} = code} = Codes.create_code(valid_attrs)
      assert code.country == "some country"
      assert code.country_code == "some country_code"
      assert code.eastings == "some eastings"
      assert code.latitude == 120.5
      assert code.longitude == 120.5
      assert code.northings == "some northings"
      assert code.postcode == "some postcode"
      assert code.region == "some region"
      assert code.town == "some town"
    end

    test "create_code/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Codes.create_code(@invalid_attrs)
    end

    test "update_code/2 with valid data updates the code" do
      code = code_fixture()
      update_attrs = %{country: "some updated country", country_code: "some updated country_code", eastings: "some updated eastings", latitude: 456.7, longitude: 456.7, northings: "some updated northings", postcode: "some updated postcode", region: "some updated region", town: "some updated town"}

      assert {:ok, %Code{} = code} = Codes.update_code(code, update_attrs)
      assert code.country == "some updated country"
      assert code.country_code == "some updated country_code"
      assert code.eastings == "some updated eastings"
      assert code.latitude == 456.7
      assert code.longitude == 456.7
      assert code.northings == "some updated northings"
      assert code.postcode == "some updated postcode"
      assert code.region == "some updated region"
      assert code.town == "some updated town"
    end

    test "update_code/2 with invalid data returns error changeset" do
      code = code_fixture()
      assert {:error, %Ecto.Changeset{}} = Codes.update_code(code, @invalid_attrs)
      assert code == Codes.get_code!(code.id)
    end

    test "delete_code/1 deletes the code" do
      code = code_fixture()
      assert {:ok, %Code{}} = Codes.delete_code(code)
      assert_raise Ecto.NoResultsError, fn -> Codes.get_code!(code.id) end
    end

    test "change_code/1 returns a code changeset" do
      code = code_fixture()
      assert %Ecto.Changeset{} = Codes.change_code(code)
    end
  end
end
