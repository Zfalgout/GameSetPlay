class AddPlayer3ActiveToMatches < ActiveRecord::Migration
  def change
    add_column :matches, :player3Active, :boolean, default: 0
  end
end
