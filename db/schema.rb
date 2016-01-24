# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160124193019) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "conta", force: :cascade do |t|
    t.integer  "correntista_id"
    t.string   "flag_ativo",     limit: 1,                          default: "S"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "saldo",                    precision: 20, scale: 2
  end

  create_table "correntista", force: :cascade do |t|
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

  create_table "deposito", force: :cascade do |t|
    t.decimal  "valor",                      precision: 20, scale: 2
    t.datetime "created_at"
    t.string   "conta_destino_id", limit: 6,                          null: false
    t.string   "conta_origem_id",  limit: 6
    t.decimal  "taxa",                       precision: 10, scale: 2
  end

  create_table "saque", force: :cascade do |t|
    t.decimal  "valor",                precision: 20, scale: 2
    t.datetime "created_at"
    t.string   "conta_id",   limit: 6,                          null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "conta", "correntista", name: "conta_correntista_id_fkey"
  add_foreign_key "correntista", "users", column: "users_id", name: "users_id"
end
