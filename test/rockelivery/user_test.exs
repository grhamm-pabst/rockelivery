defmodule Rockelivery.UserTest do
  use Rockelivery.DataCase, async: true

  import Rockelivery.Factory

  alias Ecto.Changeset
  alias Rockelivery.User

  describe "changeset/2" do
    test "when all params are valid, returns a valid changeset" do
      params = build(:user_params)

      response = User.changeset(params)

      assert %Changeset{changes: %{name: "Grhamm"}, valid?: true} = response
    end

    test "when updating a changeset, returns a value of changeset with the given changes" do
      params = build(:user_params)

      update_params = %{name: "Banana"}

      response =
        params
        |> User.changeset()
        |> User.changeset(update_params)

      assert %Changeset{changes: %{name: "Banana"}, valid?: true} = response
    end

    test "when there are some error, returns an invalid changeset" do
      params =
        build(:user_params,
          age: 15,
          cep: "1234567",
          cpf: "1234567890",
          email: "grhammemail.com",
          password: "123"
        )

      response = User.changeset(params)

      expected_response = %{
        age: ["must be greater than or equal to 18"],
        password: ["should be at least 6 character(s)"],
        cep: ["should be 8 character(s)"],
        cpf: ["should be 11 character(s)"],
        email: ["has invalid format"]
      }

      assert errors_on(response) == expected_response
    end
  end
end
