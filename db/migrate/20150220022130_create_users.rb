class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.datetime :birthday
      t.decimal :user_rating, :default => '0.0'
      t.decimal :NTRP_rating, :default => '2.0'
      t.integer :wins, :default => '0'
      t.integer :losses, :default => '0'
      t.decimal :win_pct, :default => '0.0'
      t.integer :total_matches_played, :default => '0'
      t.integer :tournament_matches_won, :default => '0'
      t.integer :tournament_matches_lost, :default => '0'
      t.integer :tournaments_won, :default => '0'
      t.integer :challenge_matches_won, :default => '0'
      t.integer :challenge_matches_lost, :default => '0'
      t.integer :challenges_posted, :default => '0'
      t.integer :challenges_accepted, :default => '0'
      t.string :city
      t.string :state
      t.integer :zip
      t.integer :num_friends, :default => '0'
      t.integer :years_played
      t.text :about
      t.string :gender
      t.string :preference_of_play
      t.integer :age

      t.timestamps null: false
    end
  end
end
