class AddP4ActiveToMatches < ActiveRecord::Migration
  def change
    add_column :matches, :p4Active, :integer
  end
end
