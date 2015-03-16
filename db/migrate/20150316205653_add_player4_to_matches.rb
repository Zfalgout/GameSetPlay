class AddPlayer4ToMatches < ActiveRecord::Migration
  def change
    add_column :matches, :player4, :string
  end
end
