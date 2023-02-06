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

ActiveRecord::Schema[7.0].define(version: 2023_02_06_004407) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", precision: nil, null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", precision: nil, null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "addresses", force: :cascade do |t|
    t.string "street1", null: false
    t.string "street2"
    t.string "city", null: false
    t.string "state", limit: 2, null: false
    t.string "zip", null: false
    t.float "latitude"
    t.float "longitude"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["latitude", "longitude"], name: "index_addresses_on_latitude_and_longitude"
  end

  create_table "books", force: :cascade do |t|
    t.string "title"
    t.string "author"
    t.string "img_url"
    t.integer "page_count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["title", "author"], name: "index_books_on_title_and_author", unique: true
  end

  create_table "github_repos", force: :cascade do |t|
    t.string "organization"
    t.string "project"
    t.integer "category"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.jsonb "data", default: {}
    t.index ["organization", "project"], name: "index_github_repos_on_organization_and_project", unique: true
  end

  create_table "locations", force: :cascade do |t|
    t.integer "service_web_resource_id", null: false
    t.integer "address_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["service_web_resource_id", "address_id"], name: "index_locations_on_service_web_resource_id_and_address_id", unique: true
  end

  create_table "phones", force: :cascade do |t|
    t.integer "location_id", null: false
    t.string "number", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["location_id", "number"], name: "index_phones_on_location_id_and_number", unique: true
  end

  create_table "service_web_resources", force: :cascade do |t|
    t.string "name", null: false
    t.string "desc", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_service_web_resources_on_name"
  end

  create_table "sunny_episode_user_rankings", force: :cascade do |t|
    t.integer "user_id"
    t.integer "better_episode_id"
    t.integer "worse_episode_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["better_episode_id", "user_id"], name: "index_seur_on_beid_and_uid"
  end

  create_table "sunny_episodes", force: :cascade do |t|
    t.string "title", null: false
    t.text "description"
    t.integer "number", null: false
    t.integer "season", null: false
    t.integer "episode", null: false
    t.date "airdate", null: false
    t.string "tvmaze_link", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["number"], name: "index_sunny_episodes_on_number", unique: true
    t.index ["season", "episode"], name: "index_sunny_episodes_on_season_and_episode", unique: true
  end

  create_table "user_books", force: :cascade do |t|
    t.integer "user_id"
    t.integer "book_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "book_id"], name: "index_user_books_on_user_id_and_book_id", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
end
