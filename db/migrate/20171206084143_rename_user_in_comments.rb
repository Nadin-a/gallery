class RenameUserInComments < ActiveRecord::Migration[5.1]
  def change
    rename_column :comments, :user_id, :author_id
  end
end
