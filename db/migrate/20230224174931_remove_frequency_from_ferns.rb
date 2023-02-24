class RemoveFrequencyFromFerns < ActiveRecord::Migration[5.2]
  def change
    remove_column :ferns, :frequency, :string
  end
end
