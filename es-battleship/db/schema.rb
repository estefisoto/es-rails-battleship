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

ActiveRecord::Schema.define(version: 20160215034021) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "games", force: :cascade do |t|
    t.integer  "active_player_count", default: 1
    t.integer  "status",              default: 0
    t.integer  "turn",                default: 1
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  create_table "locations", force: :cascade do |t|
    t.integer  "x"
    t.integer  "y"
    t.integer  "state",      default: 0
    t.integer  "ship_id"
    t.integer  "ocean_id"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "locations", ["ocean_id"], name: "index_locations_on_ocean_id", using: :btree
  add_index "locations", ["ship_id"], name: "index_locations_on_ship_id", using: :btree

  create_table "oceans", force: :cascade do |t|
    t.integer  "game_id"
    t.integer  "player_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "oceans", ["game_id"], name: "index_oceans_on_game_id", using: :btree
  add_index "oceans", ["player_id"], name: "index_oceans_on_player_id", using: :btree

  create_table "players", force: :cascade do |t|
    t.string   "token"
    t.integer  "game_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "players", ["game_id"], name: "index_players_on_game_id", using: :btree

  create_table "ships", force: :cascade do |t|
    t.string   "kind"
    t.boolean  "sunk_state"
    t.integer  "ocean_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "ships", ["ocean_id"], name: "index_ships_on_ocean_id", using: :btree

end
