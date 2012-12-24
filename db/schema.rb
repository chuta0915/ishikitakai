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

ActiveRecord::Schema.define(:version => 20121224074436) do

  create_table "admins", :force => true do |t|
    t.string    "name"
    t.timestamp "created_at",                         :null => false
    t.timestamp "updated_at",                         :null => false
    t.string    "email",              :default => "", :null => false
    t.string    "encrypted_password", :default => "", :null => false
    t.integer   "sign_in_count",      :default => 0
    t.timestamp "current_sign_in_at"
    t.timestamp "last_sign_in_at"
    t.string    "current_sign_in_ip"
    t.string    "last_sign_in_ip"
  end

  add_index "admins", ["email"], :name => "idx_email_on_admins", :unique => true

  create_table "attendences", :force => true do |t|
    t.integer   "event_id",   :null => false
    t.integer   "user_id",    :null => false
    t.integer   "level_id",   :null => false
    t.string    "content"
    t.timestamp "created_at", :null => false
    t.timestamp "updated_at", :null => false
  end

  add_index "attendences", ["event_id"], :name => "idx_event_id_on_attendences"
  add_index "attendences", ["user_id", "event_id"], :name => "idx_user_id_event_id_on_attendences", :unique => true

  create_table "chats", :force => true do |t|
    t.integer   "group_id"
    t.integer   "user_id",    :null => false
    t.text      "content",    :null => false
    t.timestamp "created_at", :null => false
    t.timestamp "updated_at", :null => false
  end

  add_index "chats", ["group_id"], :name => "idx_group_id_on_chats"

  create_table "comments", :force => true do |t|
    t.string   "commentable_type", :null => false
    t.integer  "commentable_id",   :null => false
    t.integer  "user_id",          :null => false
    t.text     "content"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "comments", ["commentable_type", "commentable_id"], :name => "idx_commentable_on_comments"
  add_index "comments", ["user_id"], :name => "idx_user_id_on_comments"

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "event_payment_kinds", :force => true do |t|
    t.string    "name"
    t.timestamp "created_at", :null => false
    t.timestamp "updated_at", :null => false
    t.integer   "priority"
  end

  add_index "event_payment_kinds", ["priority"], :name => "idx_priority_on_event_payment_kinds"

  create_table "events", :force => true do |t|
    t.integer   "user_id",               :null => false
    t.integer   "group_id"
    t.integer   "scope_id",              :null => false
    t.string    "name",                  :null => false
    t.text      "content"
    t.text      "summary",               :null => false
    t.string    "place_url"
    t.string    "place_name",            :null => false
    t.string    "place_address"
    t.string    "place_map_url"
    t.integer   "capacity_min",          :null => false
    t.integer   "capacity_max",          :null => false
    t.timestamp "begin_at"
    t.timestamp "end_at"
    t.timestamp "receive_begin_at"
    t.timestamp "receive_end_at"
    t.integer   "event_payment_kind_id", :null => false
    t.integer   "fee"
    t.timestamp "created_at",            :null => false
    t.timestamp "updated_at",            :null => false
  end

  add_index "events", ["group_id"], :name => "idx_group_id_on_events"
  add_index "events", ["user_id"], :name => "idx_user_id_on_events"

  create_table "groups", :force => true do |t|
    t.string    "name",       :null => false
    t.text      "summary",    :null => false
    t.text      "content"
    t.integer   "scope_id",   :null => false
    t.timestamp "created_at", :null => false
    t.timestamp "updated_at", :null => false
  end

  add_index "groups", ["name"], :name => "idx_name_on_groups"

  create_table "kpts", :force => true do |t|
    t.integer   "group_id",                  :null => false
    t.integer   "user_id"
    t.string    "name"
    t.integer   "status",     :default => 1, :null => false
    t.timestamp "created_at",                :null => false
    t.timestamp "updated_at",                :null => false
    t.integer   "priority"
  end

  create_table "levels", :force => true do |t|
    t.string    "name",       :null => false
    t.integer   "priority",   :null => false
    t.timestamp "created_at", :null => false
    t.timestamp "updated_at", :null => false
  end

  add_index "levels", ["priority"], :name => "idx_priority_on_levels"

  create_table "memberships", :force => true do |t|
    t.integer   "group_id",   :null => false
    t.integer   "user_id",    :null => false
    t.integer   "level_id",   :null => false
    t.timestamp "created_at", :null => false
    t.timestamp "updated_at", :null => false
  end

  add_index "memberships", ["group_id"], :name => "idx_group_id_on_memberships"
  add_index "memberships", ["user_id", "group_id", "level_id"], :name => "idx_user_id_group_id_level_id_on_memberships", :unique => true

  create_table "notifications", :force => true do |t|
    t.integer   "user_id"
    t.string    "type"
    t.string    "trigger_type"
    t.integer   "trigger_id"
    t.string    "name"
    t.text      "content"
    t.boolean   "read",         :default => false, :null => false
    t.timestamp "read_at"
    t.timestamp "created_at",                      :null => false
    t.timestamp "updated_at",                      :null => false
  end

  add_index "notifications", ["user_id", "read"], :name => "idx_user_id_read_on_notifications"

  create_table "providers", :force => true do |t|
    t.string    "name",       :null => false
    t.timestamp "created_at", :null => false
    t.timestamp "updated_at", :null => false
  end

  create_table "providers_users", :force => true do |t|
    t.integer   "provider_id",   :null => false
    t.integer   "user_id",       :null => false
    t.string    "user_key",      :null => false
    t.string    "access_token",  :null => false
    t.string    "refresh_token"
    t.string    "secret"
    t.string    "name",          :null => false
    t.string    "email"
    t.string    "image",         :null => false
    t.timestamp "created_at",    :null => false
    t.timestamp "updated_at",    :null => false
  end

  add_index "providers_users", ["provider_id", "user_key"], :name => "idx_provider_id_user_key_on_providers_users", :unique => true
  add_index "providers_users", ["user_id"], :name => "idx_user_id_on_providers_users"

  create_table "rails_admin_histories", :force => true do |t|
    t.text      "message"
    t.string    "username"
    t.integer   "item"
    t.string    "table"
    t.integer   "month"
    t.integer   "year"
    t.timestamp "created_at", :null => false
    t.timestamp "updated_at", :null => false
  end

  add_index "rails_admin_histories", ["item", "table", "month", "year"], :name => "index_rails_admin_histories"

  create_table "scopes", :force => true do |t|
    t.string    "name",       :null => false
    t.integer   "priority",   :null => false
    t.timestamp "created_at", :null => false
    t.timestamp "updated_at", :null => false
  end

  add_index "scopes", ["priority"], :name => "idx_priority_on_scopes"

  create_table "tasks", :force => true do |t|
    t.integer   "group_id",          :null => false
    t.string    "name",              :null => false
    t.boolean   "done"
    t.integer   "created_user_id"
    t.integer   "completed_user_id"
    t.timestamp "created_at",        :null => false
    t.timestamp "updated_at",        :null => false
  end

  add_index "tasks", ["group_id"], :name => "idx_group_id_on_tasks"

  create_table "user_settings", :force => true do |t|
    t.integer  "user_id",                              :null => false
    t.boolean  "mail_attend_status", :default => true, :null => false
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at",                           :null => false
    t.boolean  "mail_event_comment", :default => true, :null => false
  end

  add_index "user_settings", ["user_id"], :name => "idx_user_id_on_user_settings", :unique => true

  create_table "users", :force => true do |t|
    t.string    "email"
    t.timestamp "remember_created_at"
    t.integer   "sign_in_count",         :default => 0
    t.timestamp "current_sign_in_at"
    t.timestamp "last_sign_in_at"
    t.string    "current_sign_in_ip"
    t.string    "last_sign_in_ip"
    t.timestamp "created_at",                            :null => false
    t.timestamp "updated_at",                            :null => false
    t.string    "name",                  :default => "", :null => false
    t.string    "image",                 :default => "", :null => false
    t.integer   "default_provider_id",   :default => 1,  :null => false
    t.string    "unconfirmed_email"
    t.timestamp "confirm_limit_at"
    t.string    "hash_to_confirm_email"
  end

  add_index "users", ["email"], :name => "idx_email_on_users", :unique => true

  create_table "versions", :force => true do |t|
    t.string    "item_type",  :null => false
    t.integer   "item_id",    :null => false
    t.string    "event",      :null => false
    t.string    "whodunnit"
    t.text      "object"
    t.timestamp "created_at"
  end

  add_index "versions", ["item_type", "item_id"], :name => "index_versions_on_item_type_and_item_id"

  create_table "wikis", :force => true do |t|
    t.string    "parent_type", :null => false
    t.integer   "parent_id",   :null => false
    t.integer   "user_id"
    t.string    "name"
    t.text      "content",     :null => false
    t.timestamp "created_at",  :null => false
    t.timestamp "updated_at",  :null => false
  end

  add_index "wikis", ["parent_type", "parent_id"], :name => "idx_parent_type_parent_id_on_wikis"

end
