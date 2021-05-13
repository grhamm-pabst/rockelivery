defmodule Rockelivery.Orders.Create do
  import Ecto.Query

  alias Ecto.UUID

  alias Rockelivery.{Error, Item, Order, Repo}

  alias Rockelivery.Orders.ValidateAndMultiplyItems

  def call(params) do
    params
    |> fetch_items()
    |> handle_items(params)
  end

  defp fetch_items(%{"items" => items_params}) do
    items_ids = Enum.map(items_params, fn item -> item["id"] end)

    with false <- id_validations(items_ids) do
      query = from item in Item, where: item.id in ^items_ids

      query
      |> Repo.all()
      |> ValidateAndMultiplyItems.call(items_ids, items_params)
    end
  end

  defp id_validations(items_id) do
    case Enum.any?(items_id, fn id -> UUID.cast(id) == :error end) do
      true -> {:error, "Invalid ids!"}
      false -> false
    end
  end

  defp handle_items({:error, result}, _params), do: {:error, Error.build(:bad_request, result)}

  defp handle_items({:ok, items}, params) do
    params
    |> Order.changeset(items)
    |> Repo.insert()
    |> handle_insert()
  end

  defp handle_insert({:ok, %Order{}} = result), do: result

  defp handle_insert({:error, result}), do: {:error, Error.build(:bad_request, result)}
end
