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

ActiveRecord::Schema.define(:version => 20120825151718) do

  create_table "admins", :force => true do |t|
    t.string   "name"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.string   "email",              :default => "", :null => false
    t.string   "encrypted_password", :default => "", :null => false
    t.integer  "sign_in_count",      :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
  end

  add_index "admins", ["email"], :name => "idx_email_on_admins", :unique => true

  create_table "attendences", :force => true do |t|
    t.integer  "event_id",   :null => false
    t.integer  "user_id",    :null => false
    t.integer  "level_id",   :null => false
    t.string   "content"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "attendences", ["event_id"], :name => "idx_group_id_on_attendences"
  add_index "attendences", ["user_id", "event_id"], :name => "idx_user_id_event_id_on_attendences", :unique => true

  create_table "event_payment_kinds", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "events", :force => true do |t|
    t.integer  "user_id",               :null => false
    t.integer  "group_id"
    t.integer  "scope_id",              :null => false
    t.string   "name",                  :null => false
    t.text     "content"
    t.text     "summary",               :null => false
    t.string   "place_url"
    t.string   "place_name",            :null => false
    t.string   "place_address"
    t.string   "place_map_url"
    t.integer  "capacity_min",          :null => false
    t.integer  "capacity_max",          :null => false
    t.datetime "begin_at"
    t.datetime "end_at"
    t.datetime "receive_begin_at"
    t.datetime "receive_end_at"
    t.integer  "event_payment_kind_id", :null => false
    t.integer  "fee"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
  end

  add_index "events", ["group_id"], :name => "idx_group_id_on_events"
  add_index "events", ["user_id"], :name => "idx_user_id_on_events"

  create_table "groups", :force => true do |t|
    t.string   "name",       :null => false
    t.text     "summary",    :null => false
    t.text     "content"
    t.integer  "scope_id",   :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "groups", ["name"], :name => "idx_name_on_groups"

  create_table "levels", :force => true do |t|
    t.string   "name",       :null => false
    t.integer  "priority",   :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "levels", ["priority"], :name => "idx_priority_on_levels"

  create_table "memberships", :force => true do |t|
    t.integer  "group_id",   :null => false
    t.integer  "user_id",    :null => false
    t.integer  "level_id",   :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "memberships", ["group_id"], :name => "idx_group_id_on_memberships"
  add_index "memberships", ["user_id", "group_id", "level_id"], :name => "idx_user_id_group_id_level_id_on_memberships", :unique => true

  create_table "providers", :force => true do |t|
    t.string   "name",       :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "providers_users", :force => true do |t|
    t.integer  "provider_id",   :null => false
    t.integer  "user_id",       :null => false
    t.string   "user_key",      :null => false
    t.string   "access_token",  :null => false
    t.string   "refresh_token"
    t.string   "secret"
    t.string   "name",          :null => false
    t.string   "email"
    t.string   "image",         :null => false
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "providers_users", ["provider_id", "user_key"], :name => "idx_provider_id_user_key_on_providers_users", :unique => true
  add_index "providers_users", ["user_id"], :name => "idx_user_id_on_providers_users"

  create_table "rails_admin_histories", :force => true do |t|
    t.text     "message"
    t.string   "username"
    t.integer  "item"
    t.string   "table"
    t.integer  "month",      :limit => 2
    t.integer  "year",       :limit => 5
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
  end

  add_index "rails_admin_histories", ["item", "table", "month", "year"], :name => "index_rails_admin_histories"

  create_table "scopes", :force => true do |t|
    t.string   "name",       :null => false
    t.integer  "priority",   :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "scopes", ["priority"], :name => "idx_priority_on_scopes"

  create_table "users", :force => true do |t|
    t.string   "email"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",       :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at",                          :null => false
    t.string   "name",                :default => "", :null => false
    t.string   "image",               :default => "", :null => false
    t.integer  "default_provider_id", :default => 1,  :null => false
  end

  add_index "users", ["email"], :name => "idx_email_on_users", :unique => true

end
