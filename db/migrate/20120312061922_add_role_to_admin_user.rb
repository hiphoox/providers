class AddRoleToAdminUser < ActiveRecord::Migration
  def change
    add_column :admin_users, :isAdmin, :boolean

  end
end
