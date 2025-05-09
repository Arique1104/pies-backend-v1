# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_05_08_175755) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "dismissed_keywords", force: :cascade do |t|
    t.string "word"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "category"
    t.text "example"
    t.index ["word", "category"], name: "index_dismissed_keywords_on_word_and_category", unique: true
    t.index ["word"], name: "index_dismissed_keywords_on_word", unique: true
  end

  create_table "event_hosts", force: :cascade do |t|
    t.bigint "event_id", null: false
    t.bigint "membership_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_event_hosts_on_event_id"
    t.index ["membership_id"], name: "index_event_hosts_on_membership_id"
  end

  create_table "events", force: :cascade do |t|
    t.bigint "organization_id", null: false
    t.string "title"
    t.text "description"
    t.datetime "date"
    t.string "location"
    t.bigint "created_by_membership_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["organization_id"], name: "index_events_on_organization_id"
  end

  create_table "favorite_tips", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "reflection_tip_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["reflection_tip_id"], name: "index_favorite_tips_on_reflection_tip_id"
    t.index ["user_id", "reflection_tip_id"], name: "index_favorite_tips_on_user_id_and_reflection_tip_id", unique: true
    t.index ["user_id"], name: "index_favorite_tips_on_user_id"
  end

  create_table "memberships", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "organization_id", null: false
    t.string "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["organization_id"], name: "index_memberships_on_organization_id"
    t.index ["user_id"], name: "index_memberships_on_user_id"
  end

  create_table "organizations", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pies_entries", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "event_id"
    t.integer "physical"
    t.text "physical_description"
    t.integer "intellectual"
    t.text "intellectual_description"
    t.integer "emotional"
    t.text "emotional_description"
    t.integer "spiritual"
    t.text "spiritual_description"
    t.date "checked_in_on"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_pies_entries_on_event_id"
    t.index ["user_id"], name: "index_pies_entries_on_user_id"
  end

  create_table "reflection_tips", force: :cascade do |t|
    t.string "keyword"
    t.string "category"
    t.text "tip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tip_ratings", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "reflection_tip_id", null: false
    t.boolean "helpful"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["reflection_tip_id"], name: "index_tip_ratings_on_reflection_tip_id"
    t.index ["user_id"], name: "index_tip_ratings_on_user_id"
  end

  create_table "unmatched_keywords", force: :cascade do |t|
    t.string "word"
    t.string "category"
    t.integer "count"
    t.text "example"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "super_user"
  end

  add_foreign_key "event_hosts", "events"
  add_foreign_key "event_hosts", "memberships"
  add_foreign_key "events", "memberships", column: "created_by_membership_id"
  add_foreign_key "events", "organizations"
  add_foreign_key "favorite_tips", "reflection_tips"
  add_foreign_key "favorite_tips", "users"
  add_foreign_key "memberships", "organizations"
  add_foreign_key "memberships", "users"
  add_foreign_key "pies_entries", "events"
  add_foreign_key "pies_entries", "users"
  add_foreign_key "tip_ratings", "reflection_tips"
  add_foreign_key "tip_ratings", "users"
end
