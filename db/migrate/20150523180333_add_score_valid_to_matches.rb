class AddScoreValidToMatches < ActiveRecord::Migration
  def change
    add_column :matches, :scoreValid, :integer, default: 0
  end
end
