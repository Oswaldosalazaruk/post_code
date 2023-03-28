defmodule PostCodeWeb.CodeLive.Show do
  use PostCodeWeb, :live_view

  alias PostCode.Codes

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:code, Codes.get_code!(id))}
  end

  defp page_title(:show), do: "Show Code"
  defp page_title(:edit), do: "Edit Code"
end
