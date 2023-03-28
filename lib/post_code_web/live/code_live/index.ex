defmodule PostCodeWeb.CodeLive.Index do
  use PostCodeWeb, :live_view

  alias PostCode.Codes
  alias PostCode.Codes.Code

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :codes, Codes.list_codes())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Code")
    |> assign(:code, Codes.get_code!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Code")
    |> assign(:code, %Code{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Codes")
    |> assign(:code, nil)
  end

  @impl true
  def handle_info({PostCodeWeb.CodeLive.FormComponent, {:saved, code}}, socket) do
    {:noreply, stream_insert(socket, :codes, code)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    code = Codes.get_code!(id)
    {:ok, _} = Codes.delete_code(code)

    {:noreply, stream_delete(socket, :codes, code)}
  end
end
