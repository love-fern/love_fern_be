class AddFernsToShelves < ActiveRecord::Migration[5.2]
  def change
    add_reference :ferns, :shelf, foreign_key: true
    remove_column :shelves, :shelf_id
  end
end
