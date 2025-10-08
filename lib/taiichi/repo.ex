defmodule Taiichi.Repo do
  use Ecto.Repo,
    otp_app: :taiichi,
    adapter: Ecto.Adapters.Postgres
end
