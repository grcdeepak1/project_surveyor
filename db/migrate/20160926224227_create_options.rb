class CreateOptions < ActiveRecord::Migration[5.0]
  def change
    create_table :options do |t|
      t.text :text
      t.integer :question_id

      t.timestamps
    end
  end
end
