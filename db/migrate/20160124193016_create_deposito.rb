class CreateDeposito < ActiveRecord::Migration
  def change
    create_table "saque" do |t|
      t.decimal  "valor",                precision: 20, scale: 2
      t.datetime "created_at"
      t.string   "conta_id",   limit: 6,                          null: false
    end
  end
end
