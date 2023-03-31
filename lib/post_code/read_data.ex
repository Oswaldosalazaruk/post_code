defmodule PostCode.ReadData do
  alias PostCode.Codes

  def getdata do
    {_, file} = File.read("data/ukpostalcode.txt")

    [_head | row_file] = String.split(file, "\n")

    row_file
    |> Enum.map(&String.replace(&1, "\"", ""))
    |> Enum.filter(fn x -> x != "" end)
    |> Enum.map(&String.split(&1, ","))
    |> Enum.map(fn x ->
      [postcode, eastings, northings, latitude, longitude, town, region, country_code, country] =
        x

      latitude = String.trim(latitude) |> String.to_float()
      longitude = String.trim(longitude) |> String.to_float()

      %{
        country: country,
        country_code: country_code,
        eastings: eastings,
        latitude: latitude,
        longitude: longitude,
        northings: northings,
        postcode: postcode,
        region: region,
        town: town
      }
    end)
    |> Enum.each(&Codes.create_code(&1))

    # |> Enum.into(%{})
  end

  def geolocation(postcode) do
    mycode = Codes.get_post(postcode)
    latitude = Map.get(mycode, :latitude)
    longitude = Map.get(mycode, :longitude)
    {latitude, longitude}
  end
end
