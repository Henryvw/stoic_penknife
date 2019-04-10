# frozen_string_literal: true

class AddPublishToDoctrines < ActiveRecord::Migration[5.0]
  def change
    add_column :doctrines, :publish, :boolean
  end
end
