defmodule Rockelivery.Users.DeleteTest do
  use Rockelivery.DataCase

  import Rockelivery.Factory

  alias Rockelivery.Users.Delete

  describe "call/1" do
    test "when the user exists, deletes the user" do
      insert(:user)

      id = "5484b227-0f8f-4e84-ab01-41fd7c4c43dc"

      response = Delete.call(id)

      assert {:ok,
              %Rockelivery.User{
                address: "Rua 15",
                age: 27,
                cep: "12345678",
                cpf: "12345678900",
                email: "grhamm@email.com",
                id: "5484b227-0f8f-4e84-ab01-41fd7c4c43dc",
                inserted_at: _inserted_at,
                name: "Grhamm",
                password: nil,
                password_hash: nil,
                updated_at: _updated_at
              }} = response
    end

    test "when the user doesnt exists, returns an error" do
      id = "5484b227-0f8f-4e84-ab01-41fd7c4c43de"

      response = Delete.call(id)

      expected_response =
        {:error, %Rockelivery.Error{result: "User not found", status: :not_found}}

      assert expected_response == response
    end
  end
end
