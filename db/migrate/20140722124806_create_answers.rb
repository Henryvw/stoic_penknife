class CreateAnswers < ActiveRecord::Migration[5.2]
  def change
    create_table :answers do |t|
      t.integer :e_question_id
      t.text :answer

      t.timestamps
    end
  end
end
