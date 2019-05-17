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

ActiveRecord::Schema.define(version: 2019_05_09_201108) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "cube"
  enable_extension "earthdistance"
  enable_extension "hstore"
  enable_extension "plpgsql"

  create_table "hours", id: :serial, force: :cascade do |t|
    t.integer "preschool_id"
    t.integer "day_of_week"
    t.time "opens"
    t.time "closes"
    t.string "note"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["day_of_week"], name: "index_hours_on_day_of_week"
    t.index ["preschool_id"], name: "index_hours_on_preschool_id"
  end

  create_table "preschool_urls", id: :serial, force: :cascade do |t|
    t.integer "preschool_id"
    t.string "url"
    t.string "hours_element"
    t.string "extras_element"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["preschool_id"], name: "index_preschool_urls_on_preschool_id"
  end

  create_table "preschools", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "url"
    t.string "street_name"
    t.string "postal_code"
    t.string "city"
    t.string "note"
    t.point "position"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["position"], name: "index_preschools_on_position", using: :gist
  end

  create_table "site_changes", id: :serial, force: :cascade do |t|
    t.integer "preschool_id"
    t.string "state"
    t.hstore "data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "note"
    t.index ["preschool_id"], name: "index_site_changes_on_preschool_id"
  end

  create_table "temp_hours", force: :cascade do |t|
    t.bigint "preschool_id"
    t.datetime "opens_at"
    t.datetime "closes_at"
    t.boolean "closed_for_day", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["preschool_id"], name: "index_temp_hours_on_preschool_id"
  end

end
