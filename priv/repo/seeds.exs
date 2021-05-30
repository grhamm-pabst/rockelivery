# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Rockelivery.Repo.insert!(%Rockelivery.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Rockelivery.{Item, Order, Repo, User}

user = %User{
  age: 27,
  address: "Rua banana",
  cep: "41250400",
  cpf: "12345678900",
  email: "grhammpabst@gmail.com",
  password: "123456",
  name: "Grhamm"
}

%User{id: user_id} = Repo.insert!(user)

item_1 = %Item{
  category: :food,
  description: "Pastel de frango",
  price: Decimal.new("10.40"),
  photo: "priv/photos/pastel.png"
}

item_2 = %Item{
  category: :food,
  description: "Pastel de carne",
  price: Decimal.new("10.40"),
  photo: "priv/photos/pastel.png"
}

Repo.insert!(item_1)
Repo.insert!(item_2)

order = %Order{
  user_id: user_id,
  items: [item_1, item_2],
  address: "Rua tal",
  comments: "sem carne",
  payment_method: :credit_card
}

Repo.insert!(order)
