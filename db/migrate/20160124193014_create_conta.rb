class CreateConta < ActiveRecord::Migration
  def change
    create_table "conta" do |t|
      t.integer  "correntista_id"
      t.string   "flag_ativo",     limit: 1,                          default: "S"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.decimal  "saldo",                    precision: 20, scale: 2
    end

  end
end
