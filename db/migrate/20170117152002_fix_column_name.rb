# frozen_string_literal: true

class FixColumnName < ActiveRecord::Migration[5.0]
  def change
    change_table :quotation_taggings do |t|
      t.rename :meditation_id, :quotation_id
    end
  end
end
