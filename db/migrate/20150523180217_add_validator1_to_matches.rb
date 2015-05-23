class AddValidator1ToMatches < ActiveRecord::Migration
  def change
    add_column :matches, :validator1, :integer
  end
end
