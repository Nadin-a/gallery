class AddSlugToRoom < ActiveRecord::Migration[5.1]
  def change
    add_column :rooms, :slug, :string, unique: true
  end
end
