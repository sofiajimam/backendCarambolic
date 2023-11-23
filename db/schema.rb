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

ActiveRecord::Schema[7.0].define(version: 2023_11_23_015241) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "acts", force: :cascade do |t|
    t.string "title"
    t.string "body"
    t.string "image"
    t.bigint "story_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["story_id"], name: "index_acts_on_story_id"
  end

  create_table "bookmarks", force: :cascade do |t|
    t.string "title"
    t.string "url"
    t.string "thumbnail"
    t.string "summary"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.boolean "is_true"
    t.index ["user_id"], name: "index_bookmarks_on_user_id"
  end

  create_table "stories", force: :cascade do |t|
    t.string "title"
    t.string "url"
    t.string "thumbnail"
    t.boolean "is_public"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "bookmark_id"
    t.index ["bookmark_id"], name: "index_stories_on_bookmark_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "username"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "acts", "stories"
  add_foreign_key "bookmarks", "users"
  add_foreign_key "stories", "bookmarks"
end
