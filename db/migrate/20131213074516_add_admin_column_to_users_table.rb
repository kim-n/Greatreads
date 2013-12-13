class AddAdminColumnToUsersTable < ActiveRecord::Migration
  def change
    add_column :users, :admin, :integer, :default => -1
  end
end
