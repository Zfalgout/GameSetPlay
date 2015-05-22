class AddPlayer3AcceptToMatches < ActiveRecord::Migration
  def change
    add_column :matches, :player3Accept, :integer
  end
end
