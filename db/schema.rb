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

ActiveRecord::Schema.define(version: 20150623050355) do

  create_table "historians", force: :cascade do |t|
    t.string   "name"
    t.text     "address"
    t.text     "btc_tip_address"
    t.text     "bit_msg_address"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.text     "txn_id"
  end

  create_table "history_records", force: :cascade do |t|
    t.text     "title"
    t.text     "http_api_address"
    t.text     "fields_to_store"
    t.string   "rate"
    t.boolean  "public"
    t.integer  "historian_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.text     "txn_id"
    t.text     "data_points"
    t.text     "data_point_txn_id"
    t.datetime "scheduled_date"
    t.boolean  "schedule_status"
  end

  create_table "hr_data_points", force: :cascade do |t|
    t.string   "txn_id"
    t.integer  "history_record_id"
    t.text     "data_points"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

end
