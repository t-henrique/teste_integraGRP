class CreateSaque < ActiveRecord::Migration
  def change
    create_table "deposito" do |t|
      t.decimal  "valor",                      precision: 20, scale: 2
      t.datetime "created_at"
      t.string   "conta_destino_id", limit: 6,                          null: false
      t.string   "conta_origem_id",  limit: 6
      t.decimal  "taxa",                       precision: 10, scale: 2
    end
  end
end
