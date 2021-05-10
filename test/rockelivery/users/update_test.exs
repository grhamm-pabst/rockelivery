defmodule Rockelivery.Users.UpdateTest do
  use Rockelivery.DataCase

  import Rockelivery.Factory

  alias Ecto.Changeset
  alias Rockelivery.Users.Update

  describe "call/1" do
    setup do
      insert(:user)

      :ok
    end

    test "when all params are valid, returns the updated user" do
      id = "5484b227-0f8f-4e84-ab01-41fd7c4c43dc"

      params = %{"id" => id, "name" => "Geao das neves"}

      response = Update.call(params)

      assert {:ok,
              %Rockelivery.User{
                address: "Rua 15",
                age: 27,
                cep: "12345678",
                cpf: "12345678900",
                email: "grhamm@email.com",
                id: "5484b227-0f8f-4e84-ab01-41fd7c4c43dc",
                inserted_at: _inserted_at,
                name: "Geao das neves",
                password: nil,
                password_hash: nil,
                updated_at: _updated_at
              }} = response
    end

    test "when the user doesnt exist, returns an error" do
      id = "5484b227-0f8f-4e84-ab01-41fd7c4c43de"

      params = %{"id" => id, "name" => "Geao das neves"}

      response = Update.call(params)

      expected_response =
        {:error, %Rockelivery.Error{result: "User not found", status: :not_found}}

      assert expected_response == response
    end

    test "when there are invalid params, returns error" do
      id = "5484b227-0f8f-4e84-ab01-41fd7c4c43dc"

      params = %{"id" => id, "cep" => "1234567"}

      response = Update.call(params)

      expected_response = %{cep: ["should be 8 character(s)"]}

      assert {:error, %Changeset{} = changeset} = response

      assert errors_on(changeset) == expected_response
    end
  end
end
