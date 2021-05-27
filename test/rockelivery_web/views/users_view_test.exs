defmodule RockeliveryWeb.UsersViewTest do
  use RockeliveryWeb.ConnCase, async: true

  import Phoenix.View
  import Rockelivery.Factory

  alias RockeliveryWeb.UsersView

  test "renders create.json" do
    user = build(:user)
    token = "1234"
    response = render(UsersView, "create.json", token: token, user: user)

    assert %{
             message: "User created!",
             token: _token,
             user: %Rockelivery.User{
               address: "Rua 15",
               age: 27,
               cep: "12345678",
               cpf: "12345678900",
               email: "grhamm@email.com",
               id: "5484b227-0f8f-4e84-ab01-41fd7c4c43dc",
               inserted_at: nil,
               name: "Grhamm",
               password: "123456",
               password_hash: nil,
               updated_at: nil
             }
           } = response
  end
end
