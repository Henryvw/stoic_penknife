class MoveExerciseTaggingsColumnDataToTaggingsTable < ActiveRecord::Migration[5.2]
  class ExerciseTagging < ActiveRecord::Base
  end

  def change
    ExerciseTagging.find_each do |et|
      new_tagging = Tagging.create(
        tag_id: et.tag_id,
        tagable_type: 'Exercise',
        tagable_id: et.exercise_id
      )
      new_tagging.save!
    end
  end
end
