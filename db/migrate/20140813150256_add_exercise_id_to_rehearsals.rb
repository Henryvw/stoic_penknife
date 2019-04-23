class AddExerciseIdToRehearsals < ActiveRecord::Migration[5.2]
  def change
    add_column :rehearsals, :exercise_id, :integer
  end
end
