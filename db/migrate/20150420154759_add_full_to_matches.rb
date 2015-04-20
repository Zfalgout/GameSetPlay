class AddFullToMatches < ActiveRecord::Migration
  def change
    add_column :matches, :full, :boolean
  end
end
