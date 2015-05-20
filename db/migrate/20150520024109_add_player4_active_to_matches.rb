class AddPlayer4ActiveToMatches < ActiveRecord::Migration
  def change
    add_column :matches, :player4Active, :boolean, default: 0
  end
end
