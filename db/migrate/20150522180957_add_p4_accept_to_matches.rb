class AddP4AcceptToMatches < ActiveRecord::Migration
  def change
    add_column :matches, :p4Accept, :string
  end
end
