defmodule PostCodeWeb.CodeLive.Tabla do
  use PostCodeWeb, :live_view

  alias PostCode.Codes

  @impl true
  def mount(_params, _session, socket) do
    socket = assign(socket, searchtext: "liverpool")
    {:ok, assign(socket, codes: Codes.search("liverpool"))}
  end

  @impl true
  def handle_event("update", params, socket) do
    searchtext = Map.get(params, "search")
    
    {
      :noreply,
      socket
      |> assign(:params, params)
      |> assign(:searchtext, searchtext)
      |> assign(:codes, Codes.search(searchtext))

    }
  end
end
