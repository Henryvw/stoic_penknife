class CreateEQuestions < ActiveRecord::Migration[5.2]
  def change
    create_table :e_questions do |t|
      t.integer :exercise_id
      t.text :question

      t.timestamps
    end
  end
end
