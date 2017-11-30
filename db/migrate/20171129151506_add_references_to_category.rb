class AddReferencesToCategory < ActiveRecord::Migration[5.1]
  def change
    add_reference :categories, :user, foreign_key: true
    add_index :categories, [:user_id, :created_at]
  end
end
