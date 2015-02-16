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

<<<<<<< HEAD
ActiveRecord::Schema.define(version: 20150121124117) do
=======
ActiveRecord::Schema.define(version: 20150215164210) do

  create_table "beer_clubs", force: :cascade do |t|
    t.string   "name"
    t.integer  "founded"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end
>>>>>>> 8dc108030267d845e1014cd7846504698dbb5c67

  create_table "beers", force: :cascade do |t|
    t.string   "name"
    t.integer  "brewery_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "style_id"
  end

  create_table "breweries", force: :cascade do |t|
    t.string   "name"
    t.integer  "year"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "memberships", force: :cascade do |t|
    t.integer  "beer_club_id"
    t.integer  "user_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "ratings", force: :cascade do |t|
    t.integer  "score"
    t.integer  "beer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
  end

  create_table "styles", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

<<<<<<< HEAD
=======
  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "password_digest"
  end

>>>>>>> 8dc108030267d845e1014cd7846504698dbb5c67
end
