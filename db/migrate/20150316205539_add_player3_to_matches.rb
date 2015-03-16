class AddPlayer3ToMatches < ActiveRecord::Migration
  def change
    add_column :matches, :player3, :string
  end
end
