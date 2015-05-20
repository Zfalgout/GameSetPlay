class AddP2ActiveToMatches < ActiveRecord::Migration
  def change
    add_column :matches, :p2Active, :integer
  end
end
