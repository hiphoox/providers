class AddAttributesToAdminUser < ActiveRecord::Migration
  def change
    add_column :admin_users, :name, :string

    add_column :admin_users, :contact_name, :string

    add_column :admin_users, :phone_number, :string

  end
end
