class AddSlugToAll < ActiveRecord::Migration[5.1]
  def change
    add_column :categories, :slug, :string, unique: true
    add_column :images, :slug, :string, unique: true
  end
end
