class FixFernUserReference < ActiveRecord::Migration[5.2]
  def change
    add_reference :ferns, :user, foreign_key: true
  end
end
