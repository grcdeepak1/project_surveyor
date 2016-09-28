class AddColumnsToAnswerTable < ActiveRecord::Migration[5.0]
  def change
    add_column :answers, :survey_id, :integer
    add_column :answers, :response_id, :integer
  end
end
