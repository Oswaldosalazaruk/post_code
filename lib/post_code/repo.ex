defmodule PostCode.Repo do
  use Ecto.Repo,
    otp_app: :post_code,
    adapter: Ecto.Adapters.Postgres
end
