class ChangeHealthOnFernToFloat < ActiveRecord::Migration[5.2]
  def change
    change_column :ferns, :health, :float
  end
end
