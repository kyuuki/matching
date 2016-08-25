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

ActiveRecord::Schema.define(version: 20160804092545) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admin_users", force: :cascade do |t|
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

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "item_available_datetimes", force: :cascade do |t|
    t.integer  "item_id"
    t.datetime "from"
    t.datetime "to"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "item_available_datetimes", ["item_id"], name: "index_item_available_datetimes_on_item_id", using: :btree

  create_table "item_available_japan_places", force: :cascade do |t|
    t.integer  "item_id"
    t.integer  "japan_city_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "item_available_japan_places", ["item_id"], name: "index_item_available_japan_places_on_item_id", using: :btree
  add_index "item_available_japan_places", ["japan_city_id"], name: "index_item_available_japan_places_on_japan_city_id", using: :btree

  create_table "item_services", force: :cascade do |t|
    t.integer  "item_id"
    t.integer  "service_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "item_services", ["item_id"], name: "index_item_services_on_item_id", using: :btree
  add_index "item_services", ["service_id"], name: "index_item_services_on_service_id", using: :btree

  create_table "items", force: :cascade do |t|
    t.integer  "user_id"
    t.text     "detail"
    t.integer  "execution_time"
    t.integer  "price"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "items", ["user_id"], name: "index_items_on_user_id", using: :btree

  create_table "japan_cities", force: :cascade do |t|
    t.integer  "japan_prefecture_id"
    t.string   "code"
    t.string   "name"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  add_index "japan_cities", ["japan_prefecture_id"], name: "index_japan_cities_on_japan_prefecture_id", using: :btree

  create_table "japan_prefectures", force: :cascade do |t|
    t.string   "code"
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "messages", force: :cascade do |t|
    t.integer  "sender_id"
    t.integer  "receiver_id"
    t.text     "body"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "messages", ["receiver_id"], name: "index_messages_on_receiver_id", using: :btree
  add_index "messages", ["sender_id", "receiver_id"], name: "index_messages_on_sender_id_and_receiver_id", using: :btree
  add_index "messages", ["sender_id"], name: "index_messages_on_sender_id", using: :btree

  create_table "services", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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

  add_foreign_key "item_available_datetimes", "items"
  add_foreign_key "item_available_japan_places", "items"
  add_foreign_key "item_available_japan_places", "japan_cities"
  add_foreign_key "item_services", "items"
  add_foreign_key "item_services", "services"
  add_foreign_key "items", "users"
  add_foreign_key "japan_cities", "japan_prefectures"
end
