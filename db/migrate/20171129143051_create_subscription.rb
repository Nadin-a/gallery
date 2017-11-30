class CreateSubscription < ActiveRecord::Migration[5.1]
  def change
    create_table :subscriptions do |t|
      t.integer :user
      t.integer :category
    end
  end
end
