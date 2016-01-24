json.array!(@deposito) do |deposito|
  json.extract! deposito, :id, :id, :valor, :conta_destino_id, :conta_origem_id
  json.url deposito_url(deposito, format: :json)
end
