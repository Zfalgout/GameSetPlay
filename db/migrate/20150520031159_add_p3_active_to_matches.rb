class AddP3ActiveToMatches < ActiveRecord::Migration
  def change
    add_column :matches, :p3Active, :integer
  end
end
