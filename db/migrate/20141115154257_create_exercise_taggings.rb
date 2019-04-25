class CreateExerciseTaggings < ActiveRecord::Migration[5.2]
  def change
    create_table :exercise_taggings do |t|
      t.belongs_to :tag, index: true
      t.belongs_to :exercise, index: true

      t.timestamps
    end
  end
end
