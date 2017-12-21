class AddCoverToCategories < ActiveRecord::Migration[5.1]
  def change
    add_column :categories, :cover, :string
  end
end
