class RemoveDurationFromFerns < ActiveRecord::Migration[5.2]
  def change
    remove_column :ferns, :duration
  end
end
