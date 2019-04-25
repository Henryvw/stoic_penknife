class RemoveTextQuestionFromExercises < ActiveRecord::Migration[5.2]
  def change
    remove_column :exercises, :text_question, :text
  end
end
