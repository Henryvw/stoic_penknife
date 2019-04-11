class ChangeExerciseDescriptionColumn < ActiveRecord::Migration[5.0]
  def up
    change_column :exercises, :general_description, :text
  end

  def down
    change_column :exercises, :general_description, :string
  end
end
