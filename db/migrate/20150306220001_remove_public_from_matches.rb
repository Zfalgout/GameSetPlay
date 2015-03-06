class RemovePublicFromMatches < ActiveRecord::Migration
  def change
    remove_column :matches, :public, :boolean
  end
end
