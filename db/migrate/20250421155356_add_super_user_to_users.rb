class AddSuperUserToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :super_user, :boolean
  end
end
