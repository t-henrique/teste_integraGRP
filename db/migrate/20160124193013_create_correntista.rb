class CreateCorrentista < ActiveRecord::Migration
  def change
    create_table "correntista" do |t|
      t.string   "cpf",            limit: 11
      t.string   "nome",           limit: 50
      t.date     "datanascimento"
      t.string   "endereco",       limit: 255
      t.integer  "numero"
      t.string   "bairro",         limit: 50
      t.string   "cidade",         limit: 50
      t.string   "estado",         limit: 2
      t.datetime "created_at"
      t.integer  "users_id"
    end

    add_index "correntista", ["users_id"], name: "fki_users_id", using: :btree

  end
end
