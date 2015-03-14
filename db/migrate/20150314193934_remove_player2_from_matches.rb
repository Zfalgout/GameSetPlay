class RemovePlayer2FromMatches < ActiveRecord::Migration
  def change
    remove_column :matches, :player2, :integer
  end
end
