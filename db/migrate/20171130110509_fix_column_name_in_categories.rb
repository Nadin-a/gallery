class FixColumnNameInCategories < ActiveRecord::Migration[5.1]
  def change
    rename_column :categories, :user_id, :owner_id
  end
end
