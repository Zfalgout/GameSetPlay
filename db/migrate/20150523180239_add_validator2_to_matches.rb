class AddValidator2ToMatches < ActiveRecord::Migration
  def change
    add_column :matches, :validator2, :integer
  end
end
