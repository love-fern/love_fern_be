class ChangeAttributesColumn < ActiveRecord::Migration[5.2]
  def change
    rename_column :ferns, :attributes, :tag
  end
end
