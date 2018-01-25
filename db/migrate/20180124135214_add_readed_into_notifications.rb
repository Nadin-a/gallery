class AddReadedIntoNotifications < ActiveRecord::Migration[5.1]
  def change
    add_column :notifications, :readed, :boolean, default: false
    Notification.where(readed: false).update_all(readed: true)
  end
end
