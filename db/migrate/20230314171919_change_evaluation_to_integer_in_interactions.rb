class ChangeEvaluationToIntegerInInteractions < ActiveRecord::Migration[5.2]
  def up
    change_column :interactions, :evaluation, 'float USING(CASE evaluation WHEN \'Positive\' THEN 2 WHEN \'Negative\' THEN -2 ELSE 0 END)'
  end

  def down
    change_column :interactions, :evaluation, 'varchar USING(CASE WHEN evaluation>0 THEN \'Positive\' WHEN evaluation<0 THEN \'Negative\' ELSE \'Neutral\' END)'
  end
end
