class AddSettingsIntoUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :receive_emails, :boolean, default: true
  end
end
