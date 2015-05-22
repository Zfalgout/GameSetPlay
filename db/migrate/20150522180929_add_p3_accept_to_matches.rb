class AddP3AcceptToMatches < ActiveRecord::Migration
  def change
    add_column :matches, :p3Accept, :string
  end
end
