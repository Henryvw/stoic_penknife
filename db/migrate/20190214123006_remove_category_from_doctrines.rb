# frozen_string_literal: true

class RemoveCategoryFromDoctrines < ActiveRecord::Migration[5.0]
  def change
    remove_column :doctrines, :category, :string
  end
end
