class AddZipToMatches < ActiveRecord::Migration
  def change
    add_column :matches, :zip, :integer
  end
end
