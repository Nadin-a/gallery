class FixColumnName < ActiveRecord::Migration[5.1]
  def change
    rename_column :subscriptions, :user, :user_id
    rename_column :subscriptions, :category, :category_id
  end
end
