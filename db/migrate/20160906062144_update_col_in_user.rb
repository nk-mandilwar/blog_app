class UpdateColInUser < ActiveRecord::Migration
  def change
  	remove_column :users, :facebook_profile
  	add_column :users, :twitter_profile, :string
  end
end
