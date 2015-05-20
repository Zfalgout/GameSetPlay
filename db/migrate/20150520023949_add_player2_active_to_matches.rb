class AddPlayer2ActiveToMatches < ActiveRecord::Migration
  def change
    add_column :matches, :player2Active, :boolean, default: 0
  end
end
