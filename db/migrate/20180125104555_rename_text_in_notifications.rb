class RenameTextInNotifications < ActiveRecord::Migration[5.1]
  def change
    rename_column :notifications, :text, :type_of_notification
    add_column :notifications, :participant, :string
    add_column :notifications, :object, :string
  end
end
