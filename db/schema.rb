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

ActiveRecord::Schema.define(version: 2023_03_16_044047) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "ferns", force: :cascade do |t|
    t.string "name"
    t.float "health", default: 7.0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "preferred_contact_method"
    t.bigint "shelf_id"
    t.index ["shelf_id"], name: "index_ferns_on_shelf_id"
  end

  create_table "interactions", force: :cascade do |t|
    t.float "evaluation"
    t.bigint "fern_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "description"
    t.index ["fern_id"], name: "index_interactions_on_fern_id"
  end

  create_table "shelves", force: :cascade do |t|
    t.bigint "user_id"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_shelves_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "google_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "versions", force: :cascade do |t|
    t.string "item_type", null: false
    t.bigint "item_id", null: false
    t.string "event", null: false
    t.string "whodunnit"
    t.text "object"
    t.datetime "created_at"
    t.text "object_changes"
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"
  end

  add_foreign_key "ferns", "shelves"
  add_foreign_key "interactions", "ferns"
  add_foreign_key "shelves", "users"
end
