defmodule Rockelivery.Users.Get do
  alias Rockelivery.{Repo, User}

  def by_id(id) do
    with {:ok, uuid} <- Ecto.UUID.cast(id),
         %User{} = user <- Repo.get(User, uuid) do
      {:ok, user}
    else
      :error -> {:error, %{status: :bad_request, result: "Invalid ID format"}}
      nil -> {:error, %{status: :not_found, result: "User not found"}}
    end
  end
end
