class AddPlayer2ToMatches < ActiveRecord::Migration
  def change
    add_column :matches, :player2, :string
  end
end
