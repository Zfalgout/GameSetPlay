class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.datetime :birthday
      t.decimal :user_rating
      t.decimal :NTRP_rating
      t.integer :wins
      t.integer :losses
      t.decimal :win_pct
      t.integer :total_matches_played
      t.integer :tournament_matches_won
      t.integer :tournament_matches_lost
      t.integer :tournaments_won
      t.integer :challenge_matches_won
      t.integer :challenge_matches_lost
      t.integer :challenges_posted
      t.integer :challenges_accepted
      t.string :city
      t.string :state
      t.integer :zip
      t.integer :num_friends
      t.integer :years_played
      t.text :about
      t.string :gender
      t.string :preference_of_play
      t.integer :age

      t.timestamps null: false
    end
  end
end
