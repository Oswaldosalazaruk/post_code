defmodule PostCode.Codes.Code do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "codes" do
    field :country, :string
    field :country_code, :string
    field :eastings, :string
    field :latitude, :float
    field :longitude, :float
    field :northings, :string
    field :postcode, :string
    field :region, :string
    field :town, :string

    timestamps()
  end

  @doc false
  def changeset(code, attrs) do
    code
    |> cast(attrs, [
      :postcode,
      :eastings,
      :northings,
      :latitude,
      :longitude,
      :town,
      :region,
      :country_code,
      :country
    ])
    |> validate_required([
      :postcode,
      :latitude,
      :longitude
    ])
    |> unique_constraint(:postcode)
  end
end
