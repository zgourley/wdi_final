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

ActiveRecord::Schema.define(version: 20150203045131) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "albums", force: true do |t|
    t.string   "name"
    t.integer  "year_released"
    t.string   "running_time"
    t.integer  "band_id"
    t.integer  "genre_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "albums", ["band_id"], name: "index_albums_on_band_id", using: :btree
  add_index "albums", ["genre_id"], name: "index_albums_on_genre_id", using: :btree

  create_table "bands", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "genres", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "songs", force: true do |t|
    t.string   "name"
    t.string   "running_time"
    t.integer  "track"
    t.integer  "album_id"
    t.integer  "band_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "songs", ["album_id"], name: "index_songs_on_album_id", using: :btree
  add_index "songs", ["band_id"], name: "index_songs_on_band_id", using: :btree

end
