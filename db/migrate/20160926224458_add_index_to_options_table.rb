class AddIndexToOptionsTable < ActiveRecord::Migration[5.0]
  def change
    add_index :options, :question_id
  end
end
