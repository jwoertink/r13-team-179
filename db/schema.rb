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

ActiveRecord::Schema.define(version: 20131020043822) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "interests", force: true do |t|
    t.string   "email"
    t.string   "gender"
    t.integer  "profile_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "interests", ["profile_id"], name: "index_interests_on_profile_id", using: :btree

  create_table "profiles", force: true do |t|
    t.string   "ip_address"
    t.string   "email"
    t.string   "video"
    t.string   "url_key"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "question_ids", default: [], array: true
  end

  add_index "profiles", ["url_key"], name: "index_profiles_on_url_key", using: :btree

  create_table "questions", force: true do |t|
    t.string   "text"
    t.string   "category"
    t.string   "video"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "questions", ["category"], name: "index_questions_on_category", using: :btree

end
