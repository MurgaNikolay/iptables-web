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

ActiveRecord::Schema.define(version: 20150806133916) do

  create_table "access_rules", force: true do |t|
    t.string   "protocol"
    t.string   "port"
    t.string   "ip"
    t.string   "description"
    t.integer  "access_rulable_id"
    t.string   "access_rulable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "node_ips", force: true do |t|
    t.integer  "node_id"
    t.string   "ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "netmask"
    t.string   "interface"
  end

  create_table "nodes", force: true do |t|
    t.string   "name"
    t.string   "hostname"
    t.string   "token"
    t.string   "description"
    t.datetime "last_access"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "has_errors"
    t.text     "report"
  end

  add_index "nodes", ["name"], name: "index_nodes_on_name", unique: true, using: :btree

  create_table "nodes_security_groups", force: true do |t|
    t.integer "node_id"
    t.integer "security_group_id"
  end

  add_index "nodes_security_groups", ["node_id", "security_group_id"], name: "index_nodes_security_groups_on_node_id_and_security_group_id", using: :btree
  add_index "nodes_security_groups", ["node_id"], name: "index_nodes_security_groups_on_node_id", using: :btree

  create_table "security_groups", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "name",                        null: false
    t.string   "email",                       null: false
    t.string   "image"
    t.string   "profile"
    t.string   "uid",              limit: 25
    t.string   "provider",         limit: 20
    t.string   "oauth_token"
    t.datetime "oauth_expires_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "internal"
    t.string   "access_key"
    t.string   "access_token"
  end

  add_index "users", ["access_key"], name: "index_users_on_access_key", using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["provider", "uid"], name: "index_users_on_provider_and_uid", unique: true, using: :btree

end
