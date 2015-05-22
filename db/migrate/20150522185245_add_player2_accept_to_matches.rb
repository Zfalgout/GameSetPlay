class AddPlayer2AcceptToMatches < ActiveRecord::Migration
  def change
    add_column :matches, :player2Accept, :integer
  end
end
