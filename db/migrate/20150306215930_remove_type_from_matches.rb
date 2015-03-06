class RemoveTypeFromMatches < ActiveRecord::Migration
  def change
    remove_column :matches, :type, :integer
  end
end
