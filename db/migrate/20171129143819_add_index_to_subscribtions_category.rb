class AddIndexToSubscribtionsCategory < ActiveRecord::Migration[5.1]
  def change
    add_index :subscriptions, :category
    add_index :subscriptions, [:user, :category], unique: true
  end
end
