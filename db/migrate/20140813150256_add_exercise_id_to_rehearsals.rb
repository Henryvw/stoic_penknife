class AddExerciseIdToRehearsals < ActiveRecord::Migration
  def change
    add_column :rehearsals, :exercise_id, :integer
  end
end
