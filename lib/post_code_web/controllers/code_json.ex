defmodule PostCodeWeb.CodeJSON do
  alias PostCode.Codes.Code

  @doc """
  Renders a list of codes.
  """
  def index(%{codes: codes}) do
    %{data: for(code <- codes, do: data(code))}
  end

  @doc """
  Renders a single code.
  """
  def show(%{code: code}) do
    %{data: data(code)}
  end

  defp data(%Code{} = code) do
    %{
      id: code.id,
      postcode: code.postcode,
      eastings: code.eastings,
      northings: code.northings,
      latitude: code.latitude,
      longitude: code.longitude,
      town: code.town,
      region: code.region,
      country_code: code.country_code,
      country: code.country
    }
  end
end
