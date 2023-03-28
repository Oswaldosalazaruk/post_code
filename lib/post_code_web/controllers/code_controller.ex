defmodule PostCodeWeb.CodeController do
  use PostCodeWeb, :controller

  alias PostCode.Codes
  alias PostCode.Codes.Code

  action_fallback PostCodeWeb.FallbackController

  def index(conn, _params) do
    codes = Codes.list_codes()
    render(conn, :index, codes: codes)
  end

  def create(conn, %{"code" => code_params}) do
    with {:ok, %Code{} = code} <- Codes.create_code(code_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/codes/#{code}")
      |> render(:show, code: code)
    end
  end

  def show(conn, %{"id" => id}) do
    code = Codes.get_code!(id)
    render(conn, :show, code: code)
  end

  def update(conn, %{"id" => id, "code" => code_params}) do
    code = Codes.get_code!(id)

    with {:ok, %Code{} = code} <- Codes.update_code(code, code_params) do
      render(conn, :show, code: code)
    end
  end

  def delete(conn, %{"id" => id}) do
    code = Codes.get_code!(id)

    with {:ok, %Code{}} <- Codes.delete_code(code) do
      send_resp(conn, :no_content, "")
    end
  end
end
