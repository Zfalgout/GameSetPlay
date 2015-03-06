class CreateUserMatches < ActiveRecord::Migration
  def change
    create_table :user_matches do |t|
      t.integer :user_id
      t.integer :match_id

      t.timestamps null: false
    end
    add_index :user_matches, :user_id
    add_index :user_matches, :match_id
    add_index :user_matches, [:user_id, :match_id], unique: true
  end
end
