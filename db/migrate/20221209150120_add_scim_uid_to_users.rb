class AddScimUidToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :scim_uid, :string
  end
end
