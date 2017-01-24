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

ActiveRecord::Schema.define(version: 20170124103014) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "hours", force: :cascade do |t|
    t.integer "preschool_id"
    t.integer "day_of_week"
    t.time    "opens"
    t.time    "closes"
    t.string  "note"
  end

  create_table "preschools", force: :cascade do |t|
    t.string "name"
    t.string "url"
    t.string "street_name"
    t.string "postal_code"
    t.string "city"
    t.string "note"
  end

end
