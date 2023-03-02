class AddDescriptionToInteractions < ActiveRecord::Migration[5.2]
  def change
    add_column :interactions, :description, :string
  end
end
