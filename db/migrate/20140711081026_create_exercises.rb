class CreateExercises < ActiveRecord::Migration
  def change
    create_table :exercises do |t|
      t.string :title
      t.string :general_description
      t.text :text_question

      t.timestamps
    end
  end
end
