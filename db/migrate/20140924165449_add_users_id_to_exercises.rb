# frozen_string_literal: true

class AddUsersIdToExercises < ActiveRecord::Migration
  def change
    add_column :exercises, :user_id, :integer
  end
end
