class AddUsersIdToRehearsals < ActiveRecord::Migration[5.2]
  def change
    add_column :rehearsals, :user_id, :integer
  end
end
