class AddCountLevelToComments < ActiveRecord::Migration
  def change
    add_column :comments, :no_of_children, :integer, :default => 0
    add_column :comments, :level, :integer, :default => 0
  end
end
