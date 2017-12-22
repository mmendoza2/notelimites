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

ActiveRecord::Schema.define(version: 20170612212739) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "agencies", force: :cascade do |t|
    t.string   "name"
    t.integer  "uid",               limit: 8
    t.string   "city"
    t.integer  "category_id",       limit: 8
    t.string   "slug"
    t.string   "facebook_category"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories", force: :cascade do |t|
    t.string   "slug",            limit: 255
    t.string   "name",            limit: 255
    t.string   "image",           limit: 255
    t.string   "photo_file_name", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "categories", ["slug"], name: "index_categories_on_slug", using: :btree

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "events", force: :cascade do |t|
    t.string   "uid"
    t.string   "name",            limit: 255
    t.text     "description"
    t.string   "official_url",    limit: 255
    t.string   "ranking",         limit: 255
    t.integer  "hits"
    t.text     "image"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug",            limit: 255
    t.integer  "user_id"
    t.string   "venue_id"
    t.integer  "attending_count", limit: 8
    t.integer  "category_id",     limit: 8
    t.string   "tm"
    t.datetime "start_date"
    t.datetime "end_date"
    t.string   "supplier_id"
    t.string   "agencie_id"
  end

  add_index "events", ["slug"], name: "index_events_on_slug", using: :btree

  create_table "images", force: :cascade do |t|
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.integer  "venue_id"
    t.integer  "event_id"
    t.integer  "photo_file_size"
    t.string   "photo_file_name",    limit: 255
    t.string   "photo_content_type"
    t.datetime "photo_updated_at"
  end

  create_table "locations", force: :cascade do |t|
    t.string   "slug",        limit: 255
    t.string   "name",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "city",        limit: 255
    t.string   "country",     limit: 255
    t.text     "lat"
    t.text     "lng"
    t.integer  "uid",         limit: 8
    t.boolean  "tm"
    t.string   "supplier_id"
  end

  add_index "locations", ["slug"], name: "index_locations_on_slug", using: :btree

  create_table "relationcategories", force: :cascade do |t|
    t.integer  "follower_id", limit: 8
    t.integer  "followed_id", limit: 8
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "relationcategories", ["followed_id"], name: "index_relationcategories_on_followed_id", using: :btree
  add_index "relationcategories", ["follower_id", "followed_id"], name: "index_relationcategories_on_follower_id_and_followed_id", unique: true, using: :btree
  add_index "relationcategories", ["follower_id"], name: "index_relationcategories_on_follower_id", using: :btree

  create_table "relationevents", force: :cascade do |t|
    t.integer  "follower_id", limit: 8
    t.integer  "followed_id", limit: 8
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "relationevents", ["followed_id"], name: "index_relationevents_on_followed_id", using: :btree
  add_index "relationevents", ["follower_id", "followed_id"], name: "index_relationevents_on_follower_id_and_followed_id", unique: true, using: :btree
  add_index "relationevents", ["follower_id"], name: "index_relationevents_on_follower_id", using: :btree

  create_table "relationships", force: :cascade do |t|
    t.integer  "follower_id", limit: 8
    t.integer  "followed_id", limit: 8
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "relationships", ["followed_id"], name: "index_relationships_on_followed_id", using: :btree
  add_index "relationships", ["follower_id", "followed_id"], name: "index_relationships_on_follower_id_and_followed_id", unique: true, using: :btree
  add_index "relationships", ["follower_id"], name: "index_relationships_on_follower_id", using: :btree

  create_table "relationvenues", force: :cascade do |t|
    t.integer  "follower_id", limit: 8
    t.integer  "followed_id", limit: 8
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "relationvenues", ["followed_id"], name: "index_relationvenues_on_followed_id", using: :btree
  add_index "relationvenues", ["follower_id", "followed_id"], name: "index_relationvenues_on_follower_id_and_followed_id", unique: true, using: :btree
  add_index "relationvenues", ["follower_id"], name: "index_relationvenues_on_follower_id", using: :btree

  create_table "suppliers", force: :cascade do |t|
    t.string   "slug",            limit: 255
    t.string   "name",            limit: 255
    t.string   "image",           limit: 255
    t.string   "photo_file_name", limit: 255
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name",                   limit: 255
    t.string   "email",                  limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token",         limit: 255
    t.boolean  "admin"
    t.string   "slug",                   limit: 255
    t.string   "username",               limit: 255
    t.string   "password",               limit: 255
    t.integer  "gid"
    t.string   "uid",                    limit: 255
    t.string   "provider",               limit: 255
    t.string   "oauth_token",            limit: 255
    t.datetime "oauth_expires_at"
    t.string   "image",                  limit: 255
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.text     "lat"
    t.text     "lng"
    t.boolean  "editor"
    t.string   "auth_token"
    t.boolean  "send_email"
    t.string   "locale"
  end

  add_index "users", ["remember_token"], name: "index_users_on_remember_token", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["slug"], name: "index_users_on_slug", using: :btree

  create_table "venues", force: :cascade do |t|
    t.string   "uid"
    t.string   "name",         limit: 255
    t.string   "slug",         limit: 255
    t.text     "image"
    t.text     "place"
    t.text     "city"
    t.text     "description"
    t.text     "lat"
    t.text     "lng"
    t.boolean  "tm"
    t.text     "official_url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "supplier_id"
    t.integer  "user_id"
  end

  add_index "venues", ["slug"], name: "index_venues_on_slug", using: :btree

end
