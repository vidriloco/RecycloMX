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

ActiveRecord::Schema.define(version: 20150419191211) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "postgis"

  create_table "appointments", force: true do |t|
    t.integer  "offer_id"
    t.datetime "meeting_time"
    t.string   "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "deposits", force: true do |t|
    t.spatial  "coordinates", limit: {:srid=>4326, :type=>"point", :geographic=>true}
    t.string   "name"
    t.text     "details"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "locations", force: true do |t|
    t.spatial  "coordinates", limit: {:srid=>4326, :type=>"point", :geographic=>true}
    t.string   "address"
    t.boolean  "is_default"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "messages", force: true do |t|
    t.string   "body"
    t.integer  "user_id"
    t.integer  "proposal_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "offers", force: true do |t|
    t.integer  "kind"
    t.decimal  "quantity"
    t.integer  "location_id"
    t.integer  "user_id"
    t.text     "details"
    t.boolean  "published",         default: false
    t.integer  "quantifiable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "offer_image"
  end

  create_table "proposals", force: true do |t|
    t.integer  "offer_id"
    t.integer  "status"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "full_name"
    t.integer  "role"
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "phone"
    t.boolean  "accepted_privacy_note"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "bio"
    t.string   "twitter"
    t.string   "facebook"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "avatar"
    t.string   "v_password"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
