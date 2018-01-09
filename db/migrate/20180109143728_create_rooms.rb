class CreateRooms < ActiveRecord::Migration[5.1]
  def change
    create_table :rooms do |t|
      t.string :name

      t.timestamps
    end
    add_index :rooms, :name
  end
end
