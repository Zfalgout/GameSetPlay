class RemoveBirthdayFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :birthday, :datetime
  end
end
