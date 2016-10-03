class AddSecurityAnsToSubscribe < ActiveRecord::Migration
  def change
    add_column :subscribes, :security_ans, :string
  end
end
