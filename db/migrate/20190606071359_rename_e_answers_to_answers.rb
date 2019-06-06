class RenameEAnswersToAnswers < ActiveRecord::Migration[5.2]
  def change
    rename_table :e_answers, :answers
  end
end
