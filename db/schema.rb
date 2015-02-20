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

ActiveRecord::Schema.define(version: 20150220144552) do

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "birthday"
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
    t.string   "city"
    t.string   "state"
    t.integer  "zip"
    t.integer  "num_friends"
    t.integer  "years_played"
    t.text     "about"
    t.string   "gender"
    t.string   "preference_of_play"
    t.integer  "age"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.string   "password_digest"
  end

end
