class CreateImages < ActiveRecord::Migration[5.1]
  def change
    create_table :images do |t|
      t.string :description
      t.string :picture
      t.references :category, foreign_key: true

      t.timestamps

    end
    add_index :images, [:category_id, :created_at]
  end
end
