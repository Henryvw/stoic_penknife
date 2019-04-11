class RemoveCategoryFromExercises < ActiveRecord::Migration[5.0]
  def change
    remove_column :exercises, :category, :string
  end
end
