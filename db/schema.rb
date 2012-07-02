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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120701213529) do

  create_table "collaborators", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.string   "password_digest"
    t.string   "remember_token"
    t.boolean  "admin",           :default => false
    t.string   "street"
    t.string   "number"
    t.string   "hood"
    t.string   "cep"
    t.string   "gender"
    t.date     "brithdate"
    t.string   "fone1"
    t.string   "fone2"
  end

  add_index "collaborators", ["email"], :name => "index_collaborators_on_email", :unique => true
  add_index "collaborators", ["name"], :name => "index_collaborators_on_name"
  add_index "collaborators", ["remember_token"], :name => "index_collaborators_on_remember_token"

  create_table "partners", :force => true do |t|
    t.string   "name"
    t.integer  "collaborator_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.date     "brith_date"
    t.string   "email"
    t.string   "street"
    t.string   "number"
    t.string   "hood"
    t.string   "cep"
    t.string   "gender"
    t.date     "birth_date"
    t.string   "fone1"
    t.string   "fone2"
  end

  add_index "partners", ["cep"], :name => "index_partners_on_cep"
  add_index "partners", ["collaborator_id"], :name => "index_partners_on_collaborator_id"
  add_index "partners", ["gender"], :name => "index_partners_on_gender"
  add_index "partners", ["hood"], :name => "index_partners_on_hood"

end
