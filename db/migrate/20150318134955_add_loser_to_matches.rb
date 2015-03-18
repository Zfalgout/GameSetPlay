class AddLoserToMatches < ActiveRecord::Migration
  def change
    add_column :matches, :loser, :string
  end
end
