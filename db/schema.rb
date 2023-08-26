# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_08_26_095856) do
  create_table "game_matches", force: :cascade do |t|
    t.datetime "start_time"
    t.datetime "end_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "kills", force: :cascade do |t|
    t.integer "killer_id"
    t.integer "victim_id"
    t.string "cause_of_death"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "game_match_id", null: false
    t.index ["game_match_id"], name: "index_kills_on_game_match_id"
    t.index ["killer_id"], name: "index_kills_on_killer_id"
    t.index ["victim_id"], name: "index_kills_on_victim_id"
  end

  create_table "players", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "kills", "game_matches"
  add_foreign_key "kills", "players", column: "killer_id"
  add_foreign_key "kills", "players", column: "victim_id"
end
