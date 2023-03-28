defmodule PostCodeWeb.CodeLive.FormComponent do
  use PostCodeWeb, :live_component

  alias PostCode.Codes

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage code records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="code-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:postcode]} type="text" label="Postcode" />
        <.input field={@form[:eastings]} type="text" label="Eastings" />
        <.input field={@form[:northings]} type="text" label="Northings" />
        <.input field={@form[:latitude]} type="number" label="Latitude" step="any" />
        <.input field={@form[:longitude]} type="number" label="Longitude" step="any" />
        <.input field={@form[:town]} type="text" label="Town" />
        <.input field={@form[:region]} type="text" label="Region" />
        <.input field={@form[:country_code]} type="text" label="Country code" />
        <.input field={@form[:country]} type="text" label="Country" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Code</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{code: code} = assigns, socket) do
    changeset = Codes.change_code(code)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"code" => code_params}, socket) do
    changeset =
      socket.assigns.code
      |> Codes.change_code(code_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"code" => code_params}, socket) do
    save_code(socket, socket.assigns.action, code_params)
  end

  defp save_code(socket, :edit, code_params) do
    case Codes.update_code(socket.assigns.code, code_params) do
      {:ok, code} ->
        notify_parent({:saved, code})

        {:noreply,
         socket
         |> put_flash(:info, "Code updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_code(socket, :new, code_params) do
    case Codes.create_code(code_params) do
      {:ok, code} ->
        notify_parent({:saved, code})

        {:noreply,
         socket
         |> put_flash(:info, "Code created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
