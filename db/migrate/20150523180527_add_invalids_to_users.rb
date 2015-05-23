class AddInvalidsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :invalids, :integer
  end
end
