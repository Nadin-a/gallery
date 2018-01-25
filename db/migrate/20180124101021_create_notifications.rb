class CreateNotifications < ActiveRecord::Migration[5.1]
  def change
    create_table :notifications do |t|
      t.string :text
      t.timestamps
    end
    add_reference :notifications, :user, foreign_key: true
    add_index :notifications, [:user_id, :created_at]
  end
end
