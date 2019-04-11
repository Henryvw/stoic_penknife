class AddUsersIdToRehearsals < ActiveRecord::Migration
  def change
    add_column :rehearsals, :user_id, :integer
  end
end
