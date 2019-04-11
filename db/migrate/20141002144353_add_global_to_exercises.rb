class AddGlobalToExercises < ActiveRecord::Migration
  def change
    add_column :exercises, :global, :boolean
  end
end
