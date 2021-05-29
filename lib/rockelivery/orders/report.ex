defmodule Rockelivery.Orders.Report do
  import Ecto.Query

  alias Rockelivery.{Item, Order, Orders.TotalPrice, Repo}

  @default_block_size 500

  def create(file_name \\ "report.csv") do
    query = from order in Order, order_by: order.user_id

    {:ok, orders} =
      Repo.transaction(
        fn ->
          query
          |> Repo.stream(max_rows: @default_block_size)
          |> Stream.chunk_every(500)
          |> Stream.flat_map(fn chunk -> Repo.preload(chunk, :items) end)
          |> Enum.map(&parse_line/1)
        end,
        timeout: :infinity
      )

    File.write(file_name, orders)
  end

  defp parse_line(%Order{user_id: user_id, payment_method: payment, items: items}) do
    total_price = TotalPrice.calculate(items)

    items_string = Enum.map(items, fn item -> item_string(item) end)

    "#{user_id},#{payment},#{items_string}#{total_price}\n"
  end

  defp item_string(%Item{category: category, description: description, price: price}) do
    "#{category},#{description},#{price},"
  end
end
