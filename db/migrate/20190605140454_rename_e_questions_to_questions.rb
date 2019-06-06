class RenameEQuestionsToQuestions < ActiveRecord::Migration[5.2]
  def change
    rename_table :e_questions, :questions
  end
end
