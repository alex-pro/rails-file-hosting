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

ActiveRecord::Schema.define(version: 20150730142000) do

  create_table "addresses", force: :cascade do |t|
    t.integer  "profile_id",   limit: 4
    t.string   "country",      limit: 255
    t.string   "city",         limit: 255
    t.string   "street",       limit: 255
    t.string   "house_number", limit: 255
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "folders", force: :cascade do |t|
    t.text     "name",       limit: 65535
    t.integer  "user_id",    limit: 4
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.integer  "parent_id",  limit: 4
  end

  add_index "folders", ["user_id"], name: "fk_rails_130d1ba9d1", using: :btree

  create_table "items", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.string   "file",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "token",      limit: 255
    t.string   "name",       limit: 255
    t.integer  "folder_id",  limit: 4
  end

  create_table "profiles", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "photo",      limit: 255
    t.datetime "birthday"
  end

  add_index "profiles", ["name"], name: "index_profiles_on_name", using: :btree
  add_index "profiles", ["user_id"], name: "index_profiles_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",           limit: 255
    t.string   "password_digest", limit: 255
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_foreign_key "folders", "users"
end
