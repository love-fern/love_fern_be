class RenameType < ActiveRecord::Migration[5.2]
  def change
    rename_column :interactions, :type, :evaluation
  end
end
