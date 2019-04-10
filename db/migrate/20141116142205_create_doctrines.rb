# frozen_string_literal: true

class CreateDoctrines < ActiveRecord::Migration
  def change
    create_table :doctrines do |t|
      t.string :file_name

      t.timestamps
    end
  end
end
