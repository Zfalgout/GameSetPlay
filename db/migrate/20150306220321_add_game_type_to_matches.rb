class AddGameTypeToMatches < ActiveRecord::Migration
  def change
    add_column :matches, :game_type, :string
  end
end
