class AddColumnsToAdmins < ActiveRecord::Migration[5.2]
  def change
    add_column :admins, :provider, :string
    add_column :admins, :uid, :string
    add_column :admins, :username, :string
  end
end
