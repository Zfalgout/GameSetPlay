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

ActiveRecord::Schema.define(version: 20150523182356) do

  create_table "matches", force: :cascade do |t|
    t.integer  "player1"
    t.text     "location"
    t.datetime "time"
    t.integer  "user_id"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.string   "game_type"
    t.integer  "open"
    t.string   "player2"
    t.string   "player3"
    t.string   "player4"
    t.string   "winner"
    t.string   "loser"
    t.string   "score"
    t.boolean  "full"
    t.integer  "zip"
    t.boolean  "player2Active", default: false
    t.boolean  "player3Active", default: false
    t.boolean  "player4Active", default: false
    t.integer  "p2Active",      default: 0
    t.integer  "p3Active",      default: 0
    t.integer  "p4Active",      default: 0
    t.string   "p2Accept"
    t.string   "p3Accept"
    t.string   "p4Accept"
    t.integer  "player2Accept"
    t.integer  "player3Accept"
    t.integer  "player4Accept"
    t.integer  "validator1"
    t.integer  "validator2"
    t.integer  "validator3"
    t.integer  "scoreValid",    default: 0
    t.integer  "validated"
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
    t.decimal  "user_rating",             default: 0.0
    t.decimal  "NTRP_rating",             default: 2.0
    t.integer  "wins",                    default: 0
    t.integer  "losses",                  default: 0
    t.decimal  "win_pct",                 default: 0.0
    t.integer  "total_matches_played",    default: 0
    t.integer  "tournament_matches_won",  default: 0
    t.integer  "tournament_matches_lost", default: 0
    t.integer  "tournaments_won",         default: 0
    t.integer  "challenge_matches_won",   default: 0
    t.integer  "challenge_matches_lost",  default: 0
    t.integer  "challenges_posted",       default: 0
    t.integer  "challenges_accepted",     default: 0
    t.integer  "zip"
    t.integer  "num_friends",             default: 0
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
    t.integer  "invalids"
  end

end
