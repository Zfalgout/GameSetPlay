class AddValidator3ToMatches < ActiveRecord::Migration
  def change
    add_column :matches, :validator3, :integer
  end
end
