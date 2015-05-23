class AddValidatedToMatches < ActiveRecord::Migration
  def change
    add_column :matches, :validated, :integer
  end
end
