defmodule PostCode.CodesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `PostCode.Codes` context.
  """

  @doc """
  Generate a code.
  """
  def code_fixture(attrs \\ %{}) do
    {:ok, code} =
      attrs
      |> Enum.into(%{
        country: "some country",
        country_code: "some country_code",
        eastings: "some eastings",
        latitude: 120.5,
        longitude: 120.5,
        northings: "some northings",
        postcode: "some postcode",
        region: "some region",
        town: "some town"
      })
      |> PostCode.Codes.create_code()

    code
  end
end
