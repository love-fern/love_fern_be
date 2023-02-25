class RenameInteractions < ActiveRecord::Migration[5.2]
  def change
    rename_table :interactions_tables, :interactions
  end
end
