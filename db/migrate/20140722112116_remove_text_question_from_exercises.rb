# frozen_string_literal: true

class RemoveTextQuestionFromExercises < ActiveRecord::Migration
  def change
    remove_column :exercises, :text_question, :text
  end
end
