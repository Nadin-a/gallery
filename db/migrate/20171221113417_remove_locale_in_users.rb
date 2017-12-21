class RemoveLocaleInUsers < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :locale
  end
end
