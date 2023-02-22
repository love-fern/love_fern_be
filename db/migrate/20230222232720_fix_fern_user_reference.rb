class FixFernUserReference < ActiveRecord::Migration[5.2]
  def change
    remove_column :ferns, :users_id
    add_reference :ferns, :user, foreign_key: true
  end
end
