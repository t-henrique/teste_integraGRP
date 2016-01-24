json.array!(@correntista) do |correntista|
  json.extract! correntista, :id, :id, :cpf, :nome, :datanascimento, :endereco, :numero, :bairro, :cidade, :estado
  json.url correntista_url(correntista, format: :json)
end
