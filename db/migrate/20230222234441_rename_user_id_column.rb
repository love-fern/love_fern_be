class RenameUserIdColumn < ActiveRecord::Migration[5.2]
  def change
    rename_column :users, :user_id, :google_id
  end
end
