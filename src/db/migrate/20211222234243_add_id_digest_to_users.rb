class AddIdDigestToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :id_digest, :string
  end
end
