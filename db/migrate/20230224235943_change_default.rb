class ChangeDefault < ActiveRecord::Migration[5.2]
  def change
    change_column_default :ferns, :health, 7
  end
end
