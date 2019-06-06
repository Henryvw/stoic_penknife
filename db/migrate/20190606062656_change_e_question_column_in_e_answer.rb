class ChangeEQuestionColumnInEAnswer < ActiveRecord::Migration[5.2]
  def change
    rename_column :e_answers, :e_question_id, :question_id
  end
end
