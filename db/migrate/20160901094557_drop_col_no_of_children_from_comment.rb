class DropColNoOfChildrenFromComment < ActiveRecord::Migration
  def change
  	remove_column :comments, :no_of_children
  end
end
