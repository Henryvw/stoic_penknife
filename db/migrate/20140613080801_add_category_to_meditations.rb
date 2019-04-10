# frozen_string_literal: true

class AddCategoryToMeditations < ActiveRecord::Migration
  def change
    add_column :meditations, :category, :string
  end
end
