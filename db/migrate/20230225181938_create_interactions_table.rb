class CreateInteractionsTable < ActiveRecord::Migration[5.2]
  def change
    create_table :interactions_tables do |t|
      t.string :type
      t.references :fern, foreign_key: true
      t.timestamps
    end
  end
end
