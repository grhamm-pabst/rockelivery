defmodule Rockelivery.Orders.Create do
  import Ecto.Query

  alias Rockelivery.{Error, Item, Order, Repo}

  def call(params) do
    params
    |> fetch_items()
  end

  defp fetch_items(%{"items" => items_params}) do
    item_ids = Enum.map(items_params, fn item -> item["id"] end)

    query = from item in Item, where: item.id in ^item_ids

    Repo.all(query)
  end
end
