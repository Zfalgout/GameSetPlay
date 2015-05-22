class AddP3ActiveToMatches < ActiveRecord::Migration
  def change
    add_column :matches, :p3Active, :integer, default: 0
  end
end
