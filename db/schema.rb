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

ActiveRecord::Schema.define(version: 20160520043510) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "comments", force: :cascade do |t|
    t.text     "body",       null: false
    t.integer  "sailing_id", null: false
    t.integer  "user_id",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "rating"
    t.string   "title"
  end

  add_index "comments", ["sailing_id"], name: "index_comments_on_sailing_id", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "communities", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text     "page_data"
  end

  create_table "feeds", force: :cascade do |t|
    t.string   "body",                               null: false
    t.integer  "type",         limit: 2, default: 0, null: false
    t.integer  "community_id",                       null: false
    t.integer  "user_id",                            null: false
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  add_index "feeds", ["community_id"], name: "index_feeds_on_community_id", using: :btree
  add_index "feeds", ["user_id"], name: "index_feeds_on_user_id", using: :btree

  create_table "images", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.integer  "user_id",     null: false
    t.string   "filename"
    t.string   "filetype"
    t.integer  "filesize"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "description"
  end

  add_index "images", ["user_id"], name: "index_images_on_user_id", using: :btree

  create_table "marinas", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "members", force: :cascade do |t|
    t.integer  "user_id",                            null: false
    t.integer  "community_id",                       null: false
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.integer  "type",         limit: 2, default: 0, null: false
  end

  add_index "members", ["community_id"], name: "index_members_on_community_id", using: :btree
  add_index "members", ["user_id", "community_id"], name: "index_members_on_user_id_and_community_id", unique: true, using: :btree
  add_index "members", ["user_id"], name: "index_members_on_user_id", using: :btree

  create_table "participants", force: :cascade do |t|
    t.integer  "sailing_id", null: false
    t.integer  "user_id",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "participants", ["sailing_id"], name: "index_participants_on_sailing_id", using: :btree
  add_index "participants", ["user_id", "sailing_id"], name: "index_participants_on_user_id_and_sailing_id", unique: true, using: :btree
  add_index "participants", ["user_id"], name: "index_participants_on_user_id", using: :btree

  create_table "sailings", force: :cascade do |t|
    t.string   "name"
    t.integer  "community_id"
    t.integer  "ship_id"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.tsrange  "duration"
    t.tsrange  "invite_duration"
    t.integer  "capacity",        default: 5, null: false
  end

  add_index "sailings", ["community_id"], name: "index_sailings_on_community_id", using: :btree
  add_index "sailings", ["ship_id"], name: "index_sailings_on_ship_id", using: :btree

  create_table "ships", force: :cascade do |t|
    t.string   "name",         null: false
    t.integer  "user_id"
    t.integer  "community_id"
    t.integer  "marina_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "ships", ["community_id"], name: "index_ships_on_community_id", using: :btree
  add_index "ships", ["marina_id"], name: "index_ships_on_marina_id", using: :btree
  add_index "ships", ["user_id"], name: "index_ships_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.string   "token"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.boolean  "admin",                  default: false, null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "comments", "sailings"
  add_foreign_key "comments", "users"
  add_foreign_key "feeds", "communities"
  add_foreign_key "feeds", "users"
  add_foreign_key "images", "users"
  add_foreign_key "members", "communities"
  add_foreign_key "members", "users"
  add_foreign_key "participants", "sailings"
  add_foreign_key "participants", "users"
  add_foreign_key "sailings", "communities"
  add_foreign_key "sailings", "ships"
  add_foreign_key "ships", "communities"
  add_foreign_key "ships", "marinas"
  add_foreign_key "ships", "users"
end
