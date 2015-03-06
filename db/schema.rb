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

ActiveRecord::Schema.define(version: 20150306224450) do

  create_table "matches", force: :cascade do |t|
    t.integer  "player1"
    t.integer  "player2"
    t.text     "location"
    t.datetime "time"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "game_type"
    t.boolean  "open"
  end

  add_index "matches", ["user_id", "created_at"], name: "index_matches_on_user_id_and_created_at"
  add_index "matches", ["user_id"], name: "index_matches_on_user_id"

  create_table "relationships", force: :cascade do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "relationships", ["followed_id"], name: "index_relationships_on_followed_id"
  add_index "relationships", ["follower_id", "followed_id"], name: "index_relationships_on_follower_id_and_followed_id", unique: true
  add_index "relationships", ["follower_id"], name: "index_relationships_on_follower_id"

  create_table "user_matches", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "match_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "user_matches", ["match_id"], name: "index_user_matches_on_match_id"
  add_index "user_matches", ["user_id", "match_id"], name: "index_user_matches_on_user_id_and_match_id", unique: true
  add_index "user_matches", ["user_id"], name: "index_user_matches_on_user_id"

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.decimal  "user_rating"
    t.decimal  "NTRP_rating"
    t.integer  "wins"
    t.integer  "losses"
    t.decimal  "win_pct"
    t.integer  "total_matches_played"
    t.integer  "tournament_matches_won"
    t.integer  "tournament_matches_lost"
    t.integer  "tournaments_won"
    t.integer  "challenge_matches_won"
    t.integer  "challenge_matches_lost"
    t.integer  "challenges_posted"
    t.integer  "challenges_accepted"
    t.integer  "zip"
    t.integer  "num_friends"
    t.integer  "years_played"
    t.text     "about"
    t.string   "gender"
    t.string   "preference_of_play"
    t.integer  "age"
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.string   "password_digest"
    t.string   "remember_digest"
    t.boolean  "admin",                   default: false
    t.string   "activation_digest"
    t.boolean  "activated",               default: false
    t.datetime "activated_at"
    t.string   "reset_digest"
    t.datetime "reset_sent_at"
  end

end
