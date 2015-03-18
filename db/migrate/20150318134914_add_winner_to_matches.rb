class AddWinnerToMatches < ActiveRecord::Migration
  def change
    add_column :matches, :winner, :string
  end
end
