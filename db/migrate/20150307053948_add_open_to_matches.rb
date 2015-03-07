class AddOpenToMatches < ActiveRecord::Migration
  def change
    add_column :matches, :open, :integer
  end
end
