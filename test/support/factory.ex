defmodule Rockelivery.Factory do
  use ExMachina.Ecto, repo: Rockelivery.Repo

  alias Rockelivery.User

  def user_params_factory do
    %{
      age: 27,
      address: "Rua 15",
      cep: "41250400",
      cpf: "12345678900",
      email: "grhamm@email.com",
      password: "123456",
      name: "Grhamm"
    }
  end

  def user_body_factory do
    %{
      "age" => 27,
      "address" => "Rua 15",
      "cep" => "41250400",
      "cpf" => "12345678900",
      "email" => "grhamm@email.com",
      "password" => "123456",
      "name" => "Grhamm"
    }
  end

  def user_factory do
    %User{
      id: "5484b227-0f8f-4e84-ab01-41fd7c4c43dc",
      age: 27,
      address: "Rua 15",
      cep: "12345678",
      cpf: "12345678900",
      email: "grhamm@email.com",
      password: "123456",
      name: "Grhamm"
    }
  end

  def cep_info_factory do
    %{
      "bairro" => "Sé",
      "cep" => "01001-000",
      "complemento" => "lado ímpar",
      "ddd" => "11",
      "gia" => "1004",
      "ibge" => "3550308",
      "localidade" => "São Paulo",
      "logradouro" => "Praça da Sé",
      "siafi" => "7107",
      "uf" => "SP"
    }
  end
end
