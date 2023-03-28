defmodule PostCode.Repo.Migrations.CreateCodes do
  use Ecto.Migration

  def change do
    create table(:codes, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :postcode, :string
      add :eastings, :string
      add :northings, :string
      add :latitude, :float
      add :longitude, :float
      add :town, :string
      add :region, :string
      add :country_code, :string
      add :country, :string

      timestamps()
    end
  end
end
