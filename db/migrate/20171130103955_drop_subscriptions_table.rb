class DropSubscriptionsTable < ActiveRecord::Migration[5.1]
  def up
    drop_table :subscriptions
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
