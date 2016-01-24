json.array!(@conta) do |conta|
  json.extract! conta, :id, :id, :correntista_id, :flag_ativo, :created_at, :updated_at, :saldo
  json.url conta_url(conta, format: :json)
end
