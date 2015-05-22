class AddPlayer4AcceptToMatches < ActiveRecord::Migration
  def change
    add_column :matches, :player4Accept, :integer
  end
end
