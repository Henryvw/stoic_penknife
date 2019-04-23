class AddUsersIdToExercises < ActiveRecord::Migration[5.2]
  def change
    add_column :exercises, :user_id, :integer
  end
end
