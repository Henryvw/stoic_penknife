class RemoveCategoryFromExercises < ActiveRecord::Migration[5.2]
  def change
    remove_column :exercises, :category, :string
  end
end
