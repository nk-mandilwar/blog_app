class AddSalToReplies < ActiveRecord::Migration
  def change
    add_column :replies, :sal, :integer
  end
end
