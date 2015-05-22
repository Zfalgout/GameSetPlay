class AddP2AcceptToMatches < ActiveRecord::Migration
  def change
    add_column :matches, :p2Accept, :string
  end
end
