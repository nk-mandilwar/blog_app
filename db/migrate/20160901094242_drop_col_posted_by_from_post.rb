class DropColPostedByFromPost < ActiveRecord::Migration
  def change
  	remove_column :posts, :posted_by
  end
end
