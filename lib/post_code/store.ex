defmodule PostalCode.Store do
  use GenServer
  alias PostalCode.ReadData

  def start_link do
    GenServer.start_link(__MODULE__, %{}, name: :postal_code_store)
  end

  def init(_) do
    {:ok, ReadData.getdata()}
  end

  def get_geolocation(postal_code) do
    GenServer.call(:postal_code_store, {:get_geolocation, postal_code})
  end

  def handle_call({:get_geolocation, postal_code}, _from, geolocation_data) do
    geolocation = Map.get(geolocation_data, postal_code)
    {:reply, geolocation, geolocation_data}
  end
end
