class DropExerciseTaggings < ActiveRecord::Migration[5.2]
  def up
    drop_table :exercise_taggings
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
