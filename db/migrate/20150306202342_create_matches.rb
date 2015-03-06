class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.integer :player1
      t.integer :player2
      t.text :location
      t.datetime :time
      t.string :type
      t.boolean :public
      t.references :user, index: true

      t.timestamps null: false
    end
    add_index :matches, [:user_id, :created_at]
  end
end
