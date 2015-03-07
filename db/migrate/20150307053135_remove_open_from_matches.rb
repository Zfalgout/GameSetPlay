class RemoveOpenFromMatches < ActiveRecord::Migration
  def change
    remove_column :matches, :open, :boolean
  end
end
