class AddTitleIntoImages < ActiveRecord::Migration[5.1]
  def change
    add_column :images, :title, :string
    add_index :images, :title, unique: true
  end
end
