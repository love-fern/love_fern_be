class CreateFerns < ActiveRecord::Migration[5.2]
  def change
    create_table :ferns do |t|
      t.string :name
      t.integer :duration
      t.string :attributes
      t.integer :health, default: 6

      t.timestamps
    end
  end
end
