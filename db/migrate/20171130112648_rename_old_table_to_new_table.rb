class RenameOldTableToNewTable < ActiveRecord::Migration[5.1]
  def change
    rename_table :subscriptions, :categories_users
  end
end
