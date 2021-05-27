defmodule RockeliveryWeb.UsersControllerTest do
  use RockeliveryWeb.ConnCase, async: true

  import Mox

  import Rockelivery.Factory

  alias Rockelivery.User
  alias Rockelivery.ViaCep.ClientMock
  alias RockeliveryWeb.Auth.Guardian

  describe "create/2" do
    test "when all params are valid, creates the user", %{conn: conn} do
      params = build(:user_body)

      expect(ClientMock, :get_cep_info, fn _cep ->
        {:ok, build(:cep_info)}
      end)

      response =
        conn
        |> post(Routes.users_path(conn, :create, params))
        |> json_response(:created)

      assert %{
               "message" => "User created!",
               "user" => %{
                 "address" => "Rua 15",
                 "age" => 27,
                 "cep" => "41250400",
                 "cpf" => "12345678900",
                 "email" => "grhamm@email.com",
                 "id" => _id,
                 "name" => "Grhamm"
               }
             } = response
    end

    test "when there is some error, returns an error", %{conn: conn} do
      params = build(:user_body, cep: "1234567")

      response =
        conn
        |> post(Routes.users_path(conn, :create, params))
        |> json_response(:bad_request)

      expected_response = %{"message" => %{"cep" => ["should be 8 character(s)"]}}

      assert expected_response == response
    end
  end

  describe "delete/2" do
    setup %{conn: conn} do
      user = insert(:user)
      {:ok, token, _claims} = Guardian.encode_and_sign(user)
      conn = put_req_header(conn, "authorization", "Bearer #{token}")

      {:ok, conn: conn}
    end

    test "when there is a user with the given id, deletes the user", %{conn: conn} do
      id = "5484b227-0f8f-4e84-ab01-41fd7c4c43dc"

      response =
        conn
        |> delete(Routes.users_path(conn, :delete, id))
        |> response(:no_content)

      assert response == ""
    end
  end

  describe "update/2" do
    setup %{conn: conn} do
      user = insert(:user)
      {:ok, token, _claims} = Guardian.encode_and_sign(user)
      conn = put_req_header(conn, "authorization", "Bearer #{token}")

      {:ok, conn: conn, user: user}
    end

    test "when all params are valid, updates the user", %{conn: conn, user: user} do
      %User{id: id} = user

      params = %{
        "name" => "joao"
      }

      response =
        conn
        |> put(Routes.users_path(conn, :update, id, params))
        |> json_response(:ok)

      assert %{
               "user" => %{
                 "address" => "Rua 15",
                 "age" => 27,
                 "cep" => "12345678",
                 "cpf" => "12345678900",
                 "email" => "grhamm@email.com",
                 "id" => _id,
                 "name" => "joao"
               }
             } = response
    end
  end
end
