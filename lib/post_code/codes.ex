defmodule PostCode.Codes do
  @moduledoc """
  The Codes context.
  """
  import Ecto.Query, only: [from: 2]
  import Ecto.Query, warn: false
  alias PostCode.Repo

  alias PostCode.Codes.Code

  @doc """
  Returns the list of codes.

  ## Examples

      iex> list_codes()
      [%Code{}, ...]

  """
  def list_codes do
    Repo.all(Code)
  end

  @doc """
  Gets a single code.

  Raises `Ecto.NoResultsError` if the Code does not exist.

  ## Examples

      iex> get_code!(123)
      %Code{}

      iex> get_code!(456)
      ** (Ecto.NoResultsError)

  """
  def get_code!(id), do: Repo.get!(Code, id)

  @doc """
  Creates a code.

  ## Examples

      iex> create_code(%{field: value})
      {:ok, %Code{}}

      iex> create_code(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_code(attrs \\ %{}) do
    %Code{}
    |> Code.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a code.

  ## Examples

      iex> update_code(code, %{field: new_value})
      {:ok, %Code{}}

      iex> update_code(code, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_code(%Code{} = code, attrs) do
    code
    |> Code.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a code.

  ## Examples

      iex> delete_code(code)
      {:ok, %Code{}}

      iex> delete_code(code)
      {:error, %Ecto.Changeset{}}

  """
  def delete_code(%Code{} = code) do
    Repo.delete(code)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking code changes.

  ## Examples

      iex> change_code(code)
      %Ecto.Changeset{data: %Code{}}

  """
  def change_code(%Code{} = code, attrs \\ %{}) do
    Code.changeset(code, attrs)
  end

  def get_all(query) do
    Repo.all(query)
  end

  def get_post(postcode) do
    Repo.get_by!(Code, postcode: postcode)
  end

  def search(searchtext) do
    query =
      from u in Code,
        where: fragment(
          "region @@ websearch_to_tsquery(?)",
          ^searchtext
        )
    get_all(query)
  end
end
