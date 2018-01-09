class RoomsAndMessages < ActiveRecord::Migration[5.1]
  def change
    add_reference :rooms, :user, foreign_key: true
    add_index :rooms, [:user_id, :created_at]
  end
end
