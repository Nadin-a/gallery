class AddIndexToSubscribtionsUser < ActiveRecord::Migration[5.1]
  def change
    add_index :subscriptions, :user
  end
end
